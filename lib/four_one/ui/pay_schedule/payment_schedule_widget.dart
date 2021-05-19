import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_edit_widget.dart';
import 'package:four_one/four_one/viewmodels/payment_schedule_viewmodel.dart';

class PaymentScheduleWidget extends StatelessWidget {
  const PaymentScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = _getPayments(context);
    listWidgets.add(PaymentEditWidget());
    return Container(
      child: Column(children:
        listWidgets,
      ),
    );
  }

  List<Widget> _getPayments(BuildContext context) {
    final payLength =
        context.read(paymentScheduleProvider.notifier).paymentLength;
    List<Widget> ret = [];
    if (payLength < 1) {
      ret.add(Text('Платежи пока отсутствуют'));
    } else {
      ret.add(Text('Платежи присутствуют'));
    }
    return ret;
  }
}
