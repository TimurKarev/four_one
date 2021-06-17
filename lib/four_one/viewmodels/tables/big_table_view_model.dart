import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/providers/providers.dart';
import 'package:four_one/four_one/services/firebase/firebae_service.dart';
import 'package:four_one/four_one/services/firebase/paths.dart';

final bigTableProvider = ChangeNotifierProvider((ref) => BigTableViewModel());

class BigTableViewModel extends ChangeNotifier {
  int _sort = 0;
  int _revert = -1;

  TableModel getTableModel(TableModel data) {
    if (_sort == 0) {
      data.rowList.sort((a, b) =>
          _revert * a.client.toLowerCase().compareTo(b.client.toLowerCase()));
    }
    if (_sort == 1) {
      data.rowList.sort((a, b) => _revert * a.object.toLowerCase().compareTo(b.object.toLowerCase()));
    }
    if (_sort == 2) {
      data.rowList.sort((a, b) => _revert * a.sum.compareTo(b.sum));
    }
    if (_sort == 3) {
      data.rowList.sort((a, b) => _revert * a.incomeSum.compareTo(b.incomeSum));
    }
    if (_sort == 4) {
      data.rowList.sort((a, b) => _revert * a.debt.compareTo(b.debt));
    }
    if (_sort == 5) {
      data.rowList.sort((a,b) => _revert * a.compareFuturePaymentsDates(b));
    }
    return data;
  }

  set sort(int index) {
    if (index >=0 && index <= 5) {
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
