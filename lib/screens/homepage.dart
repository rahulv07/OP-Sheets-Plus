import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sheets_temp/widgets/newSheet.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    createFolder();
    super.initState();
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted)
      return true;
    else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) return true;
    }
    return false;
  }

  List contents = [];
  void createFolder() async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
        }

        if (!await directory!.exists()) await directory.create(recursive: true);
        if (await directory.exists()) {
          print(directory);

          var allFiles = await directory.list().toList();

          setState(() {
            contents = allFiles;
          });

          if (contents.isNotEmpty) {
            for (var content in contents) {
              print(content.path);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheets+'),
      ),
      body: (contents.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: contents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 3
                        : 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: (2 / 1),
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print('Tapped $index');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    //height: 35,
                    //width: MediaQuery.of(context).size.width*0.4,
                    child: Center(
                      child: Text(contents[index].path.split("/").last),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: NewSheet(),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
