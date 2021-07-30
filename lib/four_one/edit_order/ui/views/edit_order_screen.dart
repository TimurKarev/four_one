import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common_order_widget.dart';

class EditOrderScreen extends ConsumerWidget {
  const EditOrderScreen({Key? key}) : super(key: key);

  static final path = '/4_1/edit-order';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новый заказ'),
      ),
      body: CommonOrderWidget(),
    );
  }
}
