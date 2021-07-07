import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> titleColumn = List.generate(
    26,
    (i) => String.fromCharCode(i + 65),
  );
  List<int> titleRow = List.generate(100, (i) => i + 1);

  List<List<String>> data = List.generate(
    100,
    (i) => List.generate(26, (j) => '${String.fromCharCode(j + 65)}:${i + 1}'),
  );

  double _scrollOffsetX = 0.0;
  double _scrollOffsetY = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: StickyHeadersTable(
          columnsLength: titleColumn.length,
          rowsLength: titleRow.length,
          columnsTitleBuilder: (i) => Header(type: titleColumn, index: i),
          rowsTitleBuilder: (i) => Header(type: titleRow, index: i),
          contentCellBuilder: (i, j) => Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
          ),
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
