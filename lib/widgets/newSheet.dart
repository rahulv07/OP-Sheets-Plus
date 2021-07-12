import 'package:flutter/material.dart';

class NewSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Counter(
          type: 'Rows ',
          startCount: 10,
        ),
        Counter(type: 'Columns', startCount: 10),
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
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Create Spreadsheet'),
        )
      ],
    ));
  }
}

class Counter extends StatefulWidget {
  final String type;
  final int startCount;
  Counter({required this.type, required this.startCount});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.type + ':',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Icon(Icons.remove),
          ),
          Text('${widget.startCount}'),
          TextButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
