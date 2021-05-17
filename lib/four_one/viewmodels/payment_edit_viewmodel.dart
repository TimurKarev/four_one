import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentEditProvider = StateNotifierProvider<PaymentEditViewModel, PaymentEditModel>((ref){
  return PaymentEditViewModel(ref.read);
});

class PaymentEditModel {
  late DateTime date;

  PaymentEditModel init({required DateTime initDate}) {
    date = initDate;
    return this;
  }
}

class PaymentEditViewModel extends StateNotifier<PaymentEditModel> {
  final Reader read;
  PaymentEditViewModel(this.read) : super(PaymentEditModel()){
    state.init(initDate: DateTime(2019));
  }

  set date(DateTime newDate) {
    state = state.init(initDate: newDate);
  }
}
