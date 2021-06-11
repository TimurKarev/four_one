import 'package:four_one/four_one/utils/formatters.dart';

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
  PaymentEditModel();

  late DateTime date;
  late PaymentOptionValues paymentOptions;
  late double percentage;
  late double cash;
  late String string;

  void init() {
    date = DateTime.now();
    paymentOptions = PaymentOptionValues.prepayment;
    percentage = 0.0;
    cash = 0.0;
  }

  String updateString() {
    string =
        'Платеж в размере ${getFormatNum(cash.toString())} руб. ($percentage)% не позднее ${formatDate(date)}';
    return string;
  }

  @override
  String toString() {
    String retStr = '';
    retStr = date.toString();
    retStr += ' ' + paymentOptions.toStr();
    retStr += ' ' + percentage.toString();
    retStr += ' ' + cash.toString();
    retStr += ' ' + string;
    return retStr;
  }

  factory PaymentEditModel.clone({required PaymentEditModel donor}) {
    PaymentEditModel newClass = PaymentEditModel();

    newClass.date = donor.date;
    newClass.paymentOptions = donor.paymentOptions;
    newClass.percentage = donor.percentage;
    newClass.string = donor.string;
    newClass.cash = donor.cash;

    return newClass;
  }
}
