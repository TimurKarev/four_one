import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_model.dart';
import 'package:four_one/four_one/viewmodels/create_entry_viewmodel.dart';


class EntryModel {
  String client = '';
  String object = '';
  String order = '';
  String contract = '';
  double sum = 0.0;
  late DateTime finishDate = DateTime.now().add(const Duration(days: 50));
  List<PaymentModel> payments = [];
}