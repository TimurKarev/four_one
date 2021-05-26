import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/services/firebase/firebae_service.dart';
import 'package:four_one/four_one/services/firebase/paths.dart';

final incomeDialogProvider = ChangeNotifierProvider<IncomeDialogViewModel>((ref){
  return IncomeDialogViewModel(ref.read);
});

class IncomeDialogViewModel extends ChangeNotifier {
  final Reader reader;
  double sum = 0.0;
  int days = 0;

  IncomeDialogViewModel(this.reader);

  Future<bool> updateDataBase(String id) async {
    final firebaseProvider = reader(firebaseServiceProvider);
    final String path = FirebasePath.row(id);

    final Map<String, dynamic> oldData = await firebaseProvider.getDocument(path);
    Map<String, dynamic> newData = {};
    Map<String, dynamic> newIncome = {
      'date': DateTime.now().subtract(Duration(days: days)),
      'incomeSum': sum,
    };

    if (oldData.containsKey('incomes')) {
      List<dynamic> incomes = oldData['incomes'] as List<dynamic>;
      incomes.add(newIncome);
      newData['incomes'] = incomes;
    } else {
      newData['incomes'] = [newIncome];
    }
    print(newData.toString());
    return firebaseProvider.updateDocument(path, newData);
  }

}