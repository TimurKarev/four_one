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

class PaymentEditModel {
  late DateTime date;
  late PaymentOptionValues paymentOptions;
  late double percentage;
  late double cash;

  void init(){
    date = DateTime.now();
    paymentOptions = PaymentOptionValues.prepayment;
    percentage = 0.0;
    cash = 0.0;
  }
}