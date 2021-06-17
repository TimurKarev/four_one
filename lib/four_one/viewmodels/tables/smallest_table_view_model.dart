import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';

final smallestTableProvider = ChangeNotifierProvider((ref) => SmallestTableViewModel());

class SmallestTableViewModel extends ChangeNotifier {
  TableModel getTableModel(TableModel data) {
    List<BigTableModel> rotList = [];

    data.rowList.forEach((element) {
      final futureIncomes = element.futureIncomes.payments;
      if (element.debt > 0) {
        rotList.add(element);
      } else if (futureIncomes.isNotEmpty &&
          futureIncomes[0].date.difference(DateTime.now()).inDays <= 3) {
        rotList.add(element);
      }
    });

    return TableModel(rowList: rotList);
  }
}
