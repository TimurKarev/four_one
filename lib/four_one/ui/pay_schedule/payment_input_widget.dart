import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_textform.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';

class PaymentInputWidget extends StatelessWidget {
  const PaymentInputWidget({
    Key? key,
  }) : super(key: key);

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