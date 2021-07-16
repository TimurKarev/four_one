import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/payment_schedule_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/providers/providers.dart';
import 'package:four_one/four_one/security/security_view_model.dart';
import 'package:four_one/four_one/ui/data_table_income_dialog.dart';
import 'package:four_one/four_one/ui/reusable_widgets/big_number_text_widget.dart';
import 'package:four_one/four_one/ui/reusable_widgets/data_table_tooltip.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/tables/big_table_view_model.dart';

import '../edit_payment_dialog.dart';
import '../ready_date_edit_dialog.dart';

class MainTableWidget extends ConsumerWidget {
  MainTableWidget({required data, colWidth, Key? key}) : super(key: key) {
    _data = data;
    _colWidths = [
      150.0,
      400.0,
      150.0,
      150.0,
      150.0,
      150.0,
      150.0,
    ];
    if (colWidth != null) {
      _colWidths[1] = colWidth;
    }
  }

  late final TableModel _data;

  final double _multiRowHeight = 16.0;

  late final List<double> _colWidths;

  double get tableWidth => _colWidths.fold(0, (p, e) => p + e);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(bigTableProvider);
    final data = viewModel.getTableModel(_data);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container()),
          _getTable(context, data),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _getTable(BuildContext context, TableModel model) {
    final data = model.rowList;
    return Container(
      width: tableWidth,
      child: Column(
        children: [
          TotalsWidget(model: model),
          _getTableHeader(context),
          getTotalsRow(context, model),
          Expanded(
            child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, i) => _getRow(context, data[i]),
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox getTotalsRow(BuildContext context, TableModel model) {
    final rowValues = [
      '',
      '',
      '',
      '',
      //context.read(bigTableDataProvider).debt.toString(),
      model.debt.toString(),
      '',
      //context.read(bigTableDataProvider).futureIncome.toString(),
      model.futureIncome.toString(),
    ];
    final colors = {
      4: Colors.red,
      6: Colors.green,
    };
    return SizedBox(
      height: 50.0,
      child: Row(
        children: rowValues
            .asMap()
            .entries
            .map(
              (entry) => SizedBox(
                width: _colWidths[entry.key],
                child: rowValues[entry.key] == ''
                    ? Container()
                    : Text(
                        getFormatNum(rowValues[entry.key]),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: colors.containsKey(entry.key)
                              ? colors[entry.key]
                              : Colors.black,
                        ),
                      ),
              ),
            )
            .toList(),
      ),
    );
  }

  SizedBox _getTableHeader(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        children: BigTableModel.columns
            .asMap()
            .entries
            .map(
              (entre) => SizedBox(
                width: _colWidths[entre.key],
                child: TextButton(
                  onPressed: () {
                    context.read(bigTableProvider).sort = entre.key;
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      entre.value,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _getRow(BuildContext context, BigTableModel row) {
    PaymentScheduleModel futurePayments = row.futureIncomes;
    final canEdit = context.read(securityProvider).isUserCanEditOrder;
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: _colWidths[0],
            child: DataTableTooltip(
                message: '${row.contract}', child: Text(row.client)),
          ),
          SizedBox(
            width: _colWidths[1],
            child: canEdit
                ? DataTableTooltip(
                    message: 'готовность - ${formatDate(row.finishDate)}',
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return ReadyDateEditDialog(model: row);
                            });
                      },
                      child: Align(
                        child: Text('${row.object} (${row.order})'),
                        alignment: Alignment.centerLeft,
                      ),
                    ))
                : Text('${row.object} (${row.order})'),
          ),
          SizedBox(
            width: _colWidths[2],
            child: DataTableTooltip(
              message: row.paymentLegend,
              child: canEdit
                  ? TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return EditPaymentDialog(model: row);
                            });
                      },
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child:
                              BigNumberTextWidget(number: row.sum.toString())),
                    )
                  : BigNumberTextWidget(number: row.sum.toString()),
            ),
          ),
          SizedBox(
            width: _colWidths[3],
            child: DataTableTooltip(
              message: row.incomeString,
              child: Align(
                alignment: Alignment.centerLeft,
                //TODO: add button here
                child: canEdit
                    ? DataTableIncomeDialog(model: row)
                    : BigNumberTextWidget(number: row.incomeSum.toString()),
              ),
            ),
          ),
          SizedBox(
            width: _colWidths[4],
            child: DataTableTooltip(
              message: row.debtString,
              child: BigNumberTextWidget(number: row.debt.toString()),
            ),
          ),
          SizedBox(
            width: _colWidths[5],
            child: Column(
              children: futurePayments.payments
                  .asMap()
                  .entries
                  .map(
                    (entry) => Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: _multiRowHeight,
                        child: Text(
                          formatDate(entry.value.date),
                          style: TextStyle(
                            color: entry.value.date
                                        .difference(DateTime.now())
                                        .inDays <=
                                    3
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            width: _colWidths[6],
            child: DataTableTooltip(
              message: getFormatNum(row.futurePayment.toString()),
              child: Column(
                children: futurePayments.payments
                    .asMap()
                    .entries
                    .map(
                      (entry) => Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: _multiRowHeight,
                            child: BigNumberTextWidget(
                                number: entry.value.cash.toString()),
                          )),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TotalsWidget extends StatelessWidget {
  const TotalsWidget({Key? key, required this.model}) : super(key: key);

  final TableModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 50.0),
              Text('Долг'),
              SizedBox(width: 50.0),
              Text('Остаток'),
            ],
          ),
          Row(
            children: [
              Text("ЭСИ"),
              SizedBox(width: 10.0),
              Text(getFormatNum(model.getClientDebt('ЭСИ').toString())),
              SizedBox(width: 10.0),
              Text(getFormatNum(model.getClientFutureIncome('ЭСИ').toString())),
            ],
          ),
          Row(
            children: [
              Text("Внешние"),
              SizedBox(width: 10.0),
              Text(getFormatNum(model.getClientDebt('ЭСИ', exclude: true).toString())),
              SizedBox(width: 10.0),
              Text(getFormatNum(
                  model.getClientDebt('ЭСИ', exclude: true).toString())),
            ],
          ),
          Row(
            children: [
              Text("Всего"),
              SizedBox(width: 10.0),
              Text(getFormatNum(
                  model.debt.toString())),
              SizedBox(width: 10.0),
              Text(getFormatNum(
                  model.futureIncome.toString())),
            ],
          ),
        ],
      ),
    );
  }
}
