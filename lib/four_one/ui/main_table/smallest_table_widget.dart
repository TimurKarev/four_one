import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/viewmodels/tables/smallest_table_view_model.dart';

class SmallestTableWidget extends ConsumerWidget {

  SmallestTableWidget({required model, Key? key}) : super(key: key) {
    _model = model;
  }

  late final TableModel _model;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(smallestTableProvider);
    final model = viewModel.getTableModel(_model);
    return Container(
      child: Text('${model.rowList.length}  -  ${_model.rowList.length}'),
    );
  }
}