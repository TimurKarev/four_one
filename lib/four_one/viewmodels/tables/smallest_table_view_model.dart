import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';

final smallestTableProvider = ChangeNotifierProvider((ref) => SmallestTableViewModel());

class SmallestTableViewModel extends ChangeNotifier {

  int _sort = 1;
  int _revert = -1;

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

    if (_sort == 0) {
      rotList.sort((a,b) => _revert * a.client.toLowerCase().compareTo(b.client.toLowerCase()));
    }
    if (_sort == 1) {
      rotList.sort((a,b) => _revert * a.durationDebtAndFuture[0].compareTo(b.durationDebtAndFuture[0]));
    }
    if (_sort == 2) {
      rotList.sort((a,b) => _revert * a.durationDebtAndFuture[1].compareTo(b.durationDebtAndFuture[1]));
    }

    return TableModel(rowList: rotList);
  }

  set sort(int index) {
    if (index >=0 && index <= 2) {
      if (_sort == index) {
        _revert *= -1;
      } else {
        _sort = index;
        _revert = -1;
      }
      notifyListeners();
    }
  }
}
