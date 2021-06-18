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

  factory BigTableModel.clone(BigTableModel donor) {
    final retVal = BigTableModel();

    retVal.id = donor.id;
    retVal.client = donor.client;
    retVal.object = donor.object;
    retVal.order = donor.order;
    retVal.contract = donor.contract;
    retVal.sum = donor.sum;
    retVal.finishDate = donor.finishDate;
    retVal.balance = donor.balance;
    retVal.payments = PaymentScheduleModel.clone(donor.payments);
    retVal.incomes = IncomesHistoryModel.clone(donor.incomes);

    return retVal;
  }

  int compareFuturePaymentsDates(BigTableModel model) {
    final selfFuturePayments = futureIncomes;
    final modelFuturePayments = model.futureIncomes;

    if (selfFuturePayments.payments.isEmpty && modelFuturePayments.payments.isEmpty) {
      return 0;
    }

    if (selfFuturePayments.payments.isEmpty && modelFuturePayments.payments.isNotEmpty) {
      return -1;
    }
    if (selfFuturePayments.payments.isNotEmpty && modelFuturePayments.payments.isEmpty) {
      return 1;
    }
    if (selfFuturePayments.payments[0].date.isAfter(modelFuturePayments.payments[0].date)) {
      return -1;
    } else if (selfFuturePayments.payments[0].date.isAtSameMomentAs(modelFuturePayments.payments[0].date)) {
      return 0;
    } else {
      return 1;
    }

    return 0;
  }

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
    return 'задолженность ${-1 * debtDuration} дней';
  }

  int get debtDuration {
    if (debt <= 0) {
      return 0;
    }

    int i = 0;
    DateTime? date = payments.payments.first.date;
    double balance = 0.0;
    while(true) {
      if (incomes.incomes.length == 0) {
        date = payments.payments.first.date;
        break;
      }

      if (incomes.incomes.length <= i && payments.payments.length > i) {
        if (balance > 0 ) {
          date =
          i > 0 ? payments.payments[i - 1].date : payments.payments.first.date;
        } else {
          date = payments.payments[i].date;
        }
        break;
      }

      if (payments.payments.length <= i) {
        //////////////////////////
        date = i>0 ? payments.payments[i-1].date : payments.payments.first.date;
        break;
      }

      if (payments.payments[i].date.isAfter(DateTime.now())){
        break;
      }
      double income = incomes.incomes[i].incomeSum;
      double payment = payments.payments[i].cash;
      if (balance < 0) {
        income -= balance;
      } else {
        payment += balance;
      }
      balance = payment - income;
      if (balance > 0 ) {
        date = payments.payments[i].date;
      }
      i++;
    }

    if (date == null) {
      return 0;
    }
    return date.difference(DateTime.now()).inDays;
  }

  List<double> get durationDebtAndFuture {
    final bool isDebt = debt > 0.0;
    double duration = 0;
    double sum = 0.0;

    if (isDebt) {
      duration = debtDuration.toDouble();
      sum = debt;
    } else {
      try {
        duration = futureIncomes.payments[0].date
            .difference(DateTime.now())
            .inDays.toDouble();
        sum = futureIncomes.payments[0].cash;
      } catch (e) {
        print('big_table_model get durationDebtAndFuture ${e.toString()}');
      }
    }
    return [duration, sum];
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
    int remInd = -1;
    for (var i = 0; i < retVal.payments.length; i++) {
      if (balance > 0) {
        if (balance >= retVal.payments[i].cash) {
          balance -= retVal.payments[i].cash;
          //retVal.payments.removeAt(i);
          remInd = i;
        } else {
          retVal.payments[i].cash -= balance;
          balance = 0;
        }
      }
    }
    if (remInd > 0) {
      retVal.payments.removeRange(0, remInd);
    } else if (remInd == 0) {
      retVal.payments.removeAt(remInd);
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
