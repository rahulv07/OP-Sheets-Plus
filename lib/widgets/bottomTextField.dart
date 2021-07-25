import 'package:flutter/material.dart';

class BottomTextField {
  static void displayPersistentBottomSheet(
      {scaffoldKey, sheetNotifier, excelNotifier}) {
    scaffoldKey.currentState?.showBottomSheet<void>((BuildContext context) {
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
                  sheetNotifier.setCellData = enteredText;
                  excelNotifier.setCellValue(
                    row: sheetNotifier.currRow,
                    col: sheetNotifier.currCol,
                    value: enteredText,
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
