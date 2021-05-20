import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_edit_widget.dart';
import 'package:four_one/four_one/ui/pay_schedule/payments_list_widget.dart';

class PaymentScheduleWidget extends ConsumerWidget {
  const PaymentScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    return Container(
      child: Column(
        children: [
          PaymentsListWidget(),
          PaymentEditWidget(),
        ],
      ),
    );
  }
}
