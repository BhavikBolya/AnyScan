import 'package:anyscan/screens/details/itemCard.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SeasonPage extends StatefulWidget {
  @override
  _SeasonPageState createState() => _SeasonPageState();

  // ignore: non_constant_identifier_names
  String season;
  // ignore: non_constant_identifier_names
  SeasonPage({Key? key, required this.season}) : super(key: key);
}

class _SeasonPageState extends State<SeasonPage> {
  late List data;

  List _fruits = [];
  Future<void> getJson() async {
    final String fruit = await rootBundle.loadString('assets/fruits.json');
    final data = await json.decode(fruit);

    setState(() {
      _fruits = data["fruits"];
    });
  }

  void initState() {
    super.initState();
    getJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFFF5CEB8),
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
      body: Container(
        child: SafeArea(
           child: Column(
             children: <Widget>[
               Container(
                 height: 60,
                 child: Text(widget.season,
                 style: TextStyle(fontSize: 30.sp ,fontWeight: FontWeight.w900),),
               ),
               Expanded(
                 child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: _fruits.length,
                      itemBuilder: (context, index) {
                        String season1 = _fruits[index]['Season'].toString();
                        if (season1.toLowerCase().contains(widget.season.toLowerCase())){
                          return ItemCard(
                            image: _fruits[index]['Image'],
                            english: _fruits[index]['Name'],
                            hindi: _fruits[index]['Hindi'],
                            itemIndex: index,
                          );
                        }
                        else
                          return Container();
                      },
                    )
                  ],
                ),
               ),
             ],
           ),
        ),
      ),
    );
  }
}
