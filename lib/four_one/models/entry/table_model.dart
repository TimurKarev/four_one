import 'dart:typed_data';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/utils/excel_helper.dart';
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
    final columnsNames = [
      'Заказчик',
      "Объект",
      "з-з",
      "Сумма, руб",
      "Оплачено на",
      "Готовность",
      "Наименование платежа",
      "Дата оплаты",
      "Размер платежа",
      "Долг"
    ];
    final backColors = {
      'header': '#ffff00',
      'debt': '#ffc000',
    };

    final todayFull = DateTime.now();
    final currentMonth = todayFull.month;

    ExcelHelper excel = ExcelHelper();

    excel.addText(
      rangeList: [1, 1, 1, 14],
      text:
          'ОТЧЕТ №4.1  Дебиторская задолженность / График оплат по основной деятельности',
      bold: true,
      hAlign: HAlignType.center,
      fontSize: 12.0,
    );

    // Заголовки таблицы
    int currentColumn = 1;
    columnsNames.forEach((element) {
      excel.addText(
        rangeList: [2, currentColumn],
        text: element,
        bold: true,
        backColorHex: backColors['header'],
        borderStyle: LineStyle.medium,
      );
      currentColumn++;
    });

    for (int m = 0; m < 4; m++) {
      int mIndex = currentMonth + m;
      if (mIndex > 12) {
        mIndex -= 12;
      }
      excel.addText(
        rangeList: [2, currentColumn + m],
        text: excel.getMonthName(mIndex),
        bold: true,
        backColorHex: backColors['header'],
        borderStyle: LineStyle.medium,
      );
    }

    excel.setStyle(
        rangeList: [2, currentColumn - 1], backColorHex: backColors['debt']);

    //Текущая дата
    excel.addText(
      rangeList: [3, 5],
      text: formatDate(todayFull),
      backColorHex: backColors['header'],
      borderStyle: LineStyle.medium,
      bold: true,
    );

    //Общий долг
    excel.addText(
      rangeList: [3, 10],
      text: getFormatNum(getClientDebt('ЭСИ', exclude: true).toString()),
      backColorHex: backColors['debt'],
      borderStyle: LineStyle.medium,
      bold: true,
    );

    Map<int, num> monthMap = {};
    int currentRow = 4;
    rowList.forEach((element) {
      if (element.client != 'ЭСИ' && element.client != 'ЛЭСР') {
        int rows = element.futureIncomes.payments.length;
        if (rows < 1) {
          rows = 1;
        }
        excel.addText(
          rangeList: [currentRow, 1, currentRow + rows - 1, 1],
          text: element.client,
          merge: true,
          hAlign: HAlignType.left,
          bold: true,
        );
        excel.addText(
          rangeList: [currentRow, 2, currentRow + rows - 1, 2],
          text: element.object,
          merge: true,
          hAlign: HAlignType.left,
          //borderStyle: LineStyle.thin,
        );
        excel.addText(
          rangeList: [currentRow, 3, currentRow + rows - 1, 3],
          text: element.order,
          merge: true,
          //borderStyle: LineStyle.thin,
        );
        excel.addText(
          rangeList: [currentRow, 4, currentRow + rows - 1, 4],
          text: getFormatNum(element.sum.toString()),
          merge: true,
          //borderStyle: LineStyle.thin,
        );

        var incomeSum = getFormatNum(element.incomeSum.toString());
        if (incomeSum == '0') {
          incomeSum = '';
        }
        excel.addText(
          rangeList: [currentRow, 5, currentRow + rows - 1, 5],
          text: incomeSum,
          merge: true,
          //borderStyle: LineStyle.thin,
        );

        excel.addText(
          rangeList: [currentRow, 6, currentRow + rows - 1, 6],
          text: formatDate(element.finishDate),
          merge: true,
          //borderStyle: LineStyle.thin,
        );
        final payments = element.futureIncomes.payments;

        for (int j = 0; j < payments.length; j++) {
          excel.addText(
            rangeList: [currentRow + j, 7],
            text: payments[j].string,
            hAlign: HAlignType.left,
          );
        }
        for (int j = 0; j < payments.length; j++) {
          excel.addText(
              rangeList: [currentRow + j, 8],
              text: formatDate(payments[j].date));
        }

        for (int j = 0; j < payments.length; j++) {
          excel.addText(
              rangeList: [currentRow + j, 9],
              text: getFormatNum(payments[j].cash.toString()));

          int mIndex = payments[j].date.month - currentMonth;
          if (mIndex < 0) {
            mIndex += 12;
          }
          excel.addText(
              rangeList: [currentRow + j, currentColumn + mIndex],
              text: getFormatNum(payments[j].cash.toString()));
          if (monthMap.containsKey(currentColumn + mIndex)) {
            monthMap[currentColumn + mIndex] =
                monthMap[currentColumn + mIndex]! + payments[j].cash;
          } else {
            monthMap[currentColumn + mIndex] = payments[j].cash;
          }
        }

        var debt = getFormatNum(element.debt.toString());
        if (debt == '0') {
          debt = '';
        }
        excel.addText(
          rangeList: [currentRow, 10, currentRow + rows - 1, 10],
          text: debt,
          merge: true,
          bold: true,
          backColorHex: backColors['debt'],
        );

        excel.setBorder(rangeList: [currentRow, 1, currentRow + rows - 1, 14]);
        currentRow += rows;
      }
    });

    monthMap.keys.forEach((key) {
      excel.addText(
        rangeList: [3, key],
        text: getFormatNum(monthMap[key].toString()),
        bold: true,
      );
    });

    for (int c = 1; c <= 14; c++) {
      excel.setBorder(rangeList: [4, c, currentRow - 1, c]);
    }

    [1, 8, 9, 10, 11, 12, 13, 14].forEach((c) {
      excel.setBorder(
        rangeList: [4, c, currentRow - 1, c],
        borderStyle: LineStyle.medium,
      );
    });

    excel.setBorder(
      rangeList: [2, 1, currentRow - 1, 14],
      borderStyle: LineStyle.medium,
    );

    excel.setBorder(
      rangeList: [4, 1, currentRow - 1, 14],
      borderStyle: LineStyle.medium,
    );

    currentRow = excel.createSpecialTables(
        client: 'ЭСИ', currentRow: currentRow, model: this);
    currentRow = excel.createSpecialTables(
        client: 'ЛЭСР', currentRow: currentRow, model: this);

    return excel.file;
  }
}
