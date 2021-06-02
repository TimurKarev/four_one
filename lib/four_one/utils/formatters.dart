String formatDate(DateTime dt) {
  return '${dt.day}.${dt.month}.${dt.year}';
}

String getNumFromFormatString(String str) {
  return str.split(',').join();
}