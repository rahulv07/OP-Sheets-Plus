import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheets_temp/providers/sheetnotifier.dart';
import 'package:sheets_temp/widgets/cell.dart';
import 'package:sheets_temp/widgets/header.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import '../constants.dart';

class SheetsPage extends StatefulWidget {
  const SheetsPage({Key? key}) : super(key: key);

  @override
  _SheetsPageState createState() => _SheetsPageState();
}

class _SheetsPageState extends State<SheetsPage> {
  double _scrollOffsetX = 0.0;
  double _scrollOffsetY = 0.0;
  int prevCol = -1;
  int prevRow = -1;

  @override
  Widget build(BuildContext context) {
    SheetNotifier sheetNotifier = Provider.of<SheetNotifier>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: StickyHeadersTable(
          columnsLength: sheetNotifier.columnHeaders.length,
          rowsLength: sheetNotifier.rowHeaders.length,
          columnsTitleBuilder: (i) =>
              Header(type: sheetNotifier.columnHeaders, index: i),
          rowsTitleBuilder: (i) =>
              Header(type: sheetNotifier.rowHeaders, index: i),
          contentCellBuilder: (i, j) => sheetNotifier.contentCell[j][i],
          initialScrollOffsetX: _scrollOffsetX,
          initialScrollOffsetY: _scrollOffsetY,
          onEndScrolling: (scrollOffsetX, scrollOffsetY) {
            _scrollOffsetX = scrollOffsetX;
            _scrollOffsetY = scrollOffsetY;
          },
          onContentCellPressed: (i, j) {
            if (prevCol > -1 && prevRow > -1) {
              sheetNotifier.selectCell(
                  currentCol: i,
                  currentRow: j,
                  prevCol: prevCol,
                  prevRow: prevRow);
            } else {
              sheetNotifier.selectCell(currentCol: i, currentRow: j);
            }
            prevCol = i;
            prevRow = j;
            print('$j $i');
          },
          cellDimensions:
              CellDimensions.uniform(width: kCellWidth, height: kCellHeight),
          legendCell: Cell(col: 0, row: 0, isSelected: false),
        ),
      ),
    );
  }
}
