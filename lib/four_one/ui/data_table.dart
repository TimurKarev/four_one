import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/four_one_model.dart';
import 'package:four_one/four_one/viewmodels/tables/BigTableViewModel.dart';

class DataTableWidget extends ConsumerWidget {
  DataTableWidget({Key? key}) : super(key: key);

  final dataProvider = StreamProvider<List<BigTableModel>>((ref) {
    return ref.watch(bigTableDataProvider).tableDataStream();
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(dataProvider).when(data: (data) {
      return Container(
        alignment: Alignment.topCenter,
        child: DataTable(
          columns: BigTableModel.columns
              .map((col) => DataColumn(label: Text(col.toString())))
              .toList(),
          rows: [],
        ),
      );
    }, loading: () {
      return Center(child: CircularProgressIndicator.adaptive());
    }, error: (e, __) {
      return Container(child: Text('Error $e'),);
    });
  }
}
