import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_edit_widget.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';


class CreateEntryWidget extends StatelessWidget {
  const CreateEntryWidget({Key? key}) : super(key: key);

  static final path = '/4_1/create-entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 20.0, 5.0),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Заказчик',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Объект',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Заказ',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Договор',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Сумма',
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  "Готовность",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                DatePickerForm(),
              ],
            ),
            SizedBox(height: 10,),
            PaymentEditWidget(),
          ],
        ),
      ),
    );
  }
}
