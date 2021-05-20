import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_model.dart';
import 'package:four_one/four_one/viewmodels/payment_schedule_viewmodel.dart';

class PaymentsListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<PaymentEditModel> payments =
        watch(paymentScheduleProvider).payments;
    final payLength = payments.length;

    if (payLength < 1) {
      return Text('Платежи пока отсутствуют');
    } else {
      return Container(
        child: Column(
          children: payments.asMap().entries.map((payment) {
            return _getPaymentWidget(context, payment.value.string, payment.key);
          }).toList(),
        ),
      );
    }
  }

  Widget _getPaymentWidget(BuildContext context, String string, int index) {
    return Card(
        child: Row(
      children: [
        Text(string),
//        Icon(Icons.edit),
        ElevatedButton(
          onPressed: () {
            context.read(paymentScheduleProvider.notifier).deletePayment(index);
          },
          child: Icon(Icons.delete),
        ),
      ],
    ));
  }
}
