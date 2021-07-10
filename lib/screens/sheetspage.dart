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
  String cellData = '';

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void displayPersistentBottomSheet() {
    _scaffoldKey.currentState?.showBottomSheet<void>((BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.10,
        padding: EdgeInsets.all(10),
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter text',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (enteredText) {
                  cellData = enteredText;
                },
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SheetNotifier sheetNotifier = Provider.of<SheetNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
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
                  prevRow: prevRow,
                  newdata: cellData);
            }
            //If selecting a cell for the first time in a sheet
            else {
              sheetNotifier.selectCell(currentCol: i, currentRow: j);
            }
            prevCol = i;
            prevRow = j;
            print('$j $i');
            displayPersistentBottomSheet();
          },
          cellDimensions:
              CellDimensions.uniform(width: kCellWidth, height: kCellHeight),
          legendCell: Cell(col: 0, row: 0, isSelected: false, data: ''),
        ),
      ),
    );
  }
}
