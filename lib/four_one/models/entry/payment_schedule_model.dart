import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
import 'package:four_one/four_one/models/project_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';

class PaymentScheduleModel {
  List<PaymentEditModel> payments = [];

  String get futurePaymentString {
    String str ='';
    payments.forEach((payment) {
      //print('income ${payment.date}');
      if (payment.date.isAfter(DateTime.now())){
        str += "${payment.cash} руб.   ${formatDate(payment.date)} \n";
      }
    });
    return str;
  }

  PaymentScheduleModel();

  factory PaymentScheduleModel.clone(PaymentScheduleModel donor){
    PaymentScheduleModel newClass = PaymentScheduleModel();
    donor.payments.forEach((payment) {
      final newPayment = PaymentEditModel.clone(donor: payment);
      newClass.payments.add(newPayment);
    });
    return newClass;
  }

  void resetModel() {
    payments = [];
  }

  double get fullSum {
    double retValue = 0.0;
    payments.forEach((element) {
      retValue += element.cash;
    });
    return retValue;
  }

  double pastPaymentsByDate(DateTime date) {
    double retVal = 0.0;
    payments.forEach((payment) {
      if (date.isAfter(payment.date)) {
        retVal += payment.cash;
      }
    });
    return retVal;
  }

  double futurePaymentsByDate(DateTime date) {
    double retVal = 0.0;
    payments.forEach((payment) {
      if(date.isBefore(payment.date)) {
        retVal += payment.cash;
      }
    });
    return retVal;
  }


  String get paymentString {
    String retString = '';
    payments.forEach((payment) {
      retString += payment.string + '\n';
    });
    return retString;
  }


  @override
  String toString() {
    String retStr = '';
    payments.forEach((element) {
      retStr += element.toString() + '\n';
    });
    return retStr;
  }

  DateTime getFirstDebtDate(IncomesHistoryModel incomes) {
    if (incomes.incomes.length <= 0) {
      return payments[0].date;
    }
    DateTime retDate = incomes.incomes.last.date;
    payments.forEach((payment) {
      if (pastPaymentsByDate(payment.date.add(Duration(days: 1))) >
          incomes.getIncomeSum() && retDate.isBefore(payment.date)) {
          retDate = payment.date;
      }
    });
    return retDate;
  }
}