import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_model.dart';
import 'package:four_one/four_one/utils/date_formatter.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';

class PaymentStringWidget extends ConsumerWidget {
  const PaymentStringWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final editModel = watch(paymentEditProvider);
    return Container(
      child: Text(
        _getStringByEditModel(editModel),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }

  String _getStringByEditModel(PaymentModel model) {
    late String str;
    final String valueStr =
        'в размере ${model.cash} руб. (${model.percentage} %) не позднее ${formatDate(model.date)}г.';
    switch (model.paymentOptions) {
      case PaymentOptionValues.prepayment:
        str = 'Авансовый платеж ' + valueStr;
        break;
      case PaymentOptionValues.notification:
        str = 'Платеж после уведомления' + valueStr;
        break;
      case PaymentOptionValues.completed:
        str = 'Платеж по готовности оборудования' + valueStr;
        break;
      case PaymentOptionValues.date:
        str = 'Платеж ' + valueStr;
        break;
      case PaymentOptionValues.shipment:
        str = 'Платеж до отгрузки ' + valueStr;
        break;
    }
    return str;
  }
}
