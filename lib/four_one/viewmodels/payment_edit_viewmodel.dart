import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_model.dart';
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
  }

  void init(double residual) {
    state.init();
    read(paymentInputViewModelProvider).init(residualSum: residual);
    state = state;
  }

  set date(DateTime newDate) {
    state.date = newDate;
    state = state;
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
    state = state;
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
