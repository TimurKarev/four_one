import 'package:intl/intl.dart';

String formatDate(DateTime dt, {bool year: true}) {
  String retVal = DateFormat("dd.MM.yy").format(dt);

  return year ? retVal : retVal.substring(0,5);
}

String getNumFromFormatString(String str) {
  return str.split(',').join();
}

String getFormatNum(String str){
  List<String> lstr = str.split('.');
  String intnum = lstr[0];
  String dubnum = '';
  if (lstr.length > 1) {
    dubnum =  lstr[1];
  }
  String tempStr = intnum;
  String revStr = '';
  var j = 1;
  var i = intnum.length;
  if (i > 3) {
    while (i >= 2) {
      j++;
      i--;
      if (j % 3 == 0) {
        try {
          revStr = ',' + tempStr.substring(tempStr.length - 3, tempStr.length) +
              revStr;
          tempStr = tempStr.substring(0, tempStr.length - 3);
        } catch (e) {}
        j = 1;
        i -= 2;
      }
    }
  }
  return tempStr + revStr + (dubnum.length>0? "."+dubnum: '');
}

String numToString(int value) {
  const units = <int, String>{
    1000000000: 'B',
    1000000: 'M',
    1000: 'K',
  };
  final retVal =  units.entries
      .map((e) => '${value ~/ e.key}${e.value}')
      .firstWhere((e) => !e.startsWith('0'), orElse: () => '$value');
  return retVal == '0' ? '' : retVal;
}