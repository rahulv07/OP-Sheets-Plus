import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheets_temp/providers/excelnotifer.dart';
import 'package:sheets_temp/providers/sheetnotifier.dart';
import 'package:sheets_temp/widgets/actionButtons.dart';
import 'package:sheets_temp/widgets/cell.dart';
import 'package:sheets_temp/widgets/header.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import '../constants.dart';
import 'package:sheets_temp/widgets/bottomTextField.dart';

class SheetsPage extends StatefulWidget {
  @override
  _SheetsPageState createState() => _SheetsPageState();
}

class _SheetsPageState extends State<SheetsPage> {
  double _scrollOffsetX = 0.0;
  double _scrollOffsetY = 0.0;
  bool _firstBuild = true;

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

  @override
  Widget build(BuildContext context) {
    SheetNotifier sheetNotifier = Provider.of<SheetNotifier>(context);
    ExcelNotifier excelNotifier = Provider.of<ExcelNotifier>(context);

    int colCount = sheetNotifier.getColCount;
    int rowCount = sheetNotifier.getRowCount;

    int currCol = sheetNotifier.currCol;
    int currRow = sheetNotifier.currRow;
    int prevRow = sheetNotifier.prevRow;
    int prevCol = sheetNotifier.prevCol;

    excelNotifier.createSheet();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${excelNotifier.getExcelName}'),
        actions: [
          SaveButton(excelNotifier: excelNotifier),
          BoldButton(
              sheetNotifier: sheetNotifier,
              currCol: currCol,
              currRow: currRow,
              excelNotifier: excelNotifier,
              firstBuild: _firstBuild),
          ItalicButton(
              sheetNotifier: sheetNotifier,
              currCol: currCol,
              currRow: currRow,
              excelNotifier: excelNotifier,
              firstBuild: _firstBuild),
          ColorButton(
              sheetNotifier: sheetNotifier,
              currCol: currCol,
              currRow: currRow,
              excelNotifier: excelNotifier),
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
            sheetNotifier.currCol = i;
            sheetNotifier.currRow = j;
            if (prevCol > -1 && prevRow > -1) {
              sheetNotifier.selectCell(
                currentCol: i,
                currentRow: j,
                prevCol: prevCol,
                prevRow: prevRow,
              );
            }
            //If selecting a cell for the first time in a sheet
            else {
              sheetNotifier.selectCell(currentCol: i, currentRow: j);
            }
            sheetNotifier.prevCol = i;
            sheetNotifier.prevRow = j;
            print('$j $i');
            BottomTextField.displayPersistentBottomSheet(
                scaffoldKey: _scaffoldKey,
                sheetNotifier: sheetNotifier,
                excelNotifier: excelNotifier);
            excelNotifier.setCellValue(
                col: i, row: j, value: sheetNotifier.cellData(col: i, row: j));
            _firstBuild = false;
          },
          cellDimensions:
              CellDimensions.uniform(width: kCellWidth, height: kCellHeight),
          legendCell: Cell(
            col: 0,
            row: 0,
            isSelected: false,
            data: '',
            isBold: false,
            isItalic: false,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
