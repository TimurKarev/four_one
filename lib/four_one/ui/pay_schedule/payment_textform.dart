import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:four_one/four_one/viewmodels/entry/payment_input_viewmodel.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

enum PaymentTextFormType {
  percentage,
  cash,
}

class PaymentTextForm extends StatelessWidget {
  final double formWidth;
  final String headerText;
  final String postfixText;
  final PaymentTextFormType type;

  const PaymentTextForm(
      {Key? key,
      required this.headerText,
      required this.postfixText,
      required this.type,
      required this.formWidth})
      : super(key: key);

  factory PaymentTextForm.cash() {
    return PaymentTextForm(
      headerText: 'Рубли',
      postfixText: 'P',
      type: PaymentTextFormType.cash,
      formWidth: 100.0,
    );
  }

  factory PaymentTextForm.percentage() {
    return PaymentTextForm(
      headerText: 'Проценты',
      postfixText: '%',
      type: PaymentTextFormType.percentage,
      formWidth: 50.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentModel = context.read(paymentInputViewModelProvider);

    return Container(
      child: Column(
        children: [
          Text(headerText),
          Row(
            children: [
              SizedBox(
                width: formWidth,
                child: Focus(
                  onFocusChange: (bool focus) {
                    if (!focus) {
                      _updateTextFormValues(paymentModel);
                    }
                  },
                  child: TextFormField(
                    controller: _getControllerByType(paymentModel),
                    onChanged: (String? str) {
                      paymentModel.setNewCheckboxValue(false);
                    },
                    inputFormatters: [
                      ThousandsFormatter(allowFraction: true),
                    ],
                    onEditingComplete: () {
                      _updateTextFormValues(paymentModel);
                    },
                  ),
                ),
              ),
              Text(postfixText),
            ],
          ),
        ],
      ),
    );
  }

  TextEditingController _getControllerByType(PaymentInputViewModel model) {
    if (type == PaymentTextFormType.cash) {
      return model.cashTextEditCtrl;
    } else {
      return model.percentageTextEditCtrl;
    }
  }

  void _updateTextFormValues(PaymentInputViewModel model) {
    late final String text;
    if (type == PaymentTextFormType.cash) {
      text = _getControllerByType(model).text;
      if (text.length > 0) {
        model.updateTextFormValuesFromCash(double.parse(getNumFromFormatString(text)));
      }
    } else {
      text = _getControllerByType(model).text;
      if (text.length > 0) {
        model.updateTextFormValuesFromPercentage(double.parse(getNumFromFormatString(text)));
      }
    }
  }
}
