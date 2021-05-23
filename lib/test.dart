import 'package:flutter/material.dart';
import 'dart:convert' show JsonDecoder;

// ignore: must_be_immutable
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();

  // ignore: non_constant_identifier_names
  String fruit_name;
  // ignore: non_constant_identifier_names
  TestPage({Key key, @required this.fruit_name}) : super(key: key);
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

class _TestPageState extends State<TestPage> {
  List data;
  String mont = month();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("AnyScan"),
        centerTitle: true,
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
                    String fruit = mydata[index]['Name'].toString();
                    if (fruit.toLowerCase() == widget.fruit_name.toLowerCase())
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
                              SizedBox(height: 30.0),
                              Text(
                                'AVAILABILITY',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                mydata[index]['Season'].contains(mont) ||
                                        mydata[index]['Season'] == 'All seasons'
                                    ? "Good quality item might be available in the market."
                                    : "Not the best time to buy.",
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
