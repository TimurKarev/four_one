import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry/entry_model.dart';
import 'package:four_one/four_one/viewmodels/entry/payment_schedule_viewmodel.dart';
import 'package:state_notifier/state_notifier.dart';

final createEntryProvider =
    StateNotifierProvider<CreateEntryViewModel, EntryModel>((ref) {
  return CreateEntryViewModel(ref.read);
});

class CreateEntryViewModel extends StateNotifier<EntryModel> {
  final Reader reader;
  CreateEntryViewModel(this.reader) : super(EntryModel());

  bool addButtonEnabled = false;
  bool _showScheduleWidget = false;
  bool _saveButtonEnabled = false;

  bool get showScheduleWidget => _showScheduleWidget;

  set showScheduleWidget(bool newValue) {
    if (!_showScheduleWidget && newValue){
      _resetPaymentSchedule();
    }
    _showScheduleWidget = newValue;
    state = state;
  }

  bool get saveButtonEnabled => _saveButtonEnabled;

  late TextEditingController clientController = TextEditingController(text: state.client);
  late TextEditingController objectController = TextEditingController(text: state.object);
  late TextEditingController orderController = TextEditingController(text: state.order);
  late TextEditingController contractController = TextEditingController(text: state.contract);
  late TextEditingController sumController =
      TextEditingController(text: state.sum.toString());

  _resetPaymentSchedule(){
    reader(paymentScheduleProvider.notifier).init(state.sum);
  }

  set date(DateTime newDate) {
    state.finishDate = newDate;
    saveButtonChangeEnable();
    state = state;
  }

  List<EntryModel> testList = [];

  void saveEntry(){
      update();
      state.payments = reader(paymentScheduleProvider);
      testList.add(state);
      testList.forEach((element) {print(element.toString());});
  }

  void update() {
    final sum = double.parse(sumController.text);
    state.client = clientController.text;
    state.object = objectController.text;
    state.order = orderController.text;
    state.contract = contractController.text;

    if (_checkReadyScheduleState()){
      addButtonEnabled = true;
      if (state.sum != sum) {
        state.sum = sum;
        _resetPaymentSchedule();
      }
    } else {
      addButtonEnabled = false;
      _saveButtonEnabled = false;
    }
    state.sum = sum;
    saveButtonChangeEnable();
    state = state;
  }

  bool _checkReadyScheduleState() {
    if (state.sum > 0.0 &&
        state.contract.length > 0 &&
        state.order.length > 0 &&
        state.object.length > 0 &&
        state.client.length > 0 &&
        state.finishDate.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  void saveButtonChangeEnable(){
    bool oldValue = _saveButtonEnabled;
    _saveButtonEnabled = false;
    final isPaymentComplete = reader(paymentScheduleProvider.notifier).isPaymentsComplete();
    final isAllFormsReady = _checkReadyScheduleState();
    if (isPaymentComplete && isAllFormsReady ){
      _saveButtonEnabled = true;
    }
    if (oldValue != _saveButtonEnabled){
      state = state;
    }
  }
}