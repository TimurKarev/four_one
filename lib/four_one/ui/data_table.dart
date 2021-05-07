import 'package:flutter/material.dart';
import 'package:four_one/four_one/models/four_one_model.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({Key? key, required this.model}) : super(key: key);

  final FourOneModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: DataTable(
        columns: model.columns!.map((col) => DataColumn(label: Text(col.toString()))).toList(),
        rows: [],
      ),
    );
  }
}
