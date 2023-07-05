import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Screens/CreateClientBillInsurance.dart';
import 'package:magnolia/Screens/createClientDetail.dart';

class CreateClient extends StatefulWidget {
  static String route = "CreateClient";
  @override
  _CreateClientState createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.5,
            tabs: [
              Tab(
                text: "Details",
              ),
              Tab(text: "Billing & Insurance"),
            ],
          ),
          title: Text('Create Client'),
          backgroundColor: Green,
        ),
        body: TabBarView(
          children: [
            CreateClientDetail(),
            CreateClientBillInsurance(),
          ],
        ),
      ),
    );
  }
}
