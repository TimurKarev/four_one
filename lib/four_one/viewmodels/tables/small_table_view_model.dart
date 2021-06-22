import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
import 'package:four_one/four_one/models/entry/payment_schedule_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';

final smallTableProvider =
    ChangeNotifierProvider((ref) => SmallTableViewModel());

final month = [
  'Январь',
  'Февраль',
  "Март",
  "Апрель",
  "Май",
  "Июнь",
  "Июль",
  "Август",
  "Сентябрь",
  "Октябрь",
  "Ноябрь",
  "Декабрь"
];

class SmallTableViewModel extends ChangeNotifier {
  late TableModel _model;

  double _slider = 0;

  double get slider => _slider;
  set slider(double newValue) {
    _slider = newValue;
    notifyListeners();
  }

  void init(TableModel data) {
    List<BigTableModel> rotList = [];

    data.rowList.forEach((element) {
      final futureIncomes = element.futureIncomes.payments;
      if (futureIncomes.isNotEmpty) {
        rotList.add(element);
      }
    });
    _model = TableModel(rowList: rotList);
  }

  Map<String, num> getMonthMap() {
    Map<String, num> retMap = {};

    _model.rowList.forEach((row) {
      final futureIncomes = row.futureIncomes.payments;
      if (futureIncomes.isNotEmpty) {
        futureIncomes.forEach((payment) {
          final key = month[payment.date.month];
          if (retMap.containsKey(key)) {
            retMap[key] = (retMap[key]! + payment.cash);
          } else {
            retMap[key] = payment.cash;
          }
        });
      }
    });

    return retMap;
  }

  Map<String, List<dynamic>> getRowMap() {
    Map<String, List<dynamic>> retMap = {};

    _model.rowList.forEach((row) {
      final futureIncomes = row.futureIncomes.payments;
      if (futureIncomes.isNotEmpty) {
        futureIncomes.forEach((payment) {
          final key = month[payment.date.month];
          final dict = {
            'client': row.client,
            'date': payment.date,
            'object': row.object,
            'payment': payment.cash,
            'debt': 'debt',
          };
          if (retMap.containsKey(key)) {
            retMap[key]!.add(dict);
          } else {
            retMap[key] = [dict];
          }
        });
      }
    });
    return retMap;
  }
}
