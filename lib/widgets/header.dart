import 'package:flutter/material.dart';

import '../constants.dart';

class Header extends StatelessWidget {
  final List type;
  final int index;

  Header({required this.type, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCellHeight,
      width: kCellWidth,
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
