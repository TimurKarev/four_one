import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';


class PaymentDateWidget extends ConsumerWidget {
  PaymentDateWidget({Key? key}) : super(key: key);

  final _dateProvider = Provider<DateTime>((ref){
    return ref.watch(paymentEditProvider).date;
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final date = watch(_dateProvider);
    return Container(
      child: Column(
        children: [
          Text('Дата платежа'),
          SizedBox(height: 13),
          DatePickerForm(dateTime: date),
        ],
      ),
    );
  }
}
