import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/entry/payment_edit_viewmodel.dart';

class PaymentStringWidget extends ConsumerWidget {
  PaymentStringWidget({Key? key}) : super(key: key);

  final _stringProvider = Provider<String>((ref) {
    return ref.watch(paymentEditProvider).string;
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final str = watch(_stringProvider);
    return Container(
      child: Text(
        str,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
