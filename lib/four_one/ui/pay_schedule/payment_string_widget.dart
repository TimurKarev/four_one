import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentStringWidget extends ConsumerWidget {
  const PaymentStringWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final value = 'Определить';
    return Container(
      child: Text(value),
    );
  }
}
