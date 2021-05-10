import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/payment_edit_widget_model.dart';
import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';

final cashPaymentTextFormProvider =
ChangeNotifierProvider((ref) => CashPaymentTextFormNotifier());

class CashPaymentTextFormNotifier extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}

class CashPaymentTextForm extends StatefulWidget {
  CashPaymentTextForm({Key? key}) : super(key: key);

  @override
  _CashPaymentTextFormState createState() =>
      _CashPaymentTextFormState();
}

class _CashPaymentTextFormState extends State<CashPaymentTextForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final readProvider = context.read(paymentEditWidgetModelProvider);
    _controller.text = readProvider.cash.toString();

    return ProviderListener(
      provider: residualCheckboxProvider,
      onChange: (BuildContext context, ResidualCheckboxNotifier _) {
        _controller.text = readProvider.cash.toString();
      },
      child: Container(
        child: Column(
          children: [
            Text('рубли'),
            Row(
              children: [
                SizedBox(
                  width: 100.0,
                  child: Focus(
                    onFocusChange: (bool focus) {
                      if (!focus) {
                        _saveValue(readProvider);
                      }
                    },
                    child: TextFormField(
                      controller: _controller,
                      onChanged: (String? str) {
                        // readProvider.cash =
                        //     double.parse(_controller.text);
                        readProvider.onHandPayment(_controller.text);
                      },
                      onEditingComplete: () {
                        // TODO: сделать возможным ввод запятой
                        _saveValue(readProvider);
                      },
                    ),
                  ),
                ),
                Text('Р'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveValue(final read) {
    read.cash = double.parse(_controller.text);
  }
}
