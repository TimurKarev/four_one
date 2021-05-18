import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/entry_model.dart';
import 'package:state_notifier/state_notifier.dart';

final createEntryProvider = StateNotifierProvider<CreateEntryViewModel, EntryModel>((ref){
  return CreateEntryViewModel();
});

final sumStream = StreamProvider.autoDispose<double>((ref) async*{
  print('sumStream');
  final d = ref.watch(createEntryProvider);
  yield d.sum;
});


class CreateEntryViewModel extends StateNotifier<EntryModel>{
  CreateEntryViewModel() : super(EntryModel());

  TextEditingController clientController = TextEditingController();
  TextEditingController objectController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  late TextEditingController sumController = TextEditingController(text: state.sum.toString());

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
    state = state;
  }
}