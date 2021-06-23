import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/models/small_table_model.dart';

final smallTableProvider =
    ChangeNotifierProvider((ref) => SmallTableViewModel());

class SmallTableViewModel extends ChangeNotifier {
  late SmallTableModel _model;

  double _slider = 5;

  double get slider => _slider;

  set slider(double newValue) {
    _slider = newValue;
    notifyListeners();
  }

  SmallTableModel init(TableModel data) {
    List<SmallTableCard> allCards = [];
    data.rowList.forEach((project) {
      final futureIncomes = project.futureIncomes.payments;
      if (futureIncomes.isNotEmpty) {
        futureIncomes.forEach((payment) {
          allCards.add(SmallTableCard(
            object: project.object,
            order: project.order,
            date: payment.date,
            client: project.client,
            payment: payment.cash,
            clientDebt: data.getClientDebt(project.client),
          ));
        });
      }
    });
    SmallTableModel model = SmallTableModel();
    if (allCards.isNotEmpty) {
      allCards.forEach((card) {
        final num monthInd = _getMonthIndexBySlider(card.date);
        model.addCard(monthInd, card);
      });
    }
    _model = model;
    return _model;
  }

  num _getMonthIndexBySlider(DateTime date) {
    final oldMonth = date.month;
    final newMonth = date.add(Duration(days: slider.toInt())).month;
    return oldMonth == newMonth ? oldMonth : newMonth;
  }
}