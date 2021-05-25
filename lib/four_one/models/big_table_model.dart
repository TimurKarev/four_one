import 'package:cloud_firestore/cloud_firestore.dart';
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

  late String client;
  late String object;
  late String order;
  late String contract;
  late double sum;
  late DateTime finishDate;
  late PaymentScheduleModel payments;
  IncomesHistoryModel? incomes;

  BigTableModel();

  factory BigTableModel.fromFirebaseMap(Map<String, dynamic> data) {
    BigTableModel model = BigTableModel();
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
      paymentModel.paymentOptions = PaymentOptionValues.date;
      paymentModel.percentage = payment['percentage'];
      model.payments.payments.add(paymentModel);
    });

    final List<dynamic> incomesData = data['incomes'];
    model.incomes = IncomesHistoryModel();
    incomesData.forEach((income) {
      final map = income as Map<String, dynamic>;
      if (map.containsKey('date') && map.containsKey('incomeSum')) {
        IncomeModel incomeModel =
            IncomeModel(date: income['date'], incomeSum: income['incomeSum']);
        model.incomes!.incomes.add(incomeModel);
      }
    });
    return model;
  }
}
