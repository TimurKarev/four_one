import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_model.dart';
import 'package:four_one/four_one/utils/date_formatter.dart';
import 'package:four_one/four_one/viewmodels/payment_input_viewmodel.dart';

final paymentEditProvider =
    StateNotifierProvider<PaymentEditViewModel, PaymentEditModel>((ref) {
  return PaymentEditViewModel(ref);
});

class PaymentEditViewModel extends StateNotifier<PaymentEditModel> {
  late final Reader read;
  final ProviderReference ref;
  bool saveButtonEnable = false;


  PaymentEditViewModel(this.ref) : super(PaymentEditModel()) {
    read = ref.read;
    state.init();
    updateString();
  }

  void init(double residual) {
    state.init();
    read(paymentInputViewModelProvider).init(residualSum: residual);
    updateString();
  }

  set date(DateTime newDate) {
    state.date = newDate;
    updateString();
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
    state.paymentOptions = newValue;
    updateString();
  }

  set percentage(double newVal) {
    state.percentage = newVal;
    updateString();
  }

  set cash(double newVal) {
    state.cash = newVal;
    updateString();
  }

  void updateString() {
    late String str;
    final String valueStr =
        'в размере ${state.cash} руб. (${state.percentage} %) не позднее ${formatDate(state.date)}г.';
    switch (state.paymentOptions) {
      case PaymentOptionValues.prepayment:
        str = 'Авансовый платеж ' + valueStr;
        break;
      case PaymentOptionValues.notification:
        str = 'Платеж после уведомления ' + valueStr;
        break;
      case PaymentOptionValues.completed:
        str = 'Платеж по готовности оборудования ' + valueStr;
        break;
      case PaymentOptionValues.date:
        str = 'Платеж ' + valueStr;
        break;
      case PaymentOptionValues.shipment:
        str = 'Платеж до отгрузки ' + valueStr;
        break;
    }
    state.string = str;
    state = state;
  }
}
