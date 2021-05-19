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
      reader(paymentScheduleProvider.notifier).init(state.sum);
    }
    _showScheduleWidget = newValue;
    state = state;
  }

  bool get showScheduleWidget => _showScheduleWidget;

  TextEditingController clientController = TextEditingController();
  TextEditingController objectController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  late TextEditingController sumController =
      TextEditingController(text: state.sum.toString());

  set date(DateTime newDate) {
    state.finishDate = newDate;
    state = state;
  }

  void update() {
    state.client = clientController.text;
    state.object = objectController.text;
    state.order = orderController.text;
    state.contract = contractController.text;
    state.sum = double.parse(sumController.text);
    if (_checkReadyScheduleState()){
      addButtonEnabled = true;
    } else {
      addButtonEnabled = false;
    }
    //print('Add button $addButton');
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
