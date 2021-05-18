import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';
import 'package:state_notifier/state_notifier.dart';

final createEntryProvider = StateNotifierProvider<CreateEntryViewModel, EntryModel>((ref){
  return CreateEntryViewModel();
});

class EntryModel {
  String client = '';
  String object = '';
  String order = '';
  String contract = '';
  double sum = 0.0;
  late DateTime finishDate = DateTime.now().add(const Duration(days: 50));
  List<PaymentModel> payments = [];
}

class CreateEntryViewModel extends StateNotifier<EntryModel>{
  CreateEntryViewModel() : super(EntryModel());

  TextEditingController clientController = TextEditingController();
  TextEditingController objectController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  TextEditingController sumController = TextEditingController();
}