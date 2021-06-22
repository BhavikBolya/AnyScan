import 'package:anyscan/constants.dart';
import 'package:anyscan/screens/CameraScreen.dart';
import 'package:anyscan/screens/scan/scan.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AnyScan',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Raleway',
          ),
          home: ScanPage(), 
        );
      },
    );
  }
}