import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/viewmodels/tables/small_table_view_model.dart';

class SmallTableWidget extends ConsumerWidget {
  SmallTableWidget({Key? key, required model}) : super(key: key){
    _model = model;
  }

  late final TableModel _model;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(smallTableProvider);
    final model = viewModel.getTableModel(_model);
    return Text('Нова таблица');
  }
}
