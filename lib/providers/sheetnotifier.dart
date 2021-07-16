import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sheets_temp/constants.dart';
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
          (j) => Cell(
              col: j + 1,
              row: i + 1,
              isSelected: false,
              data: '',
              isBold: false,
              isItalic: false),
        ),
      );
      _isFirstTime = false;
    }
    return _cellMatrix;
  }

  int _currCol = -1;
  int _currRow = -1;
  int _prevCol = -1;
  int _prevRow = -1;

  set currCol(col) {
    _currCol = col;
    notifyListeners();
  }

  set currRow(row) {
    _currRow = row;
    notifyListeners();
  }

  set prevRow(row) {
    _prevRow = row;
    notifyListeners();
  }

  set prevCol(col) {
    _prevCol = col;
    notifyListeners();
  }

  int get prevRow => _prevRow;
  int get prevCol => _prevCol;
  int get currRow => _currRow;
  int get currCol => _currCol;

  selectCell({currentCol, currentRow, prevCol, prevRow, newdata}) {
    if (prevCol != null && prevRow != null && newdata != null) {
      _cellMatrix[prevRow][prevCol] = Cell(
          col: prevCol,
          row: prevRow,
          isSelected: false,
          data: newdata,
          isBold: _cellMatrix[prevRow][prevCol].isBold,
          isItalic: _cellMatrix[prevRow][prevCol].isItalic);
    }
    _cellMatrix[currentRow][currentCol] = Cell(
      col: currentCol,
      row: currentRow,
      isSelected: true,
      data: _cellMatrix[currentRow][currentCol].data,
      isBold: _cellMatrix[currentRow][currentCol].isBold,
      isItalic: _cellMatrix[currentRow][currentCol].isItalic,
    );
    notifyListeners();
  }

  bool getBoldData({col, row}) => _cellMatrix[row][col].isBold;
  bool getItalicData({col, row}) => _cellMatrix[row][col].isItalic;

  setBoldCell({col, row}) {
    Cell currentCell = _cellMatrix[row][col];
    _cellMatrix[row][col] = Cell(
        col: col,
        row: row,
        isSelected: true,
        data: currentCell.data,
        isBold: !currentCell.isBold,
        isItalic: currentCell.isItalic);

    notifyListeners();
  }

  setItalicCell({row, col}) {
    Cell currentCell = _cellMatrix[row][col];
    _cellMatrix[row][col] = Cell(
      col: col,
      row: row,
      isSelected: true,
      data: currentCell.data,
      isBold: currentCell.isBold,
      isItalic: !currentCell.isItalic,
    );

    notifyListeners();
  }

  String cellData({row, col}) => _cellMatrix[row][col].data;

  setCellData({data, row, col}) {
    Cell currentCell = _cellMatrix[row][col];
    _cellMatrix[row][col] = Cell(
        col: col,
        row: row,
        isSelected: currentCell.isSelected,
        data: data,
        isBold: currentCell.isBold,
        isItalic: currentCell.isItalic);
    notifyListeners();
  }
}
