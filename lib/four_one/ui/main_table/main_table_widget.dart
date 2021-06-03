import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/ui/data_table_income_dialog.dart';
import 'package:four_one/four_one/ui/reusable_widgets/big_number_text_widget.dart';
import 'package:four_one/four_one/ui/reusable_widgets/data_table_tooltip.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/tables/BigTableViewModel.dart';

import '../edit_payment_dialog.dart';
import '../ready_date_edit_dialog.dart';

class MainTableWidget extends ConsumerWidget {
  MainTableWidget({Key? key}) : super(key: key);

  List<double> colWidths = [
    150.0,
    250.0,
    150.0,
    150.0,
    150.0,
    150.0,
    150.0,
  ];

  double get tableWidth => colWidths.fold(0, (p, e) => p + e);

  final dataProvider = StreamProvider<List<BigTableModel>>((ref) {
    return ref.watch(bigTableDataProvider).tableDataStream();
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(dataProvider).when(
      data: (data) {
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
      },
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
      error: (e, __) {
        return Container(
          child: Text('Error $e'),
        );
      },
    );
  }

  Widget _getTable(BuildContext context, List<BigTableModel> data) {
    return Container(
      width: tableWidth,
      child: Column(
        children: [
          _getTableHeader(),
          getTotalsRow(context),
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

  SizedBox getTotalsRow(BuildContext context) {
    final rowValues = [
      '',
      '',
      '',
      '',
      context.read(bigTableDataProvider).debt.toString(),
      '',
      context.read(bigTableDataProvider).futureIncome.toString(),
    ];
    return SizedBox(
      height: 40.0,
      child: Row(
        children: rowValues.asMap().entries.map(
              (entry) => SizedBox(
                width: colWidths[entry.key],
                child: rowValues[entry.key] == '' ? Container(): BigNumberTextWidget(
                  number: rowValues[entry.key],
                ),
              ),
            ).toList(),
      ),
    );
  }

  SizedBox _getTableHeader() {
    return SizedBox(
      height: 30.0,
      child: Row(
        children: BigTableModel.columns
            .asMap()
            .entries
            .map(
              (entre) => SizedBox(
                width: colWidths[entre.key],
                child: Text(
                  entre.value,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _getRow(BuildContext context, BigTableModel row) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: colWidths[0],
            child: DataTableTooltip(
                message: '${row.contract}', child: Text(row.client)),
          ),
          SizedBox(
            width: colWidths[1],
            child: DataTableTooltip(
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
                )),
          ),
          SizedBox(
            width: colWidths[2],
            child: DataTableTooltip(
              message: row.paymentLegend,
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return EditPaymentDialog(model: row);
                      });
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: BigNumberTextWidget(number: row.sum.toString())),
              ),
            ),
          ),
          SizedBox(
            width: colWidths[3],
            child: DataTableTooltip(
              message: row.incomeString,
              child: Align(
                alignment: Alignment.centerLeft,
                //TODO: add button here
                child: DataTableIncomeDialog(model: row),
              ),
            ),
          ),
          SizedBox(
            width: colWidths[4],
            child: DataTableTooltip(
              message: row.debtString,
              child: BigNumberTextWidget(number: row.debt.toString()),
            ),
          ),
          SizedBox(width: colWidths[5], child: Text('')),
          SizedBox(
            width: colWidths[6],
            child: DataTableTooltip(
              message: row.futureIncomeString,
              child: BigNumberTextWidget(
                number: row.futurePayment.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
