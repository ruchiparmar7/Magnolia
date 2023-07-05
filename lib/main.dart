import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Screens/addPayment.dart';
import 'package:magnolia/Screens/createClient.dart';
import 'package:magnolia/Screens/createClientDetailName.dart';
import 'package:magnolia/Screens/createEvent.dart';
import 'package:magnolia/Screens/localAuth.dart';
import 'package:magnolia/Screens/patientProfile.dart';
import 'package:magnolia/Screens/phoneScreen.dart';
import 'package:magnolia/Screens/setting.dart';
import 'package:magnolia/presplash/presplash.dart';
import 'NavigationDrawer/bottomNavigation.dart';
import 'Registration/signin.dart';
import 'Registration/signup.dart';
import 'Screens/createAppointment.dart';
import 'Screens/walkThrough.dart';
import 'Splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magnolia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PreSplash(),
      routes: {
        SignIn.route: (context) => SignIn(),
        SignUp.route: (context) => SignUp(),
        PreSplash.route: (context) => PreSplash(),
        Splash.route: (context) => Splash(),
        WalkThrough.route: (context) => WalkThrough(),
        CustomBottomNavigationBar.route: (context) =>
            CustomBottomNavigationBar(),
        CreateAppointment.route: (context) => CreateAppointment(),
        CreateEvent.route: (context) => CreateEvent(),
        SettingPage.route: (context) => SettingPage(),
        CreateClient.route: (context) => CreateClient(),
        CreateClientDetailName.route: (context) => CreateClientDetailName(),
        Phone.route: (context) => Phone(),
        PatientProfile.route: (context) => PatientProfile(),
        AddPayment.route: (context) => AddPayment(),
        LocalAuth.route: (context) => LocalAuth(),
      },
    );
  }
}
