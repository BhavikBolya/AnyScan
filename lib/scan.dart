import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:anyscan/display.dart';
import 'package:anyscan/test.dart';
import 'package:anyscan/filter.dart';

class ScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScanPageState();
  }

  final List<String> list = ['Red Apple', 'Mango', 'Lemon'];
}

class _ScanPageState extends State<ScanPage> {
  File img;
  ScanPage searchBar;

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      img = image;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No image found!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please click image.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text('AnyScan'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilterPage()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search(widget.list));
              }),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed: () {
                getImage(true);
              },
              color: Colors.green,
              icon: Icon(Icons.camera_alt_rounded),
              iconSize: 50.0,
            ),
            IconButton(
              onPressed: () {
                getImage(false);
              },
              color: Colors.green,
              icon: Icon(Icons.image_rounded),
              iconSize: 50.0,
            ),
            Expanded(
              child: img == null
                  ? Container()
                  : Image.file(
                      img,
                      height: 1000.0,
                      width: 350.0,
                    ),
            ),
            IconButton(
              onPressed: () {
                if (img != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayPage(img2: img)),
                  );
                } else {
                  _showMyDialog();
                }
              },
              color: Colors.green,
              icon: Icon(Icons.navigate_next_rounded),
              iconSize: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> list2 = [
    'red apple',
    'mango',
    'papaya',
    'green chili',
    'cabbage',
    'french beans',
    'coriander',
    'fenugreek',
    'peas',
    'granysmith apple',
    'tomato',
    'lemon',
    'orange',
    'watermelon',
    'banana'
  ];
  final List<String> listExample;
  Search(this.listExample);

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = listExample
        : suggestionList.addAll((list2.where(
            (element) => element.contains(query.toLowerCase()),
          )));
    print(suggestionList);
    return Container(
      color: Colors.grey[900],
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              suggestionList[index],
              style: TextStyle(
                color: Colors.amberAccent[200],
              ),
            ),
            leading: query.isEmpty
                ? Icon(
                    Icons.access_time,
                    color: Colors.amberAccent[200],
                  )
                : SizedBox(),
            onTap: () {
              selectedResult = suggestionList[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TestPage(
                          fruit_name: selectedResult,
                        )),
              );
            },
          );
        },
      ),
    );
  }
}
