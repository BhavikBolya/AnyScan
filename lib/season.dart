import 'package:flutter/material.dart';
import 'dart:convert' show JsonDecoder;
import 'package:anyscan/scan.dart';

// ignore: must_be_immutable
class SeasonPage extends StatefulWidget {
  @override
  _SeasonPageState createState() => _SeasonPageState();

  // ignore: non_constant_identifier_names
  String season;
  // ignore: non_constant_identifier_names
  SeasonPage({Key key, @required this.season}) : super(key: key);
}

class _SeasonPageState extends State<SeasonPage> {
  List data;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("AnyScan"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanPage()),
                );
              }),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Center(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/fruits.json'),
              builder: (context, snapshot) {
                var mydata = JsonDecoder().convert(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    double width = MediaQuery.of(context).size.width;
                    String season1 = mydata[index]['Season'].toString();
                    if (season1
                        .toLowerCase()
                        .contains(widget.season.toLowerCase()))
                      return Card(
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: [
                                  SizedBox(height: 10.0),
                                  Center(
                                    child: CircleAvatar(
                                      radius: 45.0,
                                      backgroundColor: Colors.grey[900],
                                      backgroundImage: AssetImage(
                                          '' + mydata[index]['Image']),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[500],
                                    height: 60.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'NAME :',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "" + mydata[index]['Name'],
                                              style: TextStyle(
                                                color: Colors.amberAccent[200],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3.0),
                                        Row(
                                          children: [
                                            Text(
                                              'HINDI NAME :',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "" + mydata[index]['Hindi'],
                                              style: TextStyle(
                                                color: Colors.amberAccent[200],
                                                fontWeight: FontWeight.bold,
                                                fontSize: width*0.04,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3.0),
                                        Text(
                                          "" + mydata[index]['Disp'],
                                          style: TextStyle(
                                            color: Colors.amberAccent[200],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                        SizedBox(height: 3.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'CARBS',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              'PROTEIN',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              'FIBER',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "" + mydata[index]['Carbohydrates'],
                                              style: TextStyle(
                                                color: Colors.amberAccent[200],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            Text(
                                              "    " + mydata[index]['Protein'],
                                              style: TextStyle(
                                                color: Colors.amberAccent[200],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            Text(
                                              "     " + mydata[index]['Fiber'],
                                              style: TextStyle(
                                                color: Colors.amberAccent[200],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[500],
                                    height: 38.0,
                                  ),
                                ],
                              ),
                              //SizedBox(height: 38.0),
                            ],
                          ),
                        ),
                      );
                    else
                      return Container();
                  },
                  itemCount: mydata == null ? 0 : mydata.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
