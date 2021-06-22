
import 'dart:ui';

import 'package:sizer/sizer.dart';
import 'package:anyscan/screens/CameraScreen.dart';
import 'package:anyscan/screens/CameraView.dart';
import 'package:anyscan/screens/filter/filter.dart';
import 'package:anyscan/screens/scan/components/search_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class ScanPage extends StatefulWidget {

  @override
  _ScanPageState createState() => _ScanPageState();

  final List<String> list = ['Red Apple', 'Mango', 'Lemon'];
}

class _ScanPageState extends State<ScanPage> {
  File? img;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedfile;
    pickedfile = await picker.getImage(source: ImageSource.gallery);
    if(pickedfile.path!=null){
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child:CameraViewPage(
                path: pickedfile.path,
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 45.h,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          width: 52,
                          child: IconButton(
                            icon: Icon(Icons.filter_alt_outlined, size: 30,), 
                            onPressed: () {
                              Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRight,
                                child:FilterPage()),
                            );
                              
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          width: 52,
                          child: IconButton(
                            icon: Icon(Icons.search_outlined,size: 30,), 
                            onPressed: () { 
                              Navigator.push(
                                context,
                                PageTransition(
                                type:PageTransitionType.rightToLeft,
                                child: SearchPage()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0.h),
                  Text(
                    "Welcome \nStart Scanning" ,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child:CameraScreen()
                          )
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                        height: 20.h,
                        width: size.width-20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width/4 -20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/scan.png'),
                                  fit: BoxFit.contain,
                                )
                              ),
                            ),
                            Container(
                              child: Text(
                                'Click from Camera',
                                style:TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    InkWell(
                      onTap: (){
                        getImage();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                        height: 20.h,
                        width: size.width-20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.lightGreen[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width/4 -20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/upload.png'),
                                  fit: BoxFit.contain,
                                )
                              ),
                            ),
                            Container(
                              child: Text(
                                'Upload Image',
                                style:TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                    ),)
                  ],
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


