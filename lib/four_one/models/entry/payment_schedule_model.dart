import 'package:four_one/four_one/models/entry/payment_edit_model.dart';

class PaymentScheduleModel {
  List<PaymentEditModel> payments = [];

  PaymentScheduleModel();

  factory PaymentScheduleModel.clone(PaymentScheduleModel donor){
    PaymentScheduleModel newClass = PaymentScheduleModel();
    donor.payments.forEach((payment){
      final newPayment = PaymentEditModel.clone(donor: payment);
      newClass.payments.add(newPayment);
    });
    return newClass;
  }

  void resetModel(){
    payments = [];
  }

  double remindPaymentByDate(DateTime date){
    double retVal = 0.0;
    payments.forEach((payment) {
      if (date.isAfter(payment.date)) {
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
}