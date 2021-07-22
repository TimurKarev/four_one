import 'dart:typed_data';

import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class TableModel {
  List<BigTableModel> rowList;

  TableModel({required this.rowList});

  double get debt {
    double retVal = 0.0;
    if (rowList.isEmpty) {
      return retVal;
    }
    rowList.forEach((model) {
      retVal += model.debt;
    });
    return retVal;
  }

  num getClientDebt(String client, {bool exclude = false}) {
    num retVal = 0;

    rowList.forEach((project) {
      if (!exclude) {
        if (project.client == client) {
          retVal += project.debt;
        }
      } else {
        if (project.client != client) {
          retVal += project.debt;
        }
      }
    });
    return retVal;
  }

  double get futureIncome {
    double retVal = 0.0;
    if (rowList.isEmpty) {
      return retVal;
    }
    rowList.forEach((model) {
      retVal += model.futurePayment;
    });
    return retVal;
  }

  num getClientFutureIncome(String client, {bool exclude = false}) {
    num retVal = 0;
    rowList.forEach((project) {
      if (!exclude) {
        if (project.client == client) {
          retVal += project.futurePayment;
        }
      } else {
        if (project.client != client) {
          retVal += project.futurePayment;
        }
      }
    });
    return retVal;
  }

  Future<Uint8List> toExcel() async {
    ExcelHelper excel = ExcelHelper();

    excel.addText(
        range: [1, 1, 1, 13],
        text:
            'ОТЧЕТ №4.1  Дебиторская задолженность / График оплат по основной деятельности');
    final columnsNames = [
      'Заказчик',
      "Объект",
      "з-з",
      "Сумма, руб",
      "Оплачено на",
      "Готовность",
      "Платежи",
      "Дата оплаты",
      "Долг"
    ];

    int i = 1;
    columnsNames.forEach((element) {
    excel.addText(range: [2,i], text: element);
    i++;
    });
    excel.addText(range: [3,5], text: formatDate(DateTime.now()));
    excel.addText(range: [3,9], text: getClientDebt('ЭСИ', exclude: true).toString());

    i = 4;
    rowList.forEach((element) {
      if (element.client != 'ЭСИ') {
        int rows = element.futureIncomes.payments.length;
        if (rows < 1) {
          rows = 1;
        }
        excel.addText(range: [i,1, i+rows-1, 1], text: element.client, merge: true);
        excel.addText(range: [i,2, i+rows-1, 2], text: element.object, merge: true);
        excel.addText(range: [i,3, i+rows-1, 3], text: element.order, merge: true);
        excel.addText(range: [i,4, i+rows-1, 4], text: getFormatNum(element.sum.toString()), merge: true);
        excel.addText(range: [i,5, i+rows-1, 5], text: getFormatNum(element.incomeSum.toString()), merge: true);
        excel.addText(range: [i,6, i+rows-1, 6], text: formatDate(element.finishDate), merge: true);
        final payments = element.futureIncomes.payments;
        for(int j=0; j<payments.length; j++) {
          excel.addText(range: [i+j, 7],
              text: formatDate(payments[j].date));
        }
        for(int j=0; j<payments.length; j++) {
          excel.addText(range: [i+j, 8],
              text: getFormatNum(payments[j].cash.toString()));
        }

        excel.addText(range: [i,9, i+rows-1, 9], text: getFormatNum(element.debt.toString()), merge: true);
        i+= rows;
      }
    });

    return excel.file;
  }
}

class ExcelHelper {
  final List<double> columnWidth = [
    15,15,15,15,15,15,15,15,15
  ];

  final Workbook _workbook = Workbook();
  late final Worksheet _sheet;

  ExcelHelper() {
    _sheet = _workbook.worksheets[0];

    int i = 1;
    columnWidth.forEach((element) {
      _sheet.getRangeByIndex(1,i).columnWidth = element;
      i++;
    });

  }

  Uint8List get file {
    final Uint8List bytes = _workbook.saveAsStream() as Uint8List;
    _workbook.dispose();
    return bytes;
  }

  void addText({required List<int> range, text: '', bool merge: true}) {
    final Range r =
        range.length == 4 ? _sheet.getRangeByIndex(range[0], range[1], range[2], range[3]): _sheet.getRangeByIndex(range[0], range[1]);
    if (merge) {
      r.merge();
    }
    r.setText(text);
  }
}
