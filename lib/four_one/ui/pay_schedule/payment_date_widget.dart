import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';

class PaymentDateWidget extends StatelessWidget {
  const PaymentDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Дата платежа'),
          SizedBox(height: 13),
          DatePickerForm(),
        ],
      ),
    );
  }
}
