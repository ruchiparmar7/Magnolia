import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Screens/setting.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xffF2F2F2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffC4C4C4),
                  radius: 35.0,
                ),
                SizedBox(height: 15),
                Text(
                  "Vivek Parmar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "parmarvivek084@gmail.com",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Green,
            ),
            title: Text("Settings"),
            onTap: () => Navigator.of(context).pushNamed(SettingPage.route),
          ),
          ListTile(
            leading: Icon(
              Icons.fact_check,
              color: Green,
            ),
            title: Text("Security Checkup"),
          ),
          ListTile(
            leading: Icon(
              Icons.card_giftcard,
              color: Green,
            ),
            title: Text("Earn Free Credit"),
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Green,
            ),
            title: Text("Get Help"),
          ),
          ListTile(
            leading: Icon(
              Icons.sync,
              color: Green,
            ),
            title: Text("Sync Your Account"),
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
