class FourOneModel {
  List<String>? columns;
  List<List<dynamic>>? rows;

  FourOneModel({this.columns, this.rows});

  factory FourOneModel.fromJSON(Map<String,dynamic> jsonData) {
    final List<dynamic> fields = jsonData['schema']['fields'];
    List<String> resColumns = [];
    for (var col in fields) {
      resColumns.add(col['name']!);
    }
    return FourOneModel(columns: resColumns);
  }

  factory FourOneModel.empty() {
    return FourOneModel(columns: [
      'Заказчик',
      "Объект",
      "Сумма",
      "Оплачено",
      "Долг",
      "Остаток"
    ]);
  }
}