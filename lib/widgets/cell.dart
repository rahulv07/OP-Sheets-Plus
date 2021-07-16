import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';

class Cell extends StatelessWidget {
  final int col;
  final int row;
  final bool isSelected;
  final String data;
  final bool isBold;
  final bool isItalic;
  Cell(
      {required this.col,
      required this.row,
      required this.isSelected,
      required this.data,
      required this.isBold,
      required this.isItalic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCellHeight,
      width: kCellWidth,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? kActiveColor : kInactiveColor),
      ),
      child: Center(
        child: Text(
          data,
          style: TextStyle(
            fontWeight: (isBold) ? FontWeight.bold : FontWeight.normal,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
