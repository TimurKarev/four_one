import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';


class PaymentOptionDropdown extends ConsumerWidget {
  PaymentOptionDropdown({Key? key}) : super(key: key);

  final _optionsValue = Provider<PaymentOptionValues>((ref) {
    return ref.watch(paymentEditProvider).paymentOptions;
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final option = watch(_optionsValue);
    return Container(
      child: Column(
        children: [
          Text("Тип платежа"),
          SizedBox(height: 16.0),
          DropdownButton<String>(
            value: option.toStr(),
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                context.read(paymentEditProvider.notifier).option = newValue;
              }
            },
            items: PaymentOptionValues.values
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.toStr(),
                child: Text(value.toStr()),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
