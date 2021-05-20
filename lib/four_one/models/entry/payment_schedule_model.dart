import 'package:four_one/four_one/models/entry/payment_edit_model.dart';

class PaymentScheduleModel {
  List<PaymentEditModel> payments = [];

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