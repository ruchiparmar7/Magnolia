import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/widgets.dart';
import 'package:magnolia/Custom/Color.dart';
import 'package:custom_switch/custom_switch.dart';

class SettingPage extends StatefulWidget {
  static String route = "SettingPage";
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _enable = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Settings'),
          backgroundColor: Green,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "New Message",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 66,
                      height: 26,
                      child: CustomSwitch(
                        activeColor: Green,
                        value: _enable,
                        onChanged: (bool val) {
                          setState(() {
                            _enable = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                color: Grey,
                thickness: 0.4,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Appointment Request Allert",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 66,
                      height: 26,
                      child: CustomSwitch(
                        activeColor: Green,
                        value: _enable,
                        onChanged: (bool val) {
                          setState(() {
                            _enable = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                color: Grey,
                thickness: 0.4,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Video Appointment Allert",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 66,
                      height: 26,
                      child: CustomSwitch(
                        activeColor: Green,
                        value: _enable,
                        onChanged: (bool val) {
                          setState(() {
                            _enable = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                color: Grey,
                thickness: 0.4,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Application",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Open Source Libraries")
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                color: Grey,
                thickness: 0.4,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Privacy Policy")
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                color: Grey,
                thickness: 0.4,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Log Out")
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                color: Grey,
                thickness: 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
