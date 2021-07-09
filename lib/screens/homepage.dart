import 'package:flutter/material.dart';
import 'package:sheets_temp/screens/sheetspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void displayPersistentBottomSheet() {
    _scaffoldKey.currentState?.showBottomSheet<void>((BuildContext context) {
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
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: _scaffoldKey,
      body: Center(
        child: FloatingActionButton(
            child: Icon(Icons.add), onPressed: displayPersistentBottomSheet),
      ),
    );
  }
}


//  Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SheetsPage(),
//               ),
//             );