import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_schedule_model.dart';
import 'package:state_notifier/state_notifier.dart';

final paymentScheduleProvider = StateNotifierProvider<PaymentScheduleViewModel, PaymentScheduleModel>((ref){
  return PaymentScheduleViewModel();
});

class PaymentScheduleViewModel extends StateNotifier<PaymentScheduleModel>{
  late double fullSum;
  PaymentScheduleViewModel() : super(PaymentScheduleModel());

  void init(double sum){
    fullSum = sum;
    state.resetModel();
  }

  int get paymentLength => state.payments.length;
}