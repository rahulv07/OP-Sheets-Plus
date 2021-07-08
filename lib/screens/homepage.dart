import 'package:flutter/material.dart';
import 'package:sheets_temp/screens/sheetspage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SheetsPage(),
                ),
              );
            }),
      ),
    ));
  }
}
