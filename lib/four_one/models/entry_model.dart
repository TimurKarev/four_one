
import 'package:four_one/four_one/models/payment_schedule_model.dart';

class EntryModel {
  String client = 'ООО Пирожок';
  String object = 'Атласс сити';
  String order = 'Курлядская';
  String contract = '23-346 К';
  double sum = 100000.0;
  late DateTime finishDate = DateTime.now().add(const Duration(days: 50));
  PaymentScheduleModel? payments;
}