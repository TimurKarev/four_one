import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';
import 'package:four_one/four_one/viewmodels/create_entry_viewmodel.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';

final paymentInputViewModelProvider =
    Provider((ref) => PaymentInputViewModel(ref.read));

class PaymentInputViewModel {
  PaymentInputViewModel(this.reader);

  void init({required double residualSum, double? percentage, double? cash}){
    _fullSum = reader(createEntryProvider).sum;
    _residualSum = residualSum;
    _percentage = 0.0;
    _cash = 0.0;
    if (percentage != null && cash != null){
      _percentage = percentage;
      _cash = cash;
    }
    percentageTextEditCtrl.text = _percentage.toString();
    cashTextEditCtrl.text = _cash.toString();
  }

  final Reader reader;

  TextEditingController cashTextEditCtrl = TextEditingController();
  TextEditingController percentageTextEditCtrl = TextEditingController();

  late double _fullSum;
  late double _residualSum;
  late double _percentage;
  late double _cash;

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
    reader(paymentEditProvider.notifier).percentage = _percentage;
  }

  void updateTextFormValuesFromCash(double cash) {
    _cash = cash;
    if ((_cash > _residualSum) || (_cash <= 0)) {
      _cash = _residualSum;
    }
    _cash = roundDouble(_cash);
    reader(paymentEditProvider.notifier).cash = _cash;
    _calculatePercentage();
    _updateTextFieldControllers();
  }

  void updateTextFormValuesFromPercentage(double percentage) {
    final cash = (_fullSum /100) * percentage;
    updateTextFormValuesFromCash(cash);
  }

  void _setResidualValues() {
    _cash = _residualSum;
    reader(paymentEditProvider.notifier).cash = _cash;
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
