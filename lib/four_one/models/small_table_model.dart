class SmallTableCard {
  final DateTime date;
  final String client;
  final String object;
  final String order;
  final num payment;
  final num clientDebt;

  SmallTableCard({
    required this.date,
    required this.client,
    required this.object,
    required this.order,
    required this.payment,
    required this.clientDebt,
  });
}

class SmallTableRowModel {
  final _month = [
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

  String getMonthName(int month) {
    if (month < 1 || month > 12) {
      return month.toString();
    }
    return _month[month-1];
  }

  final num monthIndex;
  final List<SmallTableCard> _cards = [];

  SmallTableRowModel({required this.monthIndex});

  void addCard(SmallTableCard card) => _cards.add(card);

  num get monthPayment {
    num monthSum = 0;
    _cards.forEach((card) {
      monthSum += card.payment;
    });
    return monthSum;
  }
}

class SmallTableModel {
  final List<SmallTableRowModel> _model = [];

  void addCard(num month, SmallTableCard card) {
    bool isMonthExist = false;
    _model.forEach((row) {
      if (month == row.monthIndex) {
        row.addCard(card);
        isMonthExist = true;
      }
    });
    if (!isMonthExist) {
      final newRow = SmallTableRowModel(monthIndex: month);
      newRow.addCard(card);
      _model.add(newRow);
    }
  }
}
