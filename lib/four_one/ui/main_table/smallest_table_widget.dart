import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(
        itemCount: model.rowList.length,
        itemBuilder: (context, i) => _getRow(context, model.rowList[i]),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );

  }

  Widget _getRow(BuildContext context, BigTableModel row) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 6,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      row.client,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Text(
                    row.object,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: _getDuration(row),
          ),
          Container(
            width: 100.0,
            child: Text(
              getFormatNum(row.debt.toString()),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Text _getDuration(BigTableModel row) {
    final duration = row.debt>0?row.debtDuration : 100500;
    final color = duration > 0 ? Colors.green : Colors.red;
    return Text(
      duration != 0 ? duration.toString() : '0',
      style: TextStyle(
        fontSize: 20.0,
        color: color,
      ),
    );
  }
}
