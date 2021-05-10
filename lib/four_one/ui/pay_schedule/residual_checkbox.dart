import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_widget_model.dart';

final residualCheckboxProvider =
    ChangeNotifierProvider((ref) => ResidualCheckboxNotifier());

class ResidualCheckboxNotifier extends ChangeNotifier {

  void update() {
    notifyListeners();
  }
}

class ResidualCheckbox extends ConsumerWidget {
  const ResidualCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
     watch(residualCheckboxProvider);
     final value = context.read(paymentEditWidgetModelProvider).checkBoxValue;

    return Container(
      child: Column(
        children: [
          Text('Остаток'),
          Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                context.read(paymentEditWidgetModelProvider).setNewCheckboxValue(newValue!);
              }),
        ],
      ),
    );
  }
}
