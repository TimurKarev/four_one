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

  final _headerNames = [
    'заказ',
    'дни',
    'сумма',
  ];

  final _headerSizes = [
    7,
    2,
    2,
  ];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(smallestTableProvider);
    final model = viewModel.getTableModel(_model);
    return Column(
      children: [
        _getHeader(context),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
            child: ListView.separated(
              itemCount: model.rowList.length,
              itemBuilder: (context, i) => _getRow(context, model.rowList[i]),
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _getRow(BuildContext context, BigTableModel row) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: _headerSizes[0],
            fit: FlexFit.tight,
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${row.object} (${row.order})',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: _headerSizes[1] + _headerSizes[2],
            fit: FlexFit.tight,
            child: Container(
              child: _getDurationAndSum(row),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDurationAndSum(BigTableModel row) {
    // final bool debt = row.debt > 0.0;
    final l = row.durationDebtAndFuture;
    final num duration = l[0];
    final num sum = l[1];

    final color = duration > 0 ? Colors.green : Colors.red;
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            duration != 0 ? duration.toString() : '0',
            style: TextStyle(
              fontSize: 16.0,
              color: color,
            ),
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            getFormatNum(sum.toInt().toString()),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _getHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 35.0,
      child: Row(
        children: _headerNames
            .asMap()
            .entries
            .map(
              (entre) => Flexible(
                fit: FlexFit.tight,
                flex: _headerSizes[entre.key],
                child: TextButton(
                  onPressed: () {
                    context.read(smallestTableProvider).sort = entre.key;
                  },
                  child: Align(
                    alignment:
                        entre.key == 1 ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                      entre.value,
                      //textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
