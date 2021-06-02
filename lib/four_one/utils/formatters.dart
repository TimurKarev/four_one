String formatDate(DateTime dt) {
  return '${dt.day}.${dt.month}.${dt.year}';
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