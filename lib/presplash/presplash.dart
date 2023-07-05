import 'dart:async';

import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Constant/constants.dart';
import 'package:magnolia/Screens/walkThrough.dart';

class PreSplash extends StatefulWidget {
  static String route = "PreSplash";
  @override
  _PreSplashState createState() => _PreSplashState();
}

class _PreSplashState extends State<PreSplash> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushNamed(WalkThrough.route);
  }

  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  logo,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
