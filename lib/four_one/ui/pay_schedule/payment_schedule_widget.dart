import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_model.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_edit_widget.dart';
import 'package:four_one/four_one/viewmodels/payment_schedule_viewmodel.dart';

class PaymentScheduleWidget extends ConsumerWidget {
  const PaymentScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<PaymentEditModel> payments =
        watch(paymentScheduleProvider).payments;
    List<Widget> listWidgets =
        _getPayments(context: context, payments: payments).cast<Widget>();
    listWidgets.add(PaymentEditWidget());
    return Container(
      child: Column(
        children: listWidgets,
      ),
    );
  }

  List<Widget> _getPayments(
      {required BuildContext context,
      required List<PaymentEditModel> payments}) {
    final payLength = payments.length;
    List<Widget> ret = [];
    if (payLength < 1) {
      ret = <Widget>[Text('Платежи пока отсутствуют')];
    } else {
      ret.addAll(payments.map((payment) => Text(payment.string)).toList().cast<Widget>());
      print(ret.toString());
    }
    return ret;
  }
}
