import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/edit_order/domain/controllers/edit_model_controller.dart';

final providerCommonOrderProvider =
    ChangeNotifierProvider((ref) => CommonOrderController(ref));

class CommonOrderController extends ChangeNotifier {
  final ProviderReference ref;
  late EditModelController _controller;
  final clientTextCtrl = TextEditingController();
  final objectTextCtrl = TextEditingController();
  final orderNumTextCtrl = TextEditingController();
  final contractTextCtrl = TextEditingController();

  CommonOrderController(this.ref) {
    _controller = ref.watch(providerEditModelController.notifier);
    // _controller.addListener((state) {
    //   print("Listener CommonOrderController");
    //   clientTextCtrl.text = state;
    //   notifyListeners();
    // });
  }

  void clientTextEditComplete() => _clientTextEditFinished();

  void clientTextFieldLooseFocus() => _clientTextEditFinished();

  void _clientTextEditFinished() {
    print("_clientTextEditFinished ");
    _controller.clientFieldReady(clientTextCtrl.text);
  }
}
