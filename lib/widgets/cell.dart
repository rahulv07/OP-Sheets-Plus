import 'package:flutter/material.dart';
import '../constants.dart';

class Cell extends StatelessWidget {
  final int col;
  final int row;
  final bool isSelected;
  Cell({required this.col, required this.row, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCellHeight,
      width: kCellWidth,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? kActiveColor : kInactiveColor),
      ),
      child: Text(''),
    );
  }
}
