import 'package:flutter/material.dart';
import 'package:sheets_temp/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:sheets_temp/sheetmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SheetModel>(
      create: (context) => SheetModel(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
