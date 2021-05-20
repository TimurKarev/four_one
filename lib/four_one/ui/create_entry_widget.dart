import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/add_schedular_widget.dart';
import 'package:four_one/four_one/ui/pay_schedule/save_entry_floating_button.dart';
import 'package:four_one/four_one/ui/reusable_widgets/EntryTextFormField.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';
import 'package:four_one/four_one/viewmodels/create_entry_viewmodel.dart';

class CreateEntryWidget extends StatelessWidget {
  CreateEntryWidget({Key? key}) : super(key: key);

  static final path = '/4_1/create-entry';

  final dateProvider = Provider<DateTime>((ref) {
    return ref.watch(createEntryProvider).finishDate;
  });

  void _setNewDate(BuildContext context, DateTime newValue){
    context.read(createEntryProvider.notifier).date = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 20.0, 5.0),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            EntryTextFormField(
                labelText: 'Заказчик',
                controller: context
                    .read(createEntryProvider.notifier)
                    .clientController),
            EntryTextFormField(
                labelText: 'Объект',
                controller: context
                    .read(createEntryProvider.notifier)
                    .objectController),
            EntryTextFormField(
                labelText: 'Заказ',
                controller:
                    context.read(createEntryProvider.notifier).orderController),
            EntryTextFormField(
                labelText: 'Договор',
                controller: context
                    .read(createEntryProvider.notifier)
                    .contractController),
            EntryTextFormField(
                isNumeric: true,
                labelText: 'Сумма, руб.',
                controller:
                    context.read(createEntryProvider.notifier).sumController),
            SizedBox(
              height: 10,
            ),
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
                DatePickerForm(
                  provider: dateProvider,
                  setDate: _setNewDate,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //PaymentEditWidget(),
            AddScheduleWidget(),
          ],
        ),
      ),
      floatingActionButton: SaveEntryFloatingButton(
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
