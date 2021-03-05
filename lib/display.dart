import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

loadModel() async {
  await Tflite.loadModel(
    model: "model_unquant.tflite",
    labels: "labels.txt",);
}

String getModelPath() {
  return "converted_tflite_quantized/model.tflite";
}

String getLabelPath() {
  return "converted_tflite_quantized/labels.txt";
}

class DisplayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DisplayPageState();
  }
}

class _DisplayPageState extends State<DisplayPage> {
  File _image;
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
              child: _image == null
                  ? Container()
                  : Image.file(
                      _image,
                      height: 700.0,
                      width: 300.0,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
