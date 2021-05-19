import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_schedule_model.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';
import 'package:state_notifier/state_notifier.dart';

final paymentScheduleProvider = StateNotifierProvider<PaymentScheduleViewModel, PaymentScheduleModel>((ref){
  return PaymentScheduleViewModel(ref.read);
});

class PaymentScheduleViewModel extends StateNotifier<PaymentScheduleModel>{
  final Reader reader;
  late double fullSum;

  PaymentScheduleViewModel(this.reader) : super(PaymentScheduleModel());

  void init(double sum){
    fullSum = sum;
    state.resetModel();
    _initEditModel();
  }

  int get paymentLength => state.payments.length;

  void _initEditModel() {
    final residual = _getResidualSum();
    reader(paymentEditProvider.notifier).init(residual);
  }

  double _getResidualSum() {
    double retSum = fullSum;
    state.payments.forEach((payment) {
      retSum -= payment.cash;
    });
    return retSum;
  }
}