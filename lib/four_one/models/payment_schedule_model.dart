import 'package:four_one/four_one/models/payment_edit_model.dart';

class PaymentScheduleModel {
  List<PaymentEditModel> payments = [];

  void resetModel(){
    payments = [];
  }
}