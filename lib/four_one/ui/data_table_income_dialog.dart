import 'package:flutter/material.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/ui/reusable_widgets/big_number_text_widget.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/tables/income_dialog_view_model.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: move button from this widget
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