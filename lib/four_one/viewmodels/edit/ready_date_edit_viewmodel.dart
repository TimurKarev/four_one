import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/services/firebase/firebae_service.dart';
import 'package:four_one/four_one/services/firebase/paths.dart';

final readyDateEditProvider =
    ChangeNotifierProviderFamily<ReadyDateEditViewModel, DateTime>(
        (ref, date) => ReadyDateEditViewModel(reader: ref.read, date: date));

class ReadyDateEditViewModel extends ChangeNotifier {
  late DateTime _date;
  final Reader reader;

  ReadyDateEditViewModel({required this.reader, required date}) {
    _date = date;
  }

  set date(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  DateTime get date => _date;

  Future<bool> updateDatabase(String uid) async {
    return await reader(firebaseServiceProvider).updateDocument(FirebasePath.row(uid), {'finishDate': _date});
  }
}
