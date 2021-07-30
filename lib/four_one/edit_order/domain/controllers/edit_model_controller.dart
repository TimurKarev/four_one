import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final providerEditModelController =
    StateNotifierProvider<EditModelController, String>((ref) {
  print("providerEditModelController");
  return EditModelController(ref.read);
});

class EditModelController extends StateNotifier<String> {
  Reader reader;

  EditModelController(this.reader) : super('Пустая строка');

  void clientFieldReady(String clientName) {
    if (clientName == '') {
      state = 'Пустая Строка';
    } else if (clientName == 'ЭСИ' || clientName == "ЛЭСР") {
      state = "Спец Форма";
    } else {
      state = "Стандартная строка";
    }
  }
}
