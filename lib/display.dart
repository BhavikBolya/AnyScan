import 'dart:convert';
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
        result = response["label"];
      });

      setState(() {
        // dispose();
      });
    }
  }

  translate() {
    String hin;
    var fruits = '''[
    {
        "Name": "Mango",
        "Hindi": "Aam/ आम",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "15g",
        "Protein": "0.8g",
        "Fiber": "1.6g",
        "Season": "Summer",
        "Image": "assets/sample_predictions/Mango.png"
    },
    {
        "Name": "Green Chili",
        "Hindi": "Hari Mirchi/ हरी मिर्च",
        "Disp": "Nutrients per pepper",
        "Carbohydrates": "1.4g",
        "Protein": "1.3g",
        "Fiber": "0.7g",
        "Season": "Summer",
        "Image": "assets/sample_predictions/GreenChili.png"
    },
    {
        "Name": "Cabbage",
        "Hindi": "Gobi/ गोबी",
        "Disp": "Nutrients per cup",
        "Carbohydrates": "3.2g",
        "Protein": "1.3g",
        "Fiber": "2.0g",
        "Season": "Winter",
        "Image": "assets/sample_predictions/Cabbage.png"
    },
    {
        "Name": "French Beans",
        "Hindi": "फ़्रेंच बीन",
        "Disp": "Nutrients per cup",
        "Carbohydrates": "8.3g",
        "Protein": "3.1g",
        "Fiber": "4.6g",
        "Season": "All seasons",
        "Image": "assets/sample_predictions/FrenchBeans.png"
    },
    {
        "Name": "Coriander",
        "Hindi": "Dhaniya/ धनिया",
        "Disp": "Nutrients per cup",
        "Carbohydrates": "1.0g",
        "Protein": "0.5g",
        "Fiber": "0.7g",
        "Season": "Monsoon",
        "Image": "assets/sample_predictions/Coriander.png"
    },
    {
        "Name": "Fenugreek",
        "Hindi": "Methi/ मेथी",
        "Disp": "Nutrients per cup",
        "Carbohydrates": "1.3g",
        "Protein": "0.9g",
        "Fiber": "1.0g",
        "Season": "Winter",
        "Image": "assets/sample_predictions/Fenugreek.png"
    },
    {
        "Name": "Peas",
        "Hindi": "Matar/ मटर",
        "Disp": "Nutrients per cup",
        "Carbohydrates": "23.1g",
        "Protein": "10.4g",
        "Fiber": "12.5g",
        "Season": "Summer",
        "Image": "assets/sample_predictions/Peas.png"
    },
    {
        "Name": "Grannysmith Apple",
        "Hindi": "-",
        "Disp": "Nutrients per piece (medium)",
        "Carbohydrates": "26.0g",
        "Protein": "0.0g",
        "Fiber": "5.9g",
        "Season": "Monsoon",
        "Image": "assets/sample_predictions/GrannySmithApple.png"
    },
    {
        "Name": "Lemon",
        "Hindi": "Nimboo/ नींबू",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "7.4g",
        "Protein": "0.7g",
        "Fiber": "1.9g",
        "Season": "Monsoon and Winter",
        "Image": "assets/sample_predictions/Lemon.png"
    },
    {
        "Name": "Watermelon",
        "Hindi": "Tarbooj/ तरबूज",
        "Disp": "Nutrients per cup",
        "Carbohydrates": "5.0g",
        "Protein": "0.3g",
        "Fiber": "0.9g",
        "Season": "Summer",
        "Image": "assets/sample_predictions/Watermelon.png"
    },
    {
        "Name": "Tomato",
        "Hindi": "Tamatar/ टमाटर",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "3.9g",
        "Protein": "0.9g",
        "Fiber": "1.2g",
        "Season": "Summer",
        "Image": "assets/sample_predictions/Tomato.png"
    },
    {
        "Name": "Orange",
        "Hindi": "Santara/ संतरा",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "12g",
        "Protein": "0.9g",
        "Fiber": "2.4g",
        "Season": "Summer and Winter",
        "Image": "assets/sample_predictions/Orange.png"
    },
    {
        "Name": "Papaya",
        "Hindi": "Papita/ पपीता",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "13g",
        "Protein": "29g",
        "Fiber": "4g",
        "Season": "Summer and Monsoon",
        "Image": "assets/sample_predictions/Papaya.png"
    },
    {
        "Name": "Red Apple",
        "Hindi": "Seb/ सेब",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "14g",
        "Protein": "0.3g",
        "Fiber": "2.4g",
        "Season": "All seasons",
        "Image": "assets/sample_predictions/RedApple.png"
    },
    {
        "Name": "Banana",
        "Hindi": "Kela/ केला",
        "Disp": "Nutrients per piece",
        "Carbohydrates": "23g",
        "Protein": "1.1g",
        "Fiber": "2.6g",
        "Season": "All seasons",
        "Image": "assets/sample_predictions/Banana.png"
    }
    ]''';
    var fruit1 = jsonDecode(fruits);
    for (var i = 0; i <= 14; i++) {
      String fruit = fruit1[i]['Name'].toString();
      if (result.toLowerCase().contains(fruit.toLowerCase()))
        hin = fruit1[i]['Hindi'].toString();
    }
    return hin;
  }
  String hindi = '' ;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 50.0, 0, 40.0),
              child: Center(
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        result,
                        style: TextStyle(
                          color: Colors.amberAccent[200],
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          setState(() {
                            hindi = translate();
                          });
                        },
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        color: Colors.amberAccent[200],
                        icon: Icon(Icons.translate_outlined),
                        label: Text("Translate"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                '$hindi',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
