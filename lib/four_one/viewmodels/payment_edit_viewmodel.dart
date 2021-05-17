import 'package:flutter_riverpod/flutter_riverpod.dart';

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
// List<String> toLst() {
//   return [
//       'Предоплата',
//       'Оповещение',
//       'По завершению',
//       'Фиксированная дата',
//       'Отгрузка',
//   ];
// }
}

final paymentEditProvider =
    StateNotifierProvider<PaymentEditViewModel, PaymentEditModel>((ref) {
  return PaymentEditViewModel(ref.read);
});

class PaymentEditModel {
  late DateTime _date;
  late PaymentOptionValues _paymentOptions;

  double percentage = 0.0;
  double cash = 0.0;

  DateTime get date => _date;

  PaymentOptionValues get paymentOptions => _paymentOptions;

  PaymentEditModel setDate(DateTime date) {
    _date = date;
    return this;
  }

  PaymentEditModel setOption(PaymentOptionValues newOption) {
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

class PaymentEditViewModel extends StateNotifier<PaymentEditModel> {
  final Reader read;
  bool saveButtonEnable = false;

  PaymentEditViewModel(this.read) : super(PaymentEditModel()) {
    state.init(
      initDate: DateTime(2019),
    );
  }

  set date(DateTime newDate) {
    state = state.setDate(newDate);
  }

  set option(String newOption) {
    late final PaymentOptionValues newValue;
    switch (newOption) {
      case 'Аванс':
        newValue = PaymentOptionValues.prepayment;
        break;
      case 'Уведомление':
        newValue = PaymentOptionValues.notification;
        break;
      case 'По завершению':
        newValue = PaymentOptionValues.completed;
        break;
      case 'Фиксированная дата':
        newValue = PaymentOptionValues.date;
        break;
      case 'Отгрузка':
        newValue = PaymentOptionValues.shipment;
        break;
    }
    state = state.setOption(newValue);
  }

  set percentage(double newVal) {
    state.percentage = newVal;
    state = state;
  }

  set cash(double newVal) {
    state.cash = newVal;
    state = state;
  }
}
