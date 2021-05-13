import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/pay_schedule/pay_options_dropdown.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_date_widget.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_input_widget.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_save_button.dart';

class PaymentEditWidget extends StatelessWidget {
  const PaymentEditWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          PayOptionsDropdown(),
          SizedBox(width: 50.0),
          PaymentInputWidget(),
          SizedBox(width: 50.0),
          PaymentDateWidget(),
          SizedBox(width: 50.0),
          PaymentSaveButton(),
        ],
      ),
    );
  }
}
