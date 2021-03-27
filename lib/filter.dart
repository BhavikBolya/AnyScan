import 'package:flutter/material.dart';
import 'package:anyscan/season.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

enum Seasons { summer, winter, monsoon, all_season }

class _FilterPageState extends State<FilterPage> {
  List data;
  Seasons _site = Seasons.summer;
  String seas = "summer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: Text("AnyScan"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 40, 0, 0),
              child: Column(
                children: [
                  RadioListTile(
                    title: const Text(
                      'Summer',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    value: Seasons.summer,
                    groupValue: _site,
                    onChanged: (Seasons value) {
                      setState(() {
                        _site = value;
                        seas = "summer";
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'Winter',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    value: Seasons.winter,
                    groupValue: _site,
                    onChanged: (Seasons value) {
                      setState(() {
                        _site = value;
                        seas = "winter";
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'Monsoon',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    value: Seasons.monsoon,
                    groupValue: _site,
                    onChanged: (Seasons value) {
                      setState(() {
                        _site = value;
                        seas = "monsoon";
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'All Seasons',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    value: Seasons.all_season,
                    groupValue: _site,
                    onChanged: (Seasons value) {
                      setState(() {
                        _site = value;
                        seas = "all seasons";
                      });
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              color: Colors.grey[900],
              child: Text(
                "Filter",
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  letterSpacing: 2.0,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SeasonPage(season: seas)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
