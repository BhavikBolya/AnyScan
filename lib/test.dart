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

class _TestPageState extends State<TestPage> {
  List data;
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
