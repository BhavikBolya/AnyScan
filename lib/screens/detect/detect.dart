import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:anyscan/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tflite/tflite.dart';
import 'package:percent_indicator/percent_indicator.dart';

// ignore: must_be_immutable
class DetectPage extends StatefulWidget {
  @override
  _DetectPageState createState() => _DetectPageState();

  File img2;
  DetectPage({Key? key, required this.img2}) : super(key: key);
}

class _DetectPageState extends State<DetectPage> {

  bool loading = true;
  String hindi = '';
  String detectFruit = '';
  String english = '';
  String carbs = '';
  String protein = '';
  String fiber = '';
  String season = '';

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    runModel();
    
  }

  void dispose() async {
    super.dispose();
    //startTime();
    await Tflite.close();
  }

  var result = "";

  runModel() async {
    var recognitions = await Tflite.runModelOnImage(
      path: widget.img2.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 5,
      threshold: 0.2,
      asynch: true,
    );

    recognitions!.forEach((response) {
      result = response["label"];
    });
    print(result.toString());
    await getJson();
    if(!this.mounted)
    setState(() {
       dispose();
    });
    
  }

  List _fruits = [];
  Future<void> getJson() async {
    final String fruit = await rootBundle.loadString('assets/fruits.json');
    final data = await json.decode(fruit);
    setState(() {
      _fruits = data["fruits"];
    });
    for (var i = 0; i < _fruits.length; i++) {
      String fruit = _fruits[i]['Name'].toString();
      if (result.toLowerCase().contains(fruit.toLowerCase())) {
        setState(() {
          loading = false;
          english = _fruits[i]['Name'].toString();
          hindi = _fruits[i]['Hindi'].toString();
          carbs = _fruits[i]['Carbohydrates'].toString();
          protein = _fruits[i]['Protein'].toString();
          fiber = _fruits[i]['Fiber'].toString();
          season = _fruits[i]['Season'].toString();
          detectFruit = '' + _fruits[i]['Image'];
          
        });
      }
    }
  }

  Future<bool> _onBackPressed() async {
    return true;
  }

@override
Widget build(BuildContext context){
  if(loading==false)
    return detect();
  else
    return LoadingScreen(context);
}

Widget detect() {
  return Scaffold(
    backgroundColor: kPrimaryColor,
    appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context) ;
              Navigator.pop(context) ;
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
    body: WillPopScope(
      onWillPop: _onBackPressed,
      child: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),),
        panel: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 3,
                  width: MediaQuery.of(context).size.width/11,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              DetectCard(context),
              SizedBox(height: 30,),
              Text('Nutrient Values',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Carbohydrates',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text(' $carbs g / 100g',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 30,
                    lineHeight: 2.0.h,
                    percent: double.parse(carbs)/100,
                    progressColor: Colors.red,
                    backgroundColor: Colors.red[100],
                  ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Protein',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text('$protein g/ 100g',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 30,
                    lineHeight: 2.0.h,
                    percent: double.parse(protein)/100,
                    progressColor: Colors.green[800],
                    backgroundColor: Colors.green[100],
                  ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fiber',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text('$fiber g/ 100g',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 30,
                    lineHeight: 2.0.h,
                    percent: double.parse(fiber)/100,
                    progressColor: Colors.yellow[800],
                    backgroundColor: Colors.yellow[100],
                  ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Season',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                  Text('$season',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                ],
              ),
    
            ],
          ),
        ),
        boxShadow: null,
        minHeight: 20.h,
        maxHeight: 80.0.h,
        collapsed: Container(
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children:<Widget>[
                DetectCard(context),
                Icon(
                Icons.keyboard_arrow_up_sharp,
                size: 40,
              ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 60.0.h,
                width: 90.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.file(
                    widget.img2,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
  // ignore: non_constant_identifier_names
  Widget DetectCard(BuildContext context) {
    return Container(
      height: 15.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          kDefaultShadow
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
                height: 120,
                  width: 100,
                    padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, 
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    fit:  BoxFit.contain,
                    image: AssetImage(
                    detectFruit,
                  ),)
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        english,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                    
                  ),
                  SizedBox(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        hindi,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Widget LoadingScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(result),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 2,
           )
         ],
       ),
      ),
    );
  }
}