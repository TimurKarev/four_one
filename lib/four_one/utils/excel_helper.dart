import 'dart:typed_data';

import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/utils/formatters.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelHelper {
  final _month = [
    'Январь',
    'Февраль',
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь"
  ];
  final backColors = {
    'header': '#ffff00',
    'debt': '#ffc000',
  };

  final List<double> columnWidth = [
    20,
    30,
    15,
    15,
    15,
    15,
    25,
    15,
    15,
    15,
    15,
    15,
    15,
    15
  ];

  final Workbook _workbook = Workbook();
  late final Worksheet _sheet;
  late Style _globalStyle;

  ExcelHelper() {
    _sheet = _workbook.worksheets[0];

    _globalStyle = _workbook.styles.add('style');
    _globalStyle.vAlign = VAlignType.center;
    _globalStyle.hAlign = HAlignType.center;
    _globalStyle.fontSize = 10.0;
    //_globalStyle.borders.all.lineStyle = LineStyle.thick;

    int i = 1;
    columnWidth.forEach((element) {
      _sheet.getRangeByIndex(1, i).columnWidth = element;
      i++;
    });

    _sheet.getRangeByIndex(1, 1).rowHeight = 20.0;
    _sheet.getRangeByIndex(2, 1).rowHeight = 30.0;
  }

  String getMonthName(int monthIndex) {
    if (monthIndex < 1 || monthIndex > 12) {
      return monthIndex.toString();
    }
    return _month[monthIndex.toInt() - 1];
  }

  Uint8List get file {
    final Uint8List bytes = _workbook.saveAsStream() as Uint8List;
    _workbook.dispose();
    return bytes;
  }

  Range _getRangeFromList(List<int>? rangeList) {
    if (rangeList == null) {
      return _sheet.getRangeByIndex(1, 1);
    }

    final length = rangeList.length;

    if (length == 0) {
      return _sheet.getRangeByIndex(1, 1);
    }
    if (length == 1) {
      return _sheet.getRangeByIndex(rangeList[0], 1);
    }
    if (length == 2) {
      return _sheet.getRangeByIndex(rangeList[0], rangeList[1]);
    }
    if (length == 3) {
      return _sheet.getRangeByIndex(rangeList[0], rangeList[1], rangeList[2]);
    }
    if (length >= 4) {
      return _sheet.getRangeByIndex(
          rangeList[0], rangeList[1], rangeList[2], rangeList[3]);
    }
    return _sheet.getRangeByIndex(1, 1);
  }

  Range _getRangeFromArgs(List<int>? rangeList, Range? rangeObj) {
    assert(rangeList != null || rangeObj != null, 'No actual range is passed');

    if (rangeObj != null) {
      return rangeObj;
    } else {
      return _getRangeFromList(rangeList!);
    }
  }

  void addText({
    List<int>? rangeList,
    Range? rangeObj,
    text: '',
    bool merge: true,
    VAlignType? vAlign,
    HAlignType? hAlign,
    bool? bold,
    double? fontSize,
    String? backColorHex,
    LineStyle? borderStyle,
  }) {
    Range range = _getRangeFromArgs(rangeList, rangeObj);

    if (merge) {
      range.merge();
    }

    range.setText(text);
    range.cellStyle = _globalStyle;

    setStyle(
      rangeObj: range,
      vAlign: vAlign,
      hAlign: hAlign,
      bold: bold,
      fontSize: fontSize,
      backColorHex: backColorHex,
      borderStyle: borderStyle,
    );
  }

  void setStyle({
    List<int>? rangeList,
    Range? rangeObj,
    VAlignType? vAlign,
    HAlignType? hAlign,
    bool? bold,
    double? fontSize,
    String? backColorHex,
    LineStyle? borderStyle,
  }) {
    Range range = _getRangeFromArgs(rangeList, rangeObj);

    if (bold != null) {
      range.cellStyle.bold = bold;
    }
    if (hAlign != null) {
      range.cellStyle.hAlign = hAlign;
    }
    if (vAlign != null) {
      range.cellStyle.vAlign = vAlign;
    }
    if (fontSize != null) {
      range.cellStyle.fontSize = fontSize;
    }
    if (backColorHex != null) {
      range.cellStyle.backColor = backColorHex;
    }
    if (borderStyle != null) {
      setBorder(rangeObj: range, borderStyle: borderStyle);
    }
  }

  void _setSingleCellBorder({
    List<int>? rangeList,
    Range? rangeObj,
    LineStyle? borderStyle,
  }) {
    final Range range = _getRangeFromArgs(rangeList, rangeObj);
    range.cellStyle.borders.all.lineStyle = borderStyle ?? LineStyle.thin;
  }

  void setBorder({
    List<int>? rangeList,
    Range? rangeObj,
    LineStyle? borderStyle,
  }) {
    final Range range = _getRangeFromArgs(rangeList, rangeObj);

    if (range.row == range.lastRow && range.column == range.lastColumn) {
      _setSingleCellBorder(rangeObj: range, borderStyle: borderStyle);
    } else if (range.row == range.lastRow && range.column != range.lastColumn) {
      _sheet
          .getRangeByIndex(range.row, range.column)
          .cellStyle
          .borders
          .left
          .lineStyle = borderStyle ?? LineStyle.thin;
      _sheet
          .getRangeByIndex(range.lastRow, range.lastColumn)
          .cellStyle
          .borders
          .right
          .lineStyle = borderStyle ?? LineStyle.thin;
      for (int col = range.column; col <= range.lastColumn; col++) {
        _sheet.getRangeByIndex(range.row, col).cellStyle.borders.top.lineStyle =
            borderStyle ?? LineStyle.thin;
        _sheet
            .getRangeByIndex(range.row, col)
            .cellStyle
            .borders
            .bottom
            .lineStyle = borderStyle ?? LineStyle.thin;
      }
    } else if (range.row != range.lastRow && range.column == range.lastColumn) {
      _sheet
          .getRangeByIndex(range.row, range.column)
          .cellStyle
          .borders
          .top
          .lineStyle = borderStyle ?? LineStyle.thin;
      _sheet
          .getRangeByIndex(range.lastRow, range.lastColumn)
          .cellStyle
          .borders
          .bottom
          .lineStyle = borderStyle ?? LineStyle.thin;
      for (int row = range.row; row <= range.lastRow; row++) {
        _sheet
            .getRangeByIndex(row, range.column)
            .cellStyle
            .borders
            .left
            .lineStyle = borderStyle ?? LineStyle.thin;
        _sheet
            .getRangeByIndex(row, range.column)
            .cellStyle
            .borders
            .right
            .lineStyle = borderStyle ?? LineStyle.thin;
      }
    } else if (range.row != range.lastRow && range.column != range.lastColumn) {
      for (int row = range.row; row <= range.lastRow; row++) {
        _sheet
            .getRangeByIndex(row, range.column)
            .cellStyle
            .borders
            .left
            .lineStyle = borderStyle ?? LineStyle.thin;
        _sheet
            .getRangeByIndex(row, range.lastColumn)
            .cellStyle
            .borders
            .right
            .lineStyle = borderStyle ?? LineStyle.thin;
      }
      for (int col = range.column; col <= range.lastColumn; col++) {
        _sheet.getRangeByIndex(range.row, col).cellStyle.borders.top.lineStyle =
            borderStyle ?? LineStyle.thin;
        _sheet
            .getRangeByIndex(range.lastRow, col)
            .cellStyle
            .borders
            .bottom
            .lineStyle = borderStyle ?? LineStyle.thin;
      }
    }
  }

  int createSpecialTables({
    required String client,
    required int currentRow,
    required TableModel model,
  }) {
    currentRow += 2;
    addText(
      rangeList: [currentRow, 4],
      text: 'Цена КП',
      bold: true,
      borderStyle: LineStyle.medium,
      backColorHex: backColors['header'],
    );
    addText(
      rangeList: [currentRow, 5],
      text: 'Оплачено',
      bold: true,
      borderStyle: LineStyle.medium,
      backColorHex: backColors['header'],
    );
    currentRow += 1;
    final startRow = currentRow;
    final rowList = model.rowList;
    rowList.forEach((row) {
      if (row.client == client) {
        addText(
          rangeList: [currentRow, 2],
          text: row.object,
          hAlign: HAlignType.left,
        );
        addText(
          rangeList: [currentRow, 3],
          text: row.order,
        );
        addText(
          rangeList: [currentRow, 4],
          text: getFormatNum(row.sum.toString()),
        );
        addText(
          rangeList: [currentRow, 5],
          text: getFormatNum(row.incomeSum.toString()),
        );
        addText(
          rangeList: [currentRow, 6],
          text: 'Готовность ${getFormatNum(formatDate(row.finishDate))}',
          hAlign: HAlignType.left,
        );
        setBorder(rangeList: [currentRow, 1, currentRow, 6], borderStyle: LineStyle.thin,);
        currentRow += 1;
      }
    });

    addText(
      rangeList: [startRow, 1, currentRow - 1, 1],
      text: client,
      bold: true,
      hAlign: HAlignType.left,
      borderStyle: LineStyle.medium,
    );

    if (startRow != currentRow-1) {
      for (int c = 3; c < 6; c++) {
        setBorder(rangeList: [startRow, c, currentRow - 1, c],
            borderStyle: LineStyle.thin);
      }
    }

    setBorder(
      rangeList: [startRow, 1, currentRow - 1, 6],
      borderStyle: LineStyle.thick,
    );

    return currentRow;
  }
}
