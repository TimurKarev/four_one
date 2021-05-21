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

  @override
  String toString() {
    String retStr = '';
    payments.forEach((element) {
      retStr += element.toString() + '\n';
    });
    return retStr;
  }
}