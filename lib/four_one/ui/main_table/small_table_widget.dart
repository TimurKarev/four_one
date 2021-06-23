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
  final _sliderMax = 15;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(smallTableProvider);
    SmallTableModel model = viewModel.init(appModel);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Flexible(
          //       flex: _columnFlex[0],
          //       fit: FlexFit.tight,
          //       child: Text('Mесяц'),
          //     ),
          //     Flexible(
          //       flex: _columnFlex[1],
          //       fit: FlexFit.tight,
          //       child: Text('сумма'),
          //     ),
          //     Flexible(
          //       flex: _columnFlex[2],
          //       fit: FlexFit.tight,
          //       child: Center(child: Text('график')),
          //     ),
          //   ],
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
            max: _sliderMax.toDouble(),
            divisions: _sliderMax,
            label: '${viewModel.slider.toInt()}',
          ),
        ],
      ),
    );
  }

  Widget _getMonthRows(SmallTableModel model) {
    bool odd = false;
    return Column(
      children: model.rows
          .map(
            (row) {
              odd =!odd;
              return Container(
                color: !odd ? Colors.grey[100] : Colors.white,
                child: Row(
                children: [
                  Flexible(
                    flex: _columnFlex[0],
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        row.monthName,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: _columnFlex[1],
                    fit: FlexFit.tight,
                    child: Text(
                      getFormatNum(
                        row.monthPayment.toInt().toString(),
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: _columnFlex[2],
                    fit: FlexFit.tight,
                    child: _getRowCards(row),
                  ),
                ],
            ),
              );
            },
          )
          .toList(),
    );
  }

  Widget _getRowCards(SmallTableRowModel row) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: row.cards.map((card) {
          final date = formatDate(card.date, year: false);
          final payment = getFormatNum(card.payment.toInt().toString());
          final client = card.client;
          final debt = numToString(card.clientDebt.toInt());
          final length = (date + client + debt).length + 10;

          String object = '${card.object} ${card.order}';
          object = object.length > length
              ? _trimString(card.object, card.order, length)
              : object;

          return Container(
            child: Card(
              elevation: 2.5,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 7.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          client,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        if (debt != '')
                          SizedBox(
                            width: 2.0,
                          ),
                        Text(
                          debt,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      object,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 11.0,
                      ),
                    ),
                    // SizedBox(
                    //   height: 5.0,
                    // ),
                    Text(
                      payment,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _trimString(String object, String order, int length) {
    if (order.length + 10 >= object.length) {
      return order;
    } else {
      return object.substring(0, length - order.length - 5) + '...' + order;
    }
  }
}
