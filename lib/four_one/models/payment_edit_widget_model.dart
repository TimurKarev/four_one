import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/cash_payment_textform.dart';
import 'package:four_one/four_one/ui/pay_schedule/percentage_payment_textform.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';

final paymentEditWidgetModelProvider = Provider((ref) => PaymentEditWidgetModel(ref.read));

class PaymentEditWidgetModel {
  final reader;

  double percentage = 0.0;
  double cash = 0.0;

  bool _checkBoxValue = false;

  PaymentEditWidgetModel(this.reader);

  bool get checkBoxValue => _checkBoxValue;

  void setNewCheckboxValue(bool newValue){
    _checkBoxValue = newValue;
    if (_checkBoxValue) {
      _calculatePercentage();
      _calculateCash();
    }
    reader(residualCheckboxProvider).update();
  }

  void _calculatePercentage() {
    percentage = 100.0;
    reader(percentagePaymentTextFormProvider).update();
  }

  void _calculateCash() {
    cash = 1000000.0;
    reader(cashPaymentTextFormProvider).update();
  }


  void onHandPayment(String str){
    print(str);
    if (_checkBoxValue){
      setNewCheckboxValue(false);
    }
  }
}