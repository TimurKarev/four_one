import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/percentage_payment_textform.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';

final paymentEditWidgetModelProvider =
    Provider((ref) => PaymentEditWidgetModel(ref.read));

class PaymentEditWidgetModel {
  final reader;

  TextEditingController cashTextEditCtrl = TextEditingController();
  TextEditingController percentageTextEditCtrl = TextEditingController();

  double _residualSum = 1000000.0;
  double _percentage = 0.0;
  double _cash = 0.0;

  bool _checkBoxValue = false;

  PaymentEditWidgetModel(this.reader);

  bool get checkBoxValue => _checkBoxValue;

  void setNewCheckboxValue(bool newValue) {
    _checkBoxValue = newValue;
    if (_checkBoxValue) {
      _calculatePercentage();
      _calculateCash();
    }
    reader(residualCheckboxProvider).update();
  }

  void _calculatePercentage() {
    percentageTextEditCtrl.text = '100';
  }

  void _calculateCash() {
    cashTextEditCtrl.text = '1000000';
  }

  void onHandPayment() {
    //print(str);
    if (_checkBoxValue) {
      setNewCheckboxValue(false);
    }
  }
}
