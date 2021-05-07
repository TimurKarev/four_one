import 'package:flutter/material.dart';

class PayOptionValues {
  static final values = {
    'prepayment': 'аванс',
    'notification': "уведомление",
    'completed': 'готовность',
    'date': 'фиксированная дата',
    'shipment': 'отгрузка',
  };
}

class PayOptionsDropdown extends StatefulWidget {
  const PayOptionsDropdown({Key? key}) : super(key: key);

  @override
  _PayOptionsDropdownState createState() => _PayOptionsDropdownState();
}

class _PayOptionsDropdownState extends State<PayOptionsDropdown> {
  String _value = PayOptionValues.values['prepayment']!;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: _value,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            _value = newValue!;
          });
        },
        items: PayOptionValues.values.entries
            .map<DropdownMenuItem<String>>((m) {
          return DropdownMenuItem<String>(
            value: m.value,
            child: Text(m.value),
          );
        }).toList(),
      ),
    );
  }
}
