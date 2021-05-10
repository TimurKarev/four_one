import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_widget_model.dart';

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
    final readProvider = context.read(paymentEditWidgetModelProvider);

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
                      _saveValue(readProvider);
                    }
                  },
                  child: TextFormField(
                    controller: _getControllerByType(readProvider),
                    onChanged: (String? str) {
                      readProvider.onHandPayment();
                    },
                    onEditingComplete: () {
                      // TODO: сделать возможным ввод запятой
                      _saveValue(readProvider);
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

  void _saveValue(final read) {
    //read.cash = double.parse(_controller.text);
  }

  TextEditingController _getControllerByType(
      PaymentEditWidgetModel readProvider) {
    if (type == PaymentTextFormType.cash) {
      return readProvider.cashTextEditCtrl;
    } else {
      return readProvider.percentageTextEditCtrl;
    }
  }
}
