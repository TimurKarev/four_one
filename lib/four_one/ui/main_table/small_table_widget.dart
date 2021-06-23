import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/models/small_table_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/tables/small_table_view_model.dart';

class SmallTableWidget extends ConsumerWidget {
  SmallTableWidget({Key? key, required this.appModel}) : super(key: key);

  final TableModel appModel;

  final _columnFlex = [15, 15, 80];
  final _objectLength = 5;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(smallTableProvider);
    SmallTableModel model = viewModel.init(appModel);

    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: _columnFlex[0],
                        fit: FlexFit.tight,
                        child: Text('Mесяц'),
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
                  _getMonthRows(model),
                ],
              ),
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

  Widget _getMonthRows(SmallTableModel model) {
    return Column(
      children: model.rows
          .map(
            (row) => Row(
              children: [
                Flexible(
                  flex: _columnFlex[0],
                  fit: FlexFit.tight,
                  child: Text(row.monthName),
                ),
                Flexible(
                  flex: _columnFlex[1],
                  fit: FlexFit.tight,
                  child:
                      Text(getFormatNum(row.monthPayment.toInt().toString())),
                ),
                Flexible(
                  flex: _columnFlex[2],
                  fit: FlexFit.tight,
                  child: _getRowCards(row),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _getRowCards(SmallTableRowModel row) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: row.cards.map((card) {
          String object = card.object;
          object = object.length > _objectLength
              ? object.substring(0, _objectLength) + '...'
              : object;
          object += ' ${card.order}';
          return Container(
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(formatDate(card.date, year: false)),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(card.client),
                    ],
                  ),
                  Text(
                    object,
                  ),
                  Row(
                    children: [
                      Text(getFormatNum(card.payment.toString())),
                      Text(' / '),
                      Text(getFormatNum(card.clientDebt.toString())),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
