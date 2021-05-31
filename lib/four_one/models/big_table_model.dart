import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
import 'package:four_one/four_one/models/entry/payment_schedule_model.dart';
import 'package:four_one/four_one/models/project_model.dart';

class BigTableModel {
  static const columns = [
    'Заказчик',
    "Объект",
    "Сумма",
    "Оплачено",
    "Долг",
    "Остаток",
  ];

  late String id;
  late String client;
  late String object;
  late String order;
  late String contract;
  late double sum;
  late DateTime finishDate;
  late PaymentScheduleModel payments;
  late IncomesHistoryModel incomes;

  late double balance;

  String get futureIncomeString => incomes.incomeLegend;
  BigTableModel();

  String get debtString  {
    if (debt <= 0.0) {
      return '';
    }
    DateTime firstDate = payments.getFirstDebtDate(incomes);
    final diff = DateTime.now().difference(firstDate);

    return 'задолженность - ${diff.inDays.toString()} дней';
  }

  String get incomeString => incomes.incomeLegend;

  double get reminderSum => sum - incomes.getIncomeSum();

  String get paymentLegend => payments.paymentString;

  String get incomeSum => incomes.getIncomeSum().toString();

  double get debt {
    double retVal = payments.remindPaymentByDate(DateTime.now()) - incomes.getIncomeSum();
    if (retVal < 0) {
      retVal = 0.0;
    }
    return retVal;
  }

  factory BigTableModel.fromFirebaseMap(Map<String, dynamic> data, String uid) {
    BigTableModel model = BigTableModel();
    model.id = uid;
    model.client = data['client'];
    model.object = data['object'];
    model.order = data['order'];
    model.contract = data['contract'];
    model.sum = data['sum'];
    final Timestamp timestamp = data['finishDate'];
    model.finishDate = timestamp.toDate();

    final List<dynamic> paymentsData = data['payments'];
    model.payments = PaymentScheduleModel();
    paymentsData.forEach((payment) {
      PaymentEditModel paymentModel = PaymentEditModel();
      paymentModel.string = payment['string'];
      paymentModel.cash = payment['cash'];
      paymentModel.date = payment['date'].toDate();
      paymentModel.paymentOptions = PaymentOptionValues.date;
      paymentModel.percentage = payment['percentage'];
      model.payments.payments.add(paymentModel);
    });

    model.incomes = IncomesHistoryModel();
    if (data.containsKey('incomes')) {
      final List<dynamic> incomesData = data['incomes'];
      incomesData.forEach((income) {
        final map = income as Map<String, dynamic>;
        if (map.containsKey('date') && map.containsKey('incomeSum')) {
          IncomeModel incomeModel =
              IncomeModel(date: income['date'].toDate(), incomeSum: income['incomeSum']);
          if (model.incomes.incomes == null){
            model.incomes.incomes = [incomeModel];
          } else {
            model.incomes.incomes!.add(incomeModel);
          }
        }
      });
    }
    return model;
  }
}
