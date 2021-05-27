import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
import 'package:four_one/four_one/models/entry/payment_schedule_model.dart';

final paymentsEditProvider =
    ChangeNotifierProviderFamily<PaymentEditViewModel, PaymentScheduleModel>(
        (ref, model) {
  return PaymentEditViewModel(read: ref.read, model: model);
});

class PaymentEditViewModel extends ChangeNotifier {
  PaymentEditViewModel({required this.model, required this.read}) {
    sum = model.fullSum;
  }

  final PaymentScheduleModel model;
  final Reader read;
  late final double sum;
  bool enableOk = true;

  List<PaymentEditModel> get payments => model.payments;

  void sumFieldChanged(String newVal, PaymentEditModel payment) {
    payment.cash = double.parse(newVal);
    bool oldVal = enableOk;
    if (sum != model.fullSum) {
      enableOk = false;
    } else {
      enableOk = true;
    }

    if (oldVal != enableOk) {
      notifyListeners();
    }
  }

  void dateFieldChanged(DateTime newDate, PaymentEditModel payment){
    payment.date = newDate;
    notifyListeners();
  }

  Future<bool> updateDataBase(String id) async {
    List<dynamic>  data = [];
    payments.forEach((payment) {
      data.add(
        {
          'date': payment.date,
          'paymentOption': payment.paymentOptions.toStr(),
          'percentage': payment.percentage,
          'cash': payment.cash,
          'string': payment.string,
        }
      );
    });
    read(firestore)
    return false;

  }
}
