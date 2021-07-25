import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sheets_temp/providers/excelnotifer.dart';
import 'package:sheets_temp/providers/sheetnotifier.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key? key,
    required this.sheetNotifier,
    required this.currCol,
    required this.currRow,
    required this.excelNotifier,
  }) : super(key: key);

  final SheetNotifier sheetNotifier;
  final int currCol;
  final int currRow;
  final ExcelNotifier excelNotifier;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Color pickerColor = sheetNotifier.getColor(col: currCol, row: currRow);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pick your Color'),
            content: Builder(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorPicker(
                      enableAlpha: false,
                      showLabel: false,
                      pickerColor: pickerColor,
                      onColorChanged: (color) {
                        excelNotifier.setCellFontColor(
                          color: color,
                          col: currCol,
                          row: currRow,
                        );
                        sheetNotifier.setFontColor(
                            col: currCol, row: currRow, color: color);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Select'),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(Icons.color_lens, color: Colors.white, size: 25),
    );
  }
}

class ItalicButton extends StatelessWidget {
  const ItalicButton({
    Key? key,
    required this.sheetNotifier,
    required this.currCol,
    required this.currRow,
    required this.excelNotifier,
    required bool firstBuild,
  })  : _firstBuild = firstBuild,
        super(key: key);

  final SheetNotifier sheetNotifier;
  final int currCol;
  final int currRow;
  final ExcelNotifier excelNotifier;
  final bool _firstBuild;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        sheetNotifier.setItalicCell(col: currCol, row: currRow);
        excelNotifier.setCellItalic(
          col: currCol,
          row: currRow,
          isItalic: sheetNotifier.getItalicData(col: currCol, row: currRow),
        );
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
    );
  }
}

class BoldButton extends StatelessWidget {
  const BoldButton({
    Key? key,
    required this.sheetNotifier,
    required this.currCol,
    required this.currRow,
    required this.excelNotifier,
    required bool firstBuild,
  })  : _firstBuild = firstBuild,
        super(key: key);

  final SheetNotifier sheetNotifier;
  final int currCol;
  final int currRow;
  final ExcelNotifier excelNotifier;
  final bool _firstBuild;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        sheetNotifier.setBoldCell(col: currCol, row: currRow);
        excelNotifier.setCellBold(
          col: currCol,
          row: currRow,
          isBold: sheetNotifier.getBoldData(row: currRow, col: currCol),
        );
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
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.excelNotifier,
  }) : super(key: key);

  final ExcelNotifier excelNotifier;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var excel = excelNotifier.getExcel;
        var value = excel.save();
        Directory? storageDir = await getExternalStorageDirectory();
        File file =
            File(storageDir!.path + '/${excelNotifier.getExcelName}.xlsx');
        file
          ..createSync(recursive: true)
          ..writeAsBytesSync(value!);

        if (await file.exists()) {
          print(file.path);
        }
      },
      child: Icon(Icons.save, size: 25, color: Colors.white),
    );
  }
}
