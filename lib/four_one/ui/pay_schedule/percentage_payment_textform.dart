// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:four_one/four_one/models/payment_edit_widget_model.dart';
// import 'package:four_one/four_one/ui/pay_schedule/residual_checkbox.dart';
//
// final percentagePaymentTextFormProvider =
//     ChangeNotifierProvider((ref) => PercentagePaymentTextFormNotifier());
//
// class PercentagePaymentTextFormNotifier extends ChangeNotifier {
//   void update() {
//     notifyListeners();
//   }
// }
//
// class PercentagePaymentTextForm extends StatefulWidget {
//   PercentagePaymentTextForm({Key? key}) : super(key: key);
//
//   @override
//   _PercentagePaymentTextFormState createState() =>
//       _PercentagePaymentTextFormState();
// }
//
// class _PercentagePaymentTextFormState extends State<PercentagePaymentTextForm> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final readProvider = context.read(paymentEditWidgetModelProvider);
//     _controller.text = readProvider.percentage.toString();
//
//     return ProviderListener(
//       provider: residualCheckboxProvider,
//       onChange: (BuildContext context, ResidualCheckboxNotifier _) {
//         _controller.text = readProvider.percentage.toString();
//       },
//       child: Container(
//         child: Column(
//           children: [
//             Text('проценты'),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 50.0,
//                   child: Focus(
//                     onFocusChange: (bool focus) {
//                       if (!focus) {
//                         _saveValue(readProvider);
//                       }
//                     },
//                     child: TextFormField(
//                       controller: _controller,
//                       onChanged: (String? str) {
//                         readProvider.onHandPayment();
//                       },
//                       onEditingComplete: () {
//                         // TODO: сделать возможным ввод запятой
//                         _saveValue(readProvider);
//                       },
//                     ),
//                   ),
//                 ),
//                 Text('%'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _saveValue(final read) {
//     read.percentage = double.parse(_controller.text);
//   }
// }
