import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/edit_order/ui/ctrls/common_order_controller.dart';
import 'package:four_one/four_one/edit_order/ui/views/payment_chooser_widget.dart';
import 'package:four_one/four_one/ui/client_input_widget.dart';

class CommonOrderWidget extends ConsumerWidget {
  const CommonOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ctrl = watch(providerCommonOrderProvider);
    print('BUILD CommonOrderWidget');
    return Container(
      child: Column(
        children: [
          ClientInputWidget(),
          TextFormField(
            controller: ctrl.objectTextCtrl,
            decoration: InputDecoration(
              labelText: 'Объект',
            ),
          ),
          TextFormField(
            controller: ctrl.orderNumTextCtrl,
            decoration: InputDecoration(
              labelText: 'Заводской заказ',
            ),
          ),
          TextFormField(
            controller: ctrl.contractTextCtrl,
            decoration: InputDecoration(
              labelText: 'Договор',
            ),
          ),
          PaymentChooserWidget(),
        ],
      ),
    );
  }
}
