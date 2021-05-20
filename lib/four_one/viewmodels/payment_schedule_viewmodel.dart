import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_model.dart';
import 'package:four_one/four_one/models/payment_schedule_model.dart';
import 'package:four_one/four_one/viewmodels/create_entry_viewmodel.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';
import 'package:state_notifier/state_notifier.dart';

final paymentScheduleProvider = StateNotifierProvider<PaymentScheduleViewModel, PaymentScheduleModel>((ref){
  return PaymentScheduleViewModel(ref.read);
});

class PaymentScheduleViewModel extends StateNotifier<PaymentScheduleModel>{
  final Reader reader;
  late double fullSum;

  PaymentScheduleViewModel(this.reader) : super(PaymentScheduleModel());

  int get paymentLength => state.payments.length;

  void init(double sum){
    fullSum = sum;
    state.resetModel();
    _initEditModel();
    reader(createEntryProvider.notifier).saveButtonChangeEnable();
    state = state;
  }

  void savePayment(){
    final model = reader(paymentEditProvider);
    state.payments.add(PaymentEditModel.clone(donor: model));
    _initEditModel();
    reader(createEntryProvider.notifier).saveButtonChangeEnable();
    state = state;
  }

  void deletePayment(int index) {
    state.payments.removeAt(index);
    _initEditModel();
    reader(createEntryProvider.notifier).saveButtonChangeEnable();
    state = state;
  }

  bool isPaymentsComplete(){
    if (_getResidualSum() == 0 && paymentLength > 0){
      return true;
    }
    return false;
  }

  void _initEditModel() {
    final residual = _getResidualSum();
    reader(paymentEditProvider.notifier).init(residual);
  }

  double _getResidualSum() {
    try {
      final double check = fullSum;
    } catch (LateInitializationError) {
      return double.infinity;
    }

    double retSum = fullSum;
    state.payments.forEach((payment) {
      retSum -= payment.cash;
    });
    return retSum;
  }
}