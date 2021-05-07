import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';
import 'package:four_one/four_one/ui/pay_schedule/pay_schedule_widget.dart';

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
            DatePickerForm(),
            PayScheduleWidget(sum: 1000000.0,),
          ],
        ),
      ),
    );
  }
}
