import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sheets_temp/widgets/cell.dart';

class SheetNotifier extends ChangeNotifier {
  int _rowCount = 20;
  int _colCount = 5;

  setRowCount(count) {
    if (count < 20) {
      _rowCount = 20;
      notifyListeners();
      return;
    }
    _rowCount = count;
    notifyListeners();
  }

  setColCount(count) {
    if (count < 5) {
      _colCount = 5;
      notifyListeners();
      return;
    }
    _colCount = count;
    notifyListeners();
  }

  int get getRowCount => _rowCount;
  int get getColCount => _colCount;

  UnmodifiableListView getColumnHeaders(count) {
    var columnHeaders =
        List.generate(count, (i) => String.fromCharCode(i + 65));
    return UnmodifiableListView(columnHeaders);
  }

  UnmodifiableListView getRowHeaders(count) {
    var rowHeaders = List.generate(count, (i) => i + 1);
    return UnmodifiableListView(rowHeaders);
  }

  late List<List<Cell>> _cellMatrix;
  bool _isFirstTime = true;

  List<List<Cell>> getContentCell({colcount, rowcount}) {
    if (_isFirstTime) {
      _cellMatrix = List.generate(
        rowcount,
        (i) => List.generate(
          colcount,
          (j) => Cell(col: j + 1, row: i + 1, isSelected: false, data: ''),
        ),
      );
      _isFirstTime = false;
    }
    return _cellMatrix;
  }

  String cellData({row, col}) => _cellMatrix[row][col].data;

  selectCell({currentCol, currentRow, prevCol, prevRow, newdata}) {
    if (prevCol != null && prevRow != null && newdata != null) {
      _cellMatrix[prevRow][prevCol] =
          Cell(col: prevCol, row: prevRow, isSelected: false, data: newdata);
    }
    _cellMatrix[currentRow][currentCol] = Cell(
        col: currentCol,
        row: currentRow,
        isSelected: true,
        data: _cellMatrix[currentRow][currentCol].data);
    notifyListeners();
  }
}
