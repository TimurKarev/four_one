import 'entry/entry_model.dart';
import 'entry/payment_schedule_model.dart';
import 'entry/payment_edit_model.dart';

class ProjectModel {
  ProjectModel(EntryModel entryModel) {
    client = entryModel.client;
    object = entryModel.object;
    order = entryModel.order;
    contract = entryModel.contract;
    sum = entryModel.sum;
    finishDate = entryModel.finishDate;
    payments = PaymentScheduleModel.clone(entryModel.payments!);
  }

  late String client;
  late String object;
  late String order;
  late String contract;
  late double sum;
  late DateTime finishDate;
  late PaymentScheduleModel payments;
  IncomesHistoryModel? incomes;

  Map<String, dynamic> toFirebaseJson() {
    Map<String, dynamic> retMap = {};
    retMap['client'] = client;
    retMap['object'] = object;
    retMap['order'] = order;
    retMap['contract'] = contract;
    retMap['sum'] = sum;
    retMap['finishDate'] = finishDate;
    List<Map<String, dynamic>> paymentsList = [];
    payments.payments.forEach((element) {
      final pay = {
        'date': element.date,
        'percentage': element.percentage,
        'paymentOption': element.paymentOptions.toStr(),
        'cash': element.cash,
        'string': element.string,
      };
      paymentsList.add(pay);
    });
    retMap['payments'] = paymentsList;
//    retMap['incomes'] = [{}];

    return retMap;
  }

}

class IncomesHistoryModel {
  List<IncomeModel>? incomes;

  double getIncomeSum(){
    if (incomes == null){
      return 0.0;
    }
    double retVal = 0.0;
    incomes!.forEach((element) {
      retVal += element.incomeSum;
    });
    return retVal;
  }
}

class IncomeModel {
  DateTime date;
  double incomeSum;

  IncomeModel({required this.date, required this.incomeSum});
}
