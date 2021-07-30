import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/edit_order/domain/controllers/edit_model_controller.dart';

class PaymentChooserWidget extends ConsumerWidget {
  PaymentChooserWidget({Key? key}) : super(key: key);

  final provider =
      Provider<String>((ref) => ref.watch(providerEditModelController));

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final string = watch(provider);
    return Container(
      child: Column(
        children: [
          Text(string),
          Text(string),
        ],
      ),
    );
  }
}
