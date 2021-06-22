import 'dart:io';
import 'package:anyscan/screens/detect/detect.dart';
import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child:Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Confirm the image...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      IconButton(
                        onPressed: () { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => DetectPage(
                                      img2: File(path),
                                    ))); 
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}