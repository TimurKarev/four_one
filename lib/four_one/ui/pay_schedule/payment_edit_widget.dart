import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/pay_schedule/cash_payment_textform.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';

class PaymentEditWidget extends StatelessWidget {
  const PaymentEditWidget({Key? key}) : super(key: key);

  final sum = 1000000.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          PaymentTextForm.cash(),
          SizedBox(width: 20.0),
          PaymentTextForm.percentage(),
          SizedBox(width: 20.0),
          ResidualCheckbox(),
        ],
      ),
    );
  }
}
