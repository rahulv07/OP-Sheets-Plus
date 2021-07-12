import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheets_temp/providers/sheetnotifier.dart';
import 'package:sheets_temp/widgets/cell.dart';
import 'package:sheets_temp/widgets/header.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import '../constants.dart';

class SheetsPage extends StatefulWidget {
  @override
  _SheetsPageState createState() => _SheetsPageState();
}

class _SheetsPageState extends State<SheetsPage> {
  double _scrollOffsetX = 0.0;
  double _scrollOffsetY = 0.0;
  int prevCol = -1;
  int prevRow = -1;

  String cellData = '';
  late ScrollController _verticalTitleController,
      _verticalBodyController,
      _horizTitleController,
      _horizBodyController;

  @override
  void initState() {
    super.initState();
    _verticalTitleController = ScrollController();
    _verticalBodyController = ScrollController();
    _horizBodyController = ScrollController();
    _horizTitleController = ScrollController();
  }

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
    int colCount = sheetNotifier.getColCount;
    int rowCount = sheetNotifier.getRowCount;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sheet'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'B',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'I',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Icon(Icons.color_lens, color: Colors.white, size: 25)),
        ],
      ),
      body: SafeArea(
        child: StickyHeadersTable(
          scrollControllers: ScrollControllers(
              verticalBodyController: _verticalBodyController,
              verticalTitleController: _verticalTitleController,
              horizontalBodyController: _horizBodyController,
              horizontalTitleController: _horizTitleController),
          columnsLength: sheetNotifier.getColumnHeaders(colCount).length,
          rowsLength: sheetNotifier.getRowHeaders(rowCount).length,
          columnsTitleBuilder: (i) =>
              Header(type: sheetNotifier.getColumnHeaders(colCount), index: i),
          rowsTitleBuilder: (i) =>
              Header(type: sheetNotifier.getRowHeaders(rowCount), index: i),
          contentCellBuilder: (i, j) => sheetNotifier.getContentCell(
              colcount: colCount, rowcount: rowCount)[j][i],
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
              cellData = sheetNotifier.cellData(col: i, row: j);
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
