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

  set sheet(name) {
    _sheet = _excel[name];
    notifyListeners();
  }

  Sheet get getSheet => _sheet;

  setCellValue({col, row, value}) {
    var cell = _sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    cell.value = value;
    notifyListeners();
  }
}
