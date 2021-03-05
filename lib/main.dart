import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnyScan',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'AnyScan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.asset("assets/f_bg.jpg"),
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
                alignment: Alignment.center,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScanPage()),
                      );
                    },
                    color: Colors.green,
                    elevation: 30.0,
                    child: Text(
                      'Start Scanning',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0),
                    ))),
          ],
        ),
      ),
    );
  }
}

class ScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScanPageState();
  }
}

// ignore: non_constant_identifier_names
class Send {
  final File img;

  Send(this.img);
}

class _ScanPageState extends State<ScanPage> {
  File img;

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      img = image;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No image found!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please click image.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AnyScan'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed: () {
                getImage(true);
              },
              color: Colors.green,
              icon: Icon(Icons.camera_alt_rounded),
              iconSize: 50.0,
            ),
            Expanded(
              child: img == null
                  ? Container()
                  : Image.file(
                      img,
                      height: 1000.0,
                      width: 350.0,
                    ),
            ),
            IconButton(
              onPressed: () {
                if (img != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayPage(img2: img)),
                  );
                } else {
                  _showMyDialog();
                }
                ;
              },
              color: Colors.green,
              icon: Icon(Icons.navigate_next_rounded),
              iconSize: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DisplayPage extends StatefulWidget {
  String get result => null;

  @override
  _DisplayPageState createState() => _DisplayPageState();

  File img2;
  DisplayPage({Key key, @required this.img2}) : super(key: key);
}

class _DisplayPageState extends State<DisplayPage> {
  loadModel() async {
    await Tflite.loadModel(
      model: "model_unquant.tflite",
      labels: "labels.txt",
    );
  }

  void initState() {
    super.initState();
    loadModel();
  }

  void dispose() async {
    super.dispose();

    await Tflite.close();
  }

  runModel() async {
    if (widget.img2 != null) {
      var recognitions = await Tflite.runModelOnImage(
        path: widget.img2.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 3,
        threshold: 0.2,
        asynch: true,
      );
      var result = "";

      recognitions.forEach((response) {
        result += response["label"] + "\n\n";
      });

      setState(() {
        print(result);
      });
    }
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AnyScan'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: widget.img2 == null
                  ? Container()
                  : Image.file(
                      widget.img2,
                      height: 700.0,
                      width: 300.0,
                    ),
            ),
            Center(
              child: Container(
                child: Text(
                  "Hello",
                ),
                height: 100.0,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
