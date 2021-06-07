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
    "Даты платежей",
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

  BigTableModel();

  double get futurePayment {
    final balance = balanceByDate(DateTime.now());
    final futPay = payments.futurePaymentsByDate(DateTime.now());

    if (balance < 0.0) {
      return futurePayments;
    }
    final retVal = futPay - balance;
    return retVal;
  }

  double balanceByDate(DateTime date) =>
      incomeSum - payments.pastPaymentsByDate(date);

  String get futureIncomeString => payments.futurePaymentString;

  String get debtString {
    if (debt <= 0.0) {
      return '';
    }
    DateTime firstDate = payments.getFirstDebtDate(incomes);
    final diff = DateTime.now().difference(firstDate);

    return 'задолженность - ${diff.inDays.toString()} дней';
  }

  ///Return full income string with past payments
  String get incomeString => incomes.incomeLegend;

  double get reminderSum => sum - incomes.getIncomeSum();

  double get futurePayments => payments.futurePaymentsByDate(DateTime.now());

  String get paymentLegend => payments.paymentString;

  double get incomeSum => incomes.getIncomeSum();

  double get debt {
    double retVal =
        payments.pastPaymentsByDate(DateTime.now()) - incomes.getIncomeSum();
    if (retVal < 0) {
      retVal = 0.0;
    }
    return retVal;
  }

  ///Returns calculating future incomes
  PaymentScheduleModel get futureIncomes {
    PaymentScheduleModel retVal = PaymentScheduleModel.clone(payments);

    // print(retVal.toString());
    retVal.removePastPayments();
    // print(retVal.toString());
    // print('-----------------------------');

    var balance = balanceByDate(DateTime.now());

    for (var i = 0; i < retVal.payments.length; i++) {
      if (balance > 0) {
        if (balance >= retVal.payments[i].cash) {
          balance += retVal.payments[i].cash;
          retVal.payments.removeAt(i);
        } else {
          retVal.payments[i].cash -= balance;
        }
      }
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
          IncomeModel incomeModel = IncomeModel(
              date: income['date'].toDate(), incomeSum: income['incomeSum']);
          if (model.incomes.incomes.length <= 0) {
            model.incomes.incomes = [incomeModel];
          } else {
            model.incomes.incomes.add(incomeModel);
          }
        }
      });
    }
    return model;
  }
}
