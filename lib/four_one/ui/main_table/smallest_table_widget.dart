import 'package:flutter/cupertino.dart';
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
            flex: 7,
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
                    '${row.object} (${row.order})',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: _getDurationAndSum(row),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDurationAndSum(BigTableModel row) {
    final bool debt = row.debt > 0.0;
    int duration = 0;
    double sum = 0.0;

    if (debt) {
      duration = row.debtDuration;
      sum = row.debt;
    } else {
      try {
        duration = row.futureIncomes.payments[0].date.difference(DateTime.now()).inDays;
        sum = row.futureIncomes.payments[0].cash;
      } catch (e) {
        print('smallest_table_widget _getDurationAndSum ${e.toString()}');
      }
    }

    row.debt > 0 ? row.debtDuration : 100500;
    final color = duration > 0 ? Colors.green : Colors.red;
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            duration != 0 ? duration.toString() : '0',
            style: TextStyle(
              fontSize: 20.0,
              color: color,
            ),
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            getFormatNum(sum.toString()),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
