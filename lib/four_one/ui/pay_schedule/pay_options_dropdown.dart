import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class PayOptionValues {
  static final values = {
    'prepayment': 'аванс',
    'notification': "уведомление",
    'completed': 'готовность',
    'date': 'фиксированная дата',
    'shipment': 'отгрузка',
  };
}

class PayOptionsDropdownNotifier extends StateNotifier<String?> {
  PayOptionsDropdownNotifier() : super(PayOptionValues.values['notification']);

  String getValue() => state!;

  void setState(String str) {
    state = str;
  }
}

final payOptionsDropdownProvider =
    StateNotifierProvider<PayOptionsDropdownNotifier, String?>(
        (ref) => PayOptionsDropdownNotifier());

class PayOptionsDropdown extends ConsumerWidget {
  const PayOptionsDropdown({Key? key}) : super(key: key);

  //String _value = PayOptionValues.values['prepayment']!;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      child: DropdownButton<String>(
        value: watch(payOptionsDropdownProvider),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          context.read(payOptionsDropdownProvider.notifier).setState(newValue!);
        },
        items:
            PayOptionValues.values.entries.map<DropdownMenuItem<String>>((m) {
          return DropdownMenuItem<String>(
            value: m.value,
            child: Text(m.value),
          );
        }).toList(),
      ),
    );
  }
}
