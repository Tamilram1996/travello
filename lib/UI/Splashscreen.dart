import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelo/UI/adpage.dart';
import '../Utils/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Advertisementpage()),
      ),
    );
  }


  @override
  void dispose() {
    _timer?.cancel(); // Prevents memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size once

    return SafeArea(
      child: Scaffold(
        backgroundColor: Base.primaryColor,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset(
            "assets/splash.png",
            fit: BoxFit.cover, // Ensures full-screen coverage
          ),
        ),
      ),
    );
  }
}
