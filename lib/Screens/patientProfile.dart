import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Screens/addPayment.dart';
import 'package:magnolia/Screens/createAppointment.dart';
import 'package:magnolia/api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// TODO : How to integrate administrative notes?
// TODO : Currently working
class PatientProfile extends StatefulWidget {
  static String route = "PatientProfile";

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile>
    with SingleTickerProviderStateMixin {
  Future<void>? launched;

  TabController? _tabController;
  ScrollController? _scrollController;
  bool? fixedScroll;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_smoothScrollToTop);

    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  _scrollListener() {
    _scrollController!.jumpTo(0);
  }

  _smoothScrollToTop() {
    _scrollController!.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }
  // _buildTabContext(int lineCount) => Container(
  //       child: ListView.builder(
  //         physics: const ClampingScrollPhysics(),
  //         itemCount: lineCount,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Text('some content');
  //         },
  //       ),
  //     );

  Future<void> _makePhoneCallMail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      activeIcon: Icons.close,
      icon: Icons.add,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: Green,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(Icons.chrome_reader_mode, color: Colors.white),
          backgroundColor: Green,
          onTap: () {
            Navigator.of(context).pushNamed(CreateAppointment.route);
          },
          label: 'Create Appointment',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Green,
        ),
        SpeedDialChild(
          child: Icon(Icons.people, color: Colors.white),
          backgroundColor: Green,
          onTap: () {
            Navigator.of(context).pushNamed(AddPayment.route);
          },
          label: 'Add Payment',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Green,
        ),
        SpeedDialChild(
          child: Icon(Icons.laptop_chromebook, color: Colors.white),
          backgroundColor: Green,
          onTap: () {},
          label: 'Share new Document',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> myTabs = [
      Container(
        width: MediaQuery.of(context).size.width * .26,
        child: Tab(text: 'OVERVIEW'),
      ),
      Container(
        width: MediaQuery.of(context).size.width * .26,
        child: Tab(text: 'DETAILS'),
      ),
      Container(
        width: MediaQuery.of(context).size.width * .26,
        child: Tab(text: 'CONTACTS'),
      ),
    ];

    Map? mapedData;
    // var a = 'Vivek';
    //delete a variable and uncomment below 2 line.
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments != null) {
      print(arguments['c_id']);
      mapedData = {'c_id': arguments['c_id']};
    }

    Future getData() async {
      try {
        print(mapedData.toString());
        http.Response responseData =
            await http.post(clientDetailApi, body: mapedData);
        final data = jsonDecode(responseData.body);
        return data;
      } on SocketException {
        print("socket Exception , No internet");
      } catch (e) {
        print(e.toString());
      }
    }

    Widget shimmerLoader() {
      return Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300]!,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.70,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    }

    Widget screen(var data) {
      return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.height * .40,
                    color: Green,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context)),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              data["result"]["c_fullname"],
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Text(
                              data["result"]["c_date"],
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launched = _makePhoneCallMail(
                                      'tel:${data["result"]["c_phone"]}');
                                },
                                child: Icon(
                                  Icons.phone,
                                  size: 25.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launched = _makePhoneCallMail(
                                      "mailto:${data["result"]["c_email"]}");
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.mail,
                                    size: 25.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.message,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Green,
                controller: _tabController,
                isScrollable: true,
                tabs: myTabs,
              ),
            ),
          ];
        },
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: [
              overView(),
              details(data),
              contacts(),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: buildSpeedDial(),
        body: FutureBuilder(
          future: getData(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return screen(snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            } else {
              return shimmerLoader();
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget overView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Administrative Notes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.note),
              SizedBox(
                width: 10.0,
              ),
              Text("No Note")
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Next Appointment",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(
                width: 10.0,
              ),
              Text("No Schedule Appointment")
            ],
          ),
        ],
      ),
    );
  }

  Widget details(var data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Contact Info",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15.0,
          ),
          InkWell(
            onTap: () => _makePhoneCallMail('tel:${data["result"]["c_phone"]}'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Mobile",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(Icons.phone, color: Green, size: 15.0),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(Icons.message, color: Green, size: 15.0),
                  ],
                ),
                Text("${data["result"]["c_phone"]}")
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          InkWell(
            onTap: () =>
                _makePhoneCallMail("mailto:${data["result"]["c_email"]}"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Work",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(Icons.mail, color: Green, size: 15.0),
                  ],
                ),
                Text("${data["result"]["c_email"]}")
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Address",
            style: TextStyle(color: Colors.grey),
          ),
          Text(
              "${data["result"]["c_street"]} ${data["result"]["c_city"]} ${data["result"]["c_state_name"]} ${data["result"]["c_zip"]}")
        ],
      ),
    );
  }

  Widget contacts() {
    return Container();
  }
}
