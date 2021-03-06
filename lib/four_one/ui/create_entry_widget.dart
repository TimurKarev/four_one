import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/security/security_widget.dart';
import 'package:four_one/four_one/ui/client_input_widget.dart';
import 'package:four_one/four_one/ui/pay_schedule/add_schedular_widget.dart';
import 'package:four_one/four_one/ui/pay_schedule/save_entry_floating_button.dart';
import 'package:four_one/four_one/ui/reusable_widgets/entry_text_form_field.dart';
import 'package:four_one/four_one/ui/reusable_widgets/date_picker_form.dart';
import 'package:four_one/four_one/viewmodels/entry/create_entry_viewmodel.dart';

class CreateEntryWidget extends StatelessWidget {
  CreateEntryWidget({Key? key}) : super(key: key);

  static final path = '/4_1/create-entry';

  final dateProvider = Provider<DateTime>((ref) {
    return ref.watch(createEntryProvider).finishDate;
  });

  void _setNewDate(BuildContext context, DateTime newValue) {
    context.read(createEntryProvider.notifier).date = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              final provider = context.read(createEntryProvider.notifier);
              provider.clearForm(fill: true);
              provider.update();
            },
            child: Icon(Icons.autorenew),
          ),
        ],
      ),
      body: SecurityWidget(
        allow: {'order_create'},
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40.0, 10.0, 20.0, 5.0),
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [

                ClientInputWidget(),
                EntryTextFormField(
                    labelText: 'Объект',
                    controller: context
                        .read(createEntryProvider.notifier)
                        .objectController),
                EntryTextFormField(
                    labelText: 'Заказ',
                    controller: context
                        .read(createEntryProvider.notifier)
                        .orderController),
                EntryTextFormField(
                    labelText: 'Договор',
                    controller: context
                        .read(createEntryProvider.notifier)
                        .contractController),
                EntryTextFormField(
                    isNumeric: true,
                    labelText: 'Сумма, руб.',
                    controller: context
                        .read(createEntryProvider.notifier)
                        .sumController),
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
        ),
      ),
      floatingActionButton: SaveEntryFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
