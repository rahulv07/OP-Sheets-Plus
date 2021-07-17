import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sheets_temp/providers/excelnotifer.dart';
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
  bool _firstBuild = true;

  String cellData = '';
  bool isBold = false;
  bool isItalic = false;
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
    ExcelNotifier excelNotifier = Provider.of<ExcelNotifier>(context);

    int colCount = sheetNotifier.getColCount;
    int rowCount = sheetNotifier.getRowCount;

    int currCol = sheetNotifier.currCol;
    int currRow = sheetNotifier.currRow;
    int prevRow = sheetNotifier.prevRow;
    int prevCol = sheetNotifier.prevCol;

    excelNotifier.sheet = 'Sheet 1';

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${excelNotifier.getExcelName}'),
        actions: [
          TextButton(
            onPressed: () async {
              var excel = excelNotifier.getExcel;
              var value = excel.save();
              Directory? storageDir = await getExternalStorageDirectory();
              File file = File(
                  storageDir!.path + '/${excelNotifier.getExcelName}.xlsx');
              file
                ..createSync(recursive: true)
                ..writeAsBytesSync(value!);

              if (await file.exists()) {
                print(file.path);
              }
            },
            child: Icon(Icons.save, size: 25, color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              sheetNotifier.setBoldCell(col: currCol, row: currRow);
            },
            child: Text(
              'B',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: (_firstBuild)
                    ? Colors.white
                    : sheetNotifier.getBoldData(row: currRow, col: currCol)
                        ? Colors.red
                        : Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              sheetNotifier.setItalicCell(col: currCol, row: currRow);
            },
            child: Text(
              'I',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: (_firstBuild)
                    ? Colors.white
                    : sheetNotifier.getItalicData(row: currRow, col: currCol)
                        ? Colors.red
                        : Colors.white,
                fontSize: 25,
              ),
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
            sheetNotifier.currCol = i;
            sheetNotifier.currRow = j;
            if (prevCol > -1 && prevRow > -1) {
              sheetNotifier.selectCell(
                currentCol: i,
                currentRow: j,
                prevCol: prevCol,
                prevRow: prevRow,
                newdata: cellData,
              );
              cellData = sheetNotifier.cellData(col: i, row: j);
              isBold = sheetNotifier.getBoldData(col: i, row: j);
              isItalic = sheetNotifier.getItalicData(col: i, row: j);
            }
            //If selecting a cell for the first time in a sheet
            else {
              sheetNotifier.selectCell(currentCol: i, currentRow: j);
            }
            sheetNotifier.prevCol = i;
            sheetNotifier.prevRow = j;
            print('$j $i');
            displayPersistentBottomSheet();
            excelNotifier.setCellValue(
                col: i + 1,
                row: j + 1,
                value: sheetNotifier.cellData(col: i, row: j));
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
              isItalic: false),
        ),
      ),
    );
  }
}
