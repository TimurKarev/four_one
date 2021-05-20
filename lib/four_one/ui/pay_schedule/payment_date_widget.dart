import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';
import 'package:four_one/four_one/viewmodels/entry/payment_edit_viewmodel.dart';

class PaymentDateWidget extends ConsumerWidget {
  PaymentDateWidget({Key? key}) : super(key: key);

  final _dateProvider = Provider<DateTime>((ref) {
    return ref.watch(paymentEditProvider).date;
  });

  void _setDate(BuildContext context, DateTime newValue) {
    context.read(paymentEditProvider.notifier).date = newValue;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      child: Column(
        children: [
          Text('Дата платежа'),
          SizedBox(height: 13),
          DatePickerForm(
            provider: _dateProvider,
            setDate: _setDate,
          ),
        ],
      ),
    );
  }
}
