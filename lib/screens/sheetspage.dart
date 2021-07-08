import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: StickyHeadersTable(
          columnsLength: kTitleColumn.length,
          rowsLength: kTitleRow.length,
          columnsTitleBuilder: (i) => Header(type: kTitleColumn, index: i),
          rowsTitleBuilder: (i) => Header(type: kTitleRow, index: i),
          contentCellBuilder: (i, j) => Cell(),
          initialScrollOffsetX: _scrollOffsetX,
          initialScrollOffsetY: _scrollOffsetY,
          onEndScrolling: (scrollOffsetX, scrollOffsetY) {
            _scrollOffsetX = scrollOffsetX;
            _scrollOffsetY = scrollOffsetY;
          },
          cellDimensions: CellDimensions.uniform(width: 100, height: 40),
          cellAlignments: CellAlignments.base,
        ),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  const Cell({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCellHeight,
      width: kCellWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final List type;
  final int index;

  Header({required this.type, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        '${type[this.index]}',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }
}
