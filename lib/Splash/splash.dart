import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Constant/constants.dart';
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Custom/CustomRaisedButton.dart';
import 'package:magnolia/Registration/signin.dart';

class Splash extends StatefulWidget {
  static String route = "Splash";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String sText1 = "Quand la mère et l'enfant ";
  String sText2 = "embrassent la vie";
  String sText3 = "- By Meev";
  /* startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
    navigationPage();
  }

  void navigationPage() {
    Navigator.of(context).pushNamed(PreSplash.route);
  }

  void initState() {

    super.initState();
    startTime();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [Green, Green, Black],
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(bookLogo, height: 320, width: 320),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomRaisedButton(
                  buttonText: "Book Appointment",
                  buttonBg: White,
                  buttonTextColor: Green,
                  click: () {
                    Navigator.of(context).pushNamed(SignIn.route);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
