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
                  MaterialPageRoute(
                      builder: (context) =>
                          ScanPage()),
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
                    String season1 = mydata[index]['Season'].toString();
                    if (season1.toLowerCase().contains(widget.season.toLowerCase()))
                      return Card(
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Center(
                                child: CircleAvatar(
                                  radius: 100.0,
                                  backgroundColor: Colors.grey[900],
                                  backgroundImage:
                                      AssetImage('' + mydata[index]['Image']),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[500],
                                height: 60.0,
                              ),
                              Text(
                                'NAME',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "" + mydata[index]['Name'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'HINDI NAME',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "" + mydata[index]['Hindi'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                "" + mydata[index]['Disp'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'CARBOHYDRATES',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "" + mydata[index]['Carbohydrates'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'PROTEIN',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "" + mydata[index]['Protein'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'FIBER',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "" + mydata[index]['Fiber'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'SEASON',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "" + mydata[index]['Season'],
                                style: TextStyle(
                                  color: Colors.amberAccent[200],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              Divider(
                                color: Colors.grey[500],
                                height: 38.0,
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
