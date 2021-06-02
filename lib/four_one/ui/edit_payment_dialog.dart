import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/edit/payment_edit_view_model.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class EditPaymentDialog extends ConsumerWidget {
  EditPaymentDialog({Key? key, required this.model}) : super(key: key);
  final BigTableModel model;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(paymentsEditProvider(model.payments));
    final enableOk = provider.enableOk;

    //print('build');
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: enableOk
              ? () async {
                  final isSaved = await provider.updateDataBase(model.id);
                  if (!isSaved) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Yay! A SnackBar!')),
                    );
                  }
                  Navigator.pop(context, 'OK');
                }
              : null,
          child: const Text('OK'),
        ),
      ],
      title: Text('alert'),
      content: Container(
        height: provider.payments.length * 100.0,
        child: Column(
          children: provider.payments.map((payment) {
            return Row(
              children: [
                Text('Платеж в размере  '),
                SizedBox(
                  width: 100.0,
                  child: TextFormField(
                    inputFormatters: [
                      ThousandsFormatter(allowFraction: true),
                    ],
                    initialValue: getFormatNum(payment.cash.toString()),
                    onChanged: (String newVal) =>
                        provider.sumFieldChanged(getNumFromFormatString(newVal), payment),
                  ),
                ),
                SizedBox(width: 20.0),
                Text('не позднее'),
                SizedBox(width: 20.0),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: payment.date,
                      firstDate: payment.date.subtract(Duration(days: 500)),
                      lastDate: DateTime.now().add(Duration(days: 500)),
                    ).then((value) {
                      if (value != null) {
                        provider.dateFieldChanged(value, payment);
                      }
                    });
                  },
                  child: Text(formatDate(payment.date)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
      // ElevatedButton(

      //   child: Icon(Icons.date_range),
      // ),
    );
  }
}
