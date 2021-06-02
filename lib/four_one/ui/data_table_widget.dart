import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/ui/edit_payment_dialog.dart';
import 'package:four_one/four_one/ui/ready_date_edit_dialog.dart';
import 'package:four_one/four_one/ui/reusable_widgets/big_number_text_widget.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/tables/BigTableViewModel.dart';
import 'package:four_one/four_one/viewmodels/tables/income_dialog_view_model.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class DataTableWidget extends ConsumerWidget {
  DataTableWidget({Key? key}) : super(key: key);

  final dataProvider = StreamProvider<List<BigTableModel>>((ref) {
    return ref.watch(bigTableDataProvider).tableDataStream();
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(dataProvider).when(data: (data) {
      return Container(
        alignment: Alignment.topCenter,
        child: DataTable(
          columns: BigTableModel.columns
              .map((col) => DataColumn(label: Text(col.toString())))
              .toList(),
          rows: _getRows(data, context),
        ),
      );
    }, loading: () {
      return Center(child: CircularProgressIndicator.adaptive());
    }, error: (e, __) {
      return Container(
        child: Text('Error $e'),
      );
    });
  }

  List<DataRow> _getRows(List<BigTableModel> rows, BuildContext context) {
    List<DataRow> retRows = [];

    final DataRow firstRow = DataRow(cells: [
      DataCell(Container()),
      DataCell(Container()),
      DataCell(Container()),
      DataCell(Container()),
      DataCell(BigNumberTextWidget(
          number: context.read(bigTableDataProvider).debt.toString())),
      DataCell(BigNumberTextWidget(
          number: context.read(bigTableDataProvider).futureIncome.toString())),
    ]);
    retRows.add(firstRow);
    rows.forEach((row) {
      final DataRow dataRow = DataRow(cells: [
        DataCell(DataTableTooltip(
            message: 'Договор №${row.contract}', child: Text(row.client))),
        DataCell(
          DataTableTooltip(
            message: 'готовность - ${formatDate(row.finishDate)}',
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return ReadyDateEditDialog(model: row);
                    });
              },
              child: Text(row.object),
            ),
          ),
        ),
        DataCell(
          DataTableTooltip(
            message: row.paymentLegend,
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditPaymentDialog(model: row);
                    });
              },
              child: BigNumberTextWidget(number: row.sum.toString()),
            ),
          ),
        ),
        DataCell(DataTableTooltip(
            message: row.incomeString,
            child: DataTableIncomeDialog(model: row))),
        DataCell(
          DataTableTooltip(
            message: row.debtString,
            child: BigNumberTextWidget(number: row.debt.toString()),
          ),
        ),
        DataCell(DataTableTooltip(
            message: row.futureIncomeString,
            child: BigNumberTextWidget(number: row.futurePayment.toString()))),
      ]);
      retRows.add(dataRow);
    });

    return retRows;
  }
}

class DataTableTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const DataTableTooltip({Key? key, required this.child, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.length <= 0) {
      return Container(
        child: child,
      );
    }
    return Tooltip(
      message: message,
      child: child,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      textStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }
}

class DataTableIncomeDialog extends StatelessWidget {
  final BigTableModel model;

  DataTableIncomeDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read(incomeDialogProvider);
    return Container(
      child: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Внесите плаетж для - "${model.object}"'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final isSaved = await provider.updateDataBase(model.id);
                        if (!isSaved) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Yay! A SnackBar!')),
                          );
                        }
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                  content: Container(
                    height: 150.0,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Сумма платежа"),
                            SizedBox(width: 30.0),
                            Expanded(
                              child: TextFormField(
                                //controller: controller,
                                onChanged: (String newVal) {
                                  provider.sum =
                                      double.parse(getNumFromFormatString(newVal));
                                },
                                inputFormatters: [
                                  ThousandsFormatter(allowFraction: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        PaymentDateWidget(),
                      ],
                    ),
                  ),
                );
              });
        },
        child: BigNumberTextWidget(number: model.incomeSum.toString()),
      ),
    );
  }
}

class PaymentDateWidget extends StatefulWidget {
  const PaymentDateWidget({Key? key}) : super(key: key);

  @override
  _PaymentDateWidgetState createState() => _PaymentDateWidgetState();
}

class _PaymentDateWidgetState extends State<PaymentDateWidget> {
  bool switchValue = false;

  //TextEditingController controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final provider = context.read(incomeDialogProvider);
    return Container(
      child: Row(
        children: [
          Text('Задать дату'),
          Switch(
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
            value: switchValue,
          ),
          SizedBox(width: 20.0),
          SizedBox(
            width: 50.0,
            child: TextFormField(
              enabled: switchValue,
              initialValue: '0',
              onChanged: (String newVal) {
                provider.days = int.parse(getNumFromFormatString(newVal));
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                ThousandsFormatter(),
              ],
            ),
          ),
          Text("  дней назад"),
        ],
      ),
    );
  }
}
