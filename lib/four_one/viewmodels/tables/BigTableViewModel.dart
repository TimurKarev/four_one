import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/services/firebase/firebae_service.dart';
import 'package:four_one/four_one/services/firebase/paths.dart';

final bigTableDataProvider = Provider<BigTableViewModel>((ref) {
  return BigTableViewModel(ref: ref);
});

class BigTableViewModel {
  final ProviderReference ref;
  List<BigTableModel> modelList = [];

  BigTableViewModel({required this.ref});

  double get debt {
    double retVal = 0.0;
    if (modelList.isEmpty) {
      return retVal;
    }
    modelList.forEach((model) {
      retVal += model.debt;
    });
    return retVal;
  }

  double get futureIncome {
    double retVal = 0.0;
    if (modelList.isEmpty) {
      return retVal;
    }
    modelList.forEach((model) {
      retVal += model.futurePayment;
    });
    return retVal;
  }

  Stream<List<BigTableModel>> tableDataStream() {
    Stream<QuerySnapshot> snapshot =
        ref.watch(firebaseServiceProvider).collectionStream(path: FirebasePath.Table);
    return snapshot.map((event) {
      List<BigTableModel> rowsList = [];
      event.docs.forEach((element) {
        final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        rowsList.add(BigTableModel.fromFirebaseMap(data, element.id));
      });
      modelList = rowsList;
      return rowsList;
    });
  }
}
