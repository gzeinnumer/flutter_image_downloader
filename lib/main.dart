import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Test Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    var url = "https://avatars.githubusercontent.com/u/45892408?v=4"; // <-- 1
    var response = await get(Uri.parse(url)); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    var filePathAndName = '${documentDirectory.path}/images/pic.jpg';
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file2 = File(filePathAndName); // <-- 2
    file2.writeAsBytesSync(response.bodyBytes); // <-- 3
    setState(() {
      imageData = filePathAndName;

      dataLoaded = true;
    });
  }

  String? imageData;
  bool dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title.toString()),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(File(imageData.toString()), width: 600.0, height: 290.0),
              Text(imageData.toString()),
            ],
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator(
        backgroundColor: Colors.cyan,
        strokeWidth: 5,
      );
    }
  }
}
