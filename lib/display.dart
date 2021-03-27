import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';


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
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  void initState() {
    super.initState();
    loadModel();
    runModel();
  }

  void dispose() async {
    super.dispose();

    await Tflite.close();
  }

  var result = "";

  runModel() async {
    if (widget.img2 != null) {
      var recognitions = await Tflite.runModelOnImage(
        path: widget.img2.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 5,
        threshold: 0.2,
        asynch: true,
      );

      recognitions.forEach((response) {
        result += response["label"]+ "\n\n";
      });

      setState(() {
        // dispose();
      });
    }
  }

  Widget build(BuildContext context) {
    // DateTime now = new DateTime.now();
    // String mnth;
    // if (now.month == 3)  mnth = "March";
    // result += mnth;

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
                  result,
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