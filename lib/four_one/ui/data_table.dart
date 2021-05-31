import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/ui/edit_payment_dialog.dart';
import 'package:four_one/four_one/utils/date_formatter.dart';
import 'package:four_one/four_one/viewmodels/tables/BigTableViewModel.dart';
import 'package:four_one/four_one/viewmodels/tables/income_dialog_view_model.dart';

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

    rows.forEach((row) {
      final DataRow dataRow = DataRow(cells: [
        DataCell(DataTableTooltip(message: 'Договор №${row.contract}',
        child: Text(row.client))),
        DataCell(
          DataTableTooltip(message: 'готовность - ${formatDate(row.finishDate)}',
          child: Text(row.object)),
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
              child: Text(row.sum.toString()),
            ),
          ),
        ),
        DataCell(DataTableTooltip(message: row.incomeString,
        child: DataTableIncomeDialog(model: row))),
        DataCell(DataTableTooltip(message: row.debtString,
        child: Text(row.debt.toString()))),
        DataCell(DataTableTooltip(message: row.futureIncomeString,
        child: Text((row.futurePayment).toString()))),
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
                                      double.parse(newVal.toString());
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\d*\.?\d*)'))
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
        child: Text(model.incomeSum.toString()),
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
                provider.days = int.parse(newVal);
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          Text("  дней назад"),
        ],
      ),
    );
  }
}
