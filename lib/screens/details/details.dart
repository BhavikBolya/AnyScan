import 'package:anyscan/constants.dart';
import 'package:anyscan/screens/details/overview_widget.dart';
import 'package:anyscan/screens/details/title_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {

  @override
  _DetailsPageState createState() => _DetailsPageState();
  // ignore: non_constant_identifier_names
  String fruit_name;
  // ignore: non_constant_identifier_names
  DetailsPage({required this.fruit_name});  
}
month() {
    DateTime now = new DateTime.now();
    String sea1 = '';
    if (now.month == 3 || now.month == 4 || now.month == 5) {
      sea1 = "Summer";
    }
    if (now.month == 6 || now.month == 7 || now.month == 8 || now.month == 9) {
      sea1 = "Monsoon";
    }
    if (now.month == 10 ||
        now.month == 11 ||
        now.month == 12 ||
        now.month == 1 ||
        now.month == 2) {
      sea1 = "Winter";
    }
    return sea1;
  }

class _DetailsPageState extends State<DetailsPage> {
  late List data;
  String hindi = '';
  String image = '';
  String english = '';
  String carbs = '';
  String protein = '';
  String fiber = '';
  String season = ''; 
  String mont = month();
  var selectedCard = 'WEIGHT';


  List _fruits = [];
  Future<void> getJson() async {
    final String fruit = await rootBundle.loadString('assets/fruits.json');
    final data = await json.decode(fruit);
    setState(() {
      _fruits = data["fruits"];
    });
    for (var i = 0; i < _fruits.length; i++) {
      String fruit = _fruits[i]['Name'].toString();
      if (fruit.toLowerCase() == widget.fruit_name.toLowerCase()) {
        setState(() {
          english = _fruits[i]['Name'].toString();
          hindi = _fruits[i]['Hindi'].toString();
          carbs = _fruits[i]['Carbohydrates'].toString();
          protein = _fruits[i]['Protein'].toString();
          fiber = _fruits[i]['Fiber'].toString();
          season = _fruits[i]['Season'].toString();
          image = '' + _fruits[i]['Image'];
        });
      }
    }
  }

  void initState() {
    super.initState();
    getJson();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.transparent),
                Positioned(
                    top: 80.0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            color: Colors.white),
                        height: size.height,
                        width: size.width)),
                Positioned(
                  top: 10.0,
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        child: Center(
                          child: Hero(
                              tag: image,
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(image),
                                          fit: BoxFit.contain)),
                                  height: 200.0,
                                  width: 200.0)),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(english+'\n'+hindi,
                                style: TextStyle(
                                  fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleWidget(title: "Overview"),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OverviewWidget(
                                title: "Protein",
                                subtitle: "$protein g",
                                imagePath: "assets/icons/protein.png",
                              ),
                              SizedBox(width: 30),
                              OverviewWidget(
                                title:"Carbs",
                                subtitle: "$carbs g",
                                imagePath: "assets/icons/carbohydrates.png",
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              OverviewWidget(
                                title: "Fiber",
                                subtitle: "$fiber g",
                                imagePath: "assets/icons/vegetable.png",
                              ),
                            ],
                          ),
                          ],
                          ),
                            SizedBox(height: 20.0),
                            TitleWidget(title: "Availability"),
                            SizedBox(height: 20),
                            SizedBox(
                              width: size.width-20,
                              child: Text(
                              season.contains(mont) ||
                                              season == 'All seasons'
                                          ? "Good quality item might be available in the market."
                                          : "Not the best time to buy.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  height: 1.6,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),           
              ]
            ),
          )
        )
    );
  }
}
