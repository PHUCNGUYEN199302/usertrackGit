import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:usertraker/SplashScreen.dart';
import 'package:usertraker/home.dart';
import 'package:usertraker/login.dart';


void main() async{
  runApp(MyApp());
//  configLoading();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //  builder: EasyLoading.init(),
    );
  }
}

class SplashScreenMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenMainState();
  }
}


class _SplashScreenMainState extends State<SplashScreenMain> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.show(status: 'Loading...');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child: Container(
           // child: CircularProgressIndicator(),
          ),
        ),
      ),

    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      EasyLoading.dismiss();
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.pushReplacement(
        context,
        // Create the SelectionScreen in the next step.
        MaterialPageRoute(builder: (context) => Home()),
      );

      // Naviga
    } else {
      Navigator.pushReplacement(
        context,
        // Create the SelectionScreen in the next step.
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }
}



void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 0)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
 //   ..customAnimation = CustomAnimation();
}

