import 'package:flutter/material.dart';

class PaymentSaveButton extends StatelessWidget {
  const PaymentSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Добавить'),
          SizedBox(height: 13.0),
          SizedBox(
            width: 40.0,
            child: ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
