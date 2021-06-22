import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/tables/small_table_view_model.dart';

class SmallTableWidget extends ConsumerWidget {
  SmallTableWidget({Key? key, required model}) : super(key: key) {
    _model = model;
  }

  late final TableModel _model;

  final _columnFlex = [15, 15, 80];
  final _objectLength = 20;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(smallTableProvider);
    viewModel.init(_model);
    final monthMap = viewModel.getMonthMap();
    final rowMap = viewModel.getRowMap();

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: _columnFlex[0],
                      fit: FlexFit.tight,
                      child: Text('месяц'),
                    ),
                    Flexible(
                      flex: _columnFlex[1],
                      fit: FlexFit.tight,
                      child: Text('сумма'),
                    ),
                    Flexible(
                      flex: _columnFlex[2],
                      fit: FlexFit.tight,
                      child: Center(child: Text('график')),
                    ),
                  ],
                ),
                _getMonthRows(monthMap, rowMap),
              ],
            ),
          ),
          Slider(
            value: viewModel.slider,
            onChanged: (newValue) {
              viewModel.slider = newValue;
            },
            min: 0,
            max: 31,
            divisions: 31,
            label: '${viewModel.slider.toInt()}',
          ),
        ],
      ),
    );
  }

  Widget _getMonthRows(
      Map<String, num> monthMap, Map<String, List<dynamic>> rowMap) {
    return Column(
      children: monthMap.entries
          .map((e) => Row(
                children: [
                  Flexible(
                    flex: _columnFlex[0],
                    fit: FlexFit.tight,
                    child: Text(e.key),
                  ),
                  Flexible(
                    flex: _columnFlex[1],
                    fit: FlexFit.tight,
                    child: Text(getFormatNum(e.value.toInt().toString())),
                  ),
                  Flexible(
                    flex: _columnFlex[2],
                    fit: FlexFit.tight,
                    child: rowMap.containsKey(e.key)
                        ? _getRowCards(rowMap[e.key])
                        : Container(),
                  ),
                ],
              ))
          .toList(),
    );
  }

  Widget _getRowCards(List? rowMap) {
    return Row(
      children: rowMap!.map((e) {
        String object = e['object'];
        object = object.length > _objectLength
            ? object.substring(0, _objectLength)
            : object;
        return Card(
          child: Column(
            children: [
              Row(
                children: [
                  Text(formatDate(e['date'], year: false)),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(e['client']),
                ],
              ),
              Text(
                object,
              ),
              Row(
                children: [
                  Text(getFormatNum(e['payment'].toInt().toString())),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
