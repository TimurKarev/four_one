import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/models/entry/payment_edit_model.dart';
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

    ExcelHelper excel = ExcelHelper();

    excel.addText(
      rangeList: [1, 1, 1, 10],
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
    excel.setStyle(
        rangeList: [2, currentColumn - 1], backColorHex: backColors['debt']);

    //Текущая дата
    excel.addText(
      rangeList: [3, 5],
      text: formatDate(DateTime.now()),
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

    int currentRow = 4;
    rowList.forEach((element) {
      if (element.client != 'ЭСИ') {
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
        excel.addText(
          rangeList: [currentRow, 5, currentRow + rows - 1, 5],
          text: getFormatNum(element.incomeSum.toString()),
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
        }

        excel.addText(
          rangeList: [currentRow, 10, currentRow + rows - 1, 10],
          text: getFormatNum(element.debt.toString()),
          merge: true,
          bold: true,
        );

        excel.setBorder(rangeList: [currentRow, 1, currentRow + rows - 1, 10]);
        currentRow += rows;
      }
    });

    excel.setBorder(
      rangeList: [4, 1, currentRow - 1, columnsNames.length],
      borderStyle: LineStyle.medium,
    );

    excel.setBorder(
      rangeList: [2, 1, currentRow - 1, 1],
      borderStyle: LineStyle.medium,
    );

    excel.setBorder(
      rangeList: [2, 2, currentRow - 1, 2],
      borderStyle: LineStyle.thin,
    );

    excel.setBorder(
      rangeList: [2, 3, currentRow - 1, 4],
      borderStyle: LineStyle.thin,
    );

    excel.setBorder(
      rangeList: [2, 5, currentRow - 1, 5],
      borderStyle: LineStyle.thin,
    );

    excel.setBorder(
      rangeList: [2, 6, currentRow - 1, 6],
      borderStyle: LineStyle.thin,
    );

    excel.setBorder(
      rangeList: [2, 7, currentRow - 1, 7],
      borderStyle: LineStyle.thin,
    );

    excel.setBorder(
      rangeList: [2, 8, currentRow - 1, 8],
      borderStyle: LineStyle.medium,
    );

    excel.setBorder(
      rangeList: [2, 9, currentRow - 1, 9],
      borderStyle: LineStyle.medium,
    );

    excel.setBorder(
      rangeList: [1, 1, currentRow - 1, columnsNames.length],
      borderStyle: LineStyle.medium,
    );

    return excel.file;
  }
}
