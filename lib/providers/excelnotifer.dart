import 'package:flutter/material.dart';
import 'package:excel/excel.dart';

class ExcelNotifier extends ChangeNotifier {
  var _excel = Excel.createExcel();
  Excel get getExcel => _excel;
  late Sheet _sheet;
  String _excelName = 'Untitled';

  set excelName(name) {
    _excelName = name;
    notifyListeners();
  }

  String get getExcelName => _excelName;

  createSheet() {
    _sheet = _excel['Sheet1'];
  }

  Sheet get getSheet => _sheet;

  setCellValue({col, row, value}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    cell.value = value;
    notifyListeners();
  }

  setCellItalic({col, row, isItalic, isBold}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    cell.cellStyle = CellStyle(italic: isItalic, bold: isBold);
    notifyListeners();
  }

  setCellBold({col, row, isBold, isItalic}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    cell.cellStyle = CellStyle(bold: isBold, italic: isItalic);
    notifyListeners();
  }

  setCellFontColor({col, row, isItalic, isBold, required Color color}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    var italic =
        (cell.cellStyle?.isItalic == null) ? false : cell.cellStyle!.isItalic;
    bool bold =
        (cell.cellStyle?.isBold == null) ? false : cell.cellStyle!.isBold;
    var r = color.red;
    var g = color.green;
    var b = color.blue;
    var hexstring =
        'FF' + r.toRadixString(16) + g.toRadixString(16) + b.toRadixString(16);
    cell.cellStyle =
        CellStyle(fontColorHex: hexstring, bold: bold, italic: italic);
    notifyListeners();
  }
}
