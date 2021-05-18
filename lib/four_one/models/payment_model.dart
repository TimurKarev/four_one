enum PaymentOptionValues {
  prepayment,
  notification,
  completed,
  date,
  shipment,
}

extension ParseToString on PaymentOptionValues {
  String toStr() {
    switch (this) {
      case PaymentOptionValues.prepayment:
        return 'Аванс';
      case PaymentOptionValues.notification:
        return 'Уведомление';
      case PaymentOptionValues.completed:
        return 'По завершению';
      case PaymentOptionValues.date:
        return 'Фиксированная дата';
      case PaymentOptionValues.shipment:
        return 'Отгрузка';
    }
  }
}


class PaymentModel {
  late DateTime _date;
  late PaymentOptionValues _paymentOptions;

  double percentage = 0.0;
  double cash = 0.0;

  DateTime get date => _date;

  PaymentOptionValues get paymentOptions => _paymentOptions;

  PaymentModel setDate(DateTime date) {
    _date = date;
    return this;
  }

  PaymentModel setOption(PaymentOptionValues newOption) {
    _paymentOptions = newOption;
    return this;
  }

  void init({
    required DateTime initDate,
  }) {
    _date = initDate;
    _paymentOptions = PaymentOptionValues.prepayment;
  }
}