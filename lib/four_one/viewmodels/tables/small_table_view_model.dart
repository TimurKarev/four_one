import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';

final smallTableProvider =
    ChangeNotifierProvider((ref) => SmallTableViewModel());

class SmallTableViewModel extends ChangeNotifier {
    TableModel getTableModel(TableModel data) {
        List<BigTableModel> rotList = [];



        return TableModel(rowList: rotList);
    }
}
