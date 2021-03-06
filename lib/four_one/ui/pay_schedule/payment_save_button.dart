import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
import 'package:four_one/four_one/viewmodels/entry/payment_edit_viewmodel.dart';
import 'package:four_one/four_one/viewmodels/entry/payment_schedule_viewmodel.dart';

class PaymentSaveButton extends ConsumerWidget {
  PaymentSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final editModel = watch(paymentEditProvider);
    return Container(
      child: Column(
        children: [
          Text('Добавить'),
          SizedBox(height: 13.0),
          SizedBox(
            width: 40.0,
            child: ElevatedButton(
              onPressed: _isEnabled(editModel)?() {
                context.read(paymentScheduleProvider.notifier).savePayment();
              }: null,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  bool _isEnabled(PaymentEditModel model) {
    if (model.cash == 0.0 || model.percentage == 0.0) {
      return false;
    }
    return true;
  }
}
