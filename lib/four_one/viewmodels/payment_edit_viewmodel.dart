import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_model.dart';
import 'package:four_one/four_one/viewmodels/create_entry_viewmodel.dart';

final paymentEditProvider =
    StateNotifierProvider<PaymentEditViewModel, PaymentModel>((ref) {
  return PaymentEditViewModel(ref);
});

class PaymentEditViewModel extends StateNotifier<PaymentModel> {
  late final Reader read;
  final ProviderReference ref;
  bool saveButtonEnable = false;

  PaymentEditViewModel(this.ref) : super(PaymentModel()) {
    print('init inti');
    read = ref.read;
    state.init(
      initDate: read(createEntryProvider).finishDate,
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
