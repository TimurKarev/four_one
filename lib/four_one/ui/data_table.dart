import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
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
          rows: _getRows(data),
        ),
      );
    }, loading: () {
      return Center(child: CircularProgressIndicator.adaptive());
    }, error: (e, __) {
      return Container(child: Text('Error $e'),);
    });
  }

  List<DataRow> _getRows(List<BigTableModel> rows) {
    List<DataRow> retRows = [];

    rows.forEach((row) {
      final DataRow dataRow = DataRow(
        cells: [
          DataCell(Text(row.client)),
          DataCell(Text(row.object)),
          DataCell(Text(row.sum.toString())),
          DataCell(Text(row.incomes.getIncomeSum().toString())),
          DataCell(Text('долг')),
          DataCell(Text(row.reminderSum.toString())),
        ]
      );
      retRows.add(dataRow);
    });

    return retRows;
  }
}
