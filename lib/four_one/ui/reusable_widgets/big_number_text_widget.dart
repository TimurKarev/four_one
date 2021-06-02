import 'package:flutter/material.dart';

class BigNumberTextWidget extends StatelessWidget {
  const BigNumberTextWidget({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  Widget build(BuildContext context) {
    List<String> lstr = number.split('.');
    String intnum = lstr[0];
    String dubnum = '';
    if (lstr.length > 1) {
     dubnum =  lstr[1];
    }
    String tempStr = intnum;
    String revStr = '';
    var j = 1;
    var i = intnum.length;
    while(i>=2){
      j++;
      i--;
      if (j%3 == 0){
        try {
          revStr = ',' + tempStr.substring(tempStr.length - 3, tempStr.length) +
              revStr;
          tempStr = tempStr.substring(0, tempStr.length - 3);
        } catch (e){}
        j=1;
        i-=2;
      }
    }

    return Container(
      child: Text(tempStr + revStr + (dubnum.length>0? "."+dubnum: '')),
    );
  }
}
