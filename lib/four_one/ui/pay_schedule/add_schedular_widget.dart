import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_schedule_widget.dart';
import 'package:four_one/four_one/viewmodels/create_entry_viewmodel.dart';

class AddScheduleWidget extends ConsumerWidget {
  AddScheduleWidget({Key? key}) : super(key: key);

  final _addButtonProvider = Provider<bool>((ref) {
    ref.watch(createEntryProvider);
    return ref.watch(createEntryProvider.notifier).addButtonEnabled;
  });

  final _showScheduleWidgetProvider = Provider<bool>((ref) {
    ref.watch(createEntryProvider);
    return ref.watch(createEntryProvider.notifier).showScheduleWidget;
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isButtonEnable = watch(_addButtonProvider);
    final bool showSchedule = watch(_showScheduleWidgetProvider);

    if (showSchedule) {
      return PaymentScheduleWidget();
    } else {
      return Container(
        child: Column(children: [
          Text('Создать график платежей'),
          ElevatedButton(
            onPressed: isButtonEnable ? () {
              context.read(createEntryProvider.notifier).showScheduleWidget = true;
            } : null,
            child: Text('Создать'),
          ),
        ]),
      );
    }
  }
}
