import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

// ignore: must_be_immutable
class ScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScanPageState();
  }
}

class _ScanPageState extends State<ScanPage> {
  File _image;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
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
              icon: Icon(Icons.camera_alt_sharp),
              iconSize: 100.0,
            ),
            Expanded(child: _image == null? Container() : Image.file(_image, height: 700.0, width: 300.0,),),
            
            IconButton(
              onPressed: () {
              },
              color: Colors.green,
              icon: Icon(Icons.navigate_next_sharp),
              iconSize: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
