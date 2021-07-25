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

  setCellItalic({col, row, isItalic}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    var bold =
        (cell.cellStyle?.isBold == null) ? false : cell.cellStyle!.isBold;
    var hexString = (cell.cellStyle?.fontColor == null)
        ? 'FF000000'
        : cell.cellStyle!.fontColor;
    print(hexString);
    cell.cellStyle =
        CellStyle(italic: isItalic, bold: bold, fontColorHex: hexString);
    notifyListeners();
  }

  setCellBold({col, row, isBold}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    var italic =
        (cell.cellStyle?.isItalic == null) ? false : cell.cellStyle!.isItalic;
    var hexString = (cell.cellStyle?.fontColor == null)
        ? 'FF000000'
        : cell.cellStyle!.fontColor;
    print(hexString);
    cell.cellStyle =
        CellStyle(bold: isBold, italic: italic, fontColorHex: hexString);
    notifyListeners();
  }

  setCellFontColor({col, row, required Color color}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    var italic =
        (cell.cellStyle?.isItalic == null) ? false : cell.cellStyle!.isItalic;
    bool bold =
        (cell.cellStyle?.isBold == null) ? false : cell.cellStyle!.isBold;
    var r = color.red;
    var g = color.green;
    var b = color.blue;
    var hexString = 'FF' +
        ((r.toRadixString(16).length == 1)
            ? '0' + r.toRadixString(16)
            : r.toRadixString(16)) +
        ((g.toRadixString(16).length == 1)
            ? '0' + g.toRadixString(16)
            : g.toRadixString(16)) +
        ((b.toRadixString(16).length == 1)
            ? '0' + b.toRadixString(16)
            : b.toRadixString(16));
    print(hexString);
    cell.cellStyle =
        CellStyle(fontColorHex: hexString, bold: bold, italic: italic);
    notifyListeners();
  }
}
