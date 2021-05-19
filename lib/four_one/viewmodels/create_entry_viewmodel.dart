import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry_model.dart';
import 'package:four_one/four_one/viewmodels/payment_schedule_viewmodel.dart';
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

  set showScheduleWidget(bool newValue) {
    if (!_showScheduleWidget && newValue){
      _resetPaymentSchedule();
    }
    _showScheduleWidget = newValue;
    state = state;
  }

  _resetPaymentSchedule(){
    reader(paymentScheduleProvider.notifier).init(state.sum);
  }

  bool get showScheduleWidget => _showScheduleWidget;

  late TextEditingController clientController = TextEditingController(text: state.client);
  late TextEditingController objectController = TextEditingController(text: state.object);
  late TextEditingController orderController = TextEditingController(text: state.order);
  late TextEditingController contractController = TextEditingController(text: state.contract);
  late TextEditingController sumController =
      TextEditingController(text: state.sum.toString());

  set date(DateTime newDate) {
    state.finishDate = newDate;
    state = state;
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
    }
    state.sum = sum;
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
}