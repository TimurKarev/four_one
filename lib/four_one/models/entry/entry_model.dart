import 'package:four_one/four_one/models/entry/payment_schedule_model.dart';

class EntryModel {
  String client = '';
  String object = '';
  String order = '';
  String contract = '';
  double sum = 0.0;
  late DateTime finishDate = DateTime.now().add(const Duration(days: 50));
  PaymentScheduleModel? payments;

  EntryModel(
      {this.client = '',
      this.object = '',
      this.order = '',
      this.contract = '',
      this.sum = 0.0,
      this.payments});

  factory EntryModel.fillTestData() {
    return EntryModel(
      client: 'ООО Возница',
      object: "ул Колесница",
      order: "1300 - 1243",
      contract: '123-345',
      sum: 10000000.0,
    );
  }

  @override
  String toString() {
    String string = client + ' \n';
    string += object + '\n';
    string += order + '\n';
    string += contract + '\n';
    string += sum.toString() + '\n';
    string += finishDate.toString() + '\n';
    string += payments.toString();

    return string;
  }
}
