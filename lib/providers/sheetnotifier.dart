import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sheets_temp/widgets/cell.dart';

class SheetNotifier extends ChangeNotifier {
  List<String> _titleColumn = List.generate(
    26,
    (i) => String.fromCharCode(i + 65),
  );

  UnmodifiableListView<String> get columnHeaders =>
      UnmodifiableListView(_titleColumn);

  List<int> _titleRow = List.generate(100, (i) => i + 1);

  UnmodifiableListView<int> get rowHeaders => UnmodifiableListView(_titleRow);

  List<List<Cell>> _cellMatrix = List.generate(
    100,
    (i) => List.generate(
      26,
      (j) => Cell(col: j + 1, row: i + 1, isSelected: false, data: ''),
    ),
  );

  List<List<Cell>> get contentCell => _cellMatrix;

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
