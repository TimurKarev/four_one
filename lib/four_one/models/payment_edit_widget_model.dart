import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/payment_textform.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';

final paymentEditWidgetModelProvider =
    Provider((ref) => PaymentEditWidgetModel(ref.read));

class PaymentEditWidgetModel {
  PaymentEditWidgetModel(this.reader);

  final reader;

  TextEditingController cashTextEditCtrl = TextEditingController();
  TextEditingController percentageTextEditCtrl = TextEditingController();

  double _fullSum = 10000000.0;
  double _residualSum = 1000000.0;
  double _percentage = 0.0;
  double _cash = 0.0;

  bool _checkBoxValue = false;

  bool get checkBoxValue => _checkBoxValue;

  void setNewCheckboxValue(bool newValue) {
    _checkBoxValue = newValue;
    if (_checkBoxValue) {
      _setResidualValues();
    }
    reader(residualCheckboxProvider).update();
  }

  void _calculatePercentage() {
    final k = _fullSum / _cash;
    _percentage = 100 / k;
    _percentage = roundDouble(_percentage);
  }

  void updateTextFormValuesFromCash(double cash) {
    _cash = cash;
    if ((_cash > _residualSum) || (_cash <= 0)) {
      _cash = _residualSum;
    }
    _cash = roundDouble(_cash);
    _calculatePercentage();
    _updateTextFieldControllers();
  }

  void updateTextFormValuesFromPercentage(double percentage) {
    final cash = (_fullSum /100) * percentage;
    updateTextFormValuesFromCash(cash);
  }

  void _setResidualValues() {
    _cash = _residualSum;
    _calculatePercentage();
    _updateTextFieldControllers();
  }

  void _updateTextFieldControllers() {
    percentageTextEditCtrl.text = _percentage.toString();
    cashTextEditCtrl.text = _cash.toString();
  }

  double roundDouble(double value, [int places=2]){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
