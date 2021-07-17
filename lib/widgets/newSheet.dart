import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheets_temp/providers/excelnotifer.dart';
import 'package:sheets_temp/providers/sheetnotifier.dart';
import 'package:sheets_temp/screens/sheetspage.dart';

enum Header { Row, Column }

class NewSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExcelNotifier excelNotifier = Provider.of<ExcelNotifier>(context);
    return Container(
        child: Column(
      children: [
        Counter(
          header: Header.Row,
        ),
        Counter(
          header: Header.Column,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Spreadsheet name',
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            onChanged: (name) {
              excelNotifier.excelName = name;
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SheetsPage(),
              ),
            );
          },
          child: Text('Create Spreadsheet'),
        )
      ],
    ));
  }
}

class Counter extends StatelessWidget {
  final Header header;
  Counter({required this.header});
  @override
  Widget build(BuildContext context) {
    SheetNotifier sheetNotifier = Provider.of<SheetNotifier>(context);
    int count = (header == Header.Row)
        ? sheetNotifier.getRowCount
        : sheetNotifier.getColCount;
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (header == Header.Row) ? 'Rows:' : 'Columns:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              count--;
              if (header == Header.Row)
                sheetNotifier.setRowCount(count);
              else
                sheetNotifier.setColCount(count);
            },
            child: Icon(Icons.remove),
          ),
          Text('$count'),
          TextButton(
            onPressed: () {
              count++;
              if (header == Header.Row)
                sheetNotifier.setRowCount(count);
              else
                sheetNotifier.setColCount(count);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
