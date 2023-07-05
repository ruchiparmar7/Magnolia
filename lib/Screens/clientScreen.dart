import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/NavigationDrawer/bottomNavigation.dart';
import 'package:magnolia/Screens/patientProfile.dart';
import 'package:http/http.dart' as http;
import 'package:magnolia/api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  var duplicateDataItemLength, duplicateData;

  Future getData() async {
    try {
      final responseData = await http.get(clientListApi);
      final data = jsonDecode(responseData.body);
      print(data.toString);
      duplicateData = data;
      duplicateDataItemLength = data["result"].length;
      return data;
    } on SocketException {
      print("socket Exception , No internet");
    } catch (e) {
      print(e.toString());
    }
  }

  //final List<String> patientListName = ["James", "Elizabeth", "John", "Mary"];

  @override
  Widget build(BuildContext context) {
    print("widget");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.popAndPushNamed(
                context, CustomBottomNavigationBar.route)),
        title: Text('Clients & Contacts'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //if data not available then it will show message
                if (duplicateData == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Check Connection"),
                    duration: Duration(seconds: 3),
                  ));
                } else {
                  showSearch(
                      context: context, delegate: PatientSearch(duplicateData));
                }
              }),
        ],
      ),
      body: FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return clientListfun(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
          } else {
            return shimmerLoader();
          }
          return Container();
        },
      ),
    );
  }

  Widget shimmerLoader() {
    int offset = 0;
    int time = 800;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = time + offset;
          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300]!,
            period: Duration(milliseconds: time),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .50,
                      height: MediaQuery.of(context).size.width * .06,
                      color: Colors.grey,
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget clientListfun(var data) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: ListView.builder(
          itemCount: duplicateDataItemLength,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: SlideAnimation(
                  verticalOffset: 60.0,
                  child: FadeInAnimation(
                    // delay: Duration(milliseconds: 300),

                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Container(
                        color: Color(0xff00bf93).withOpacity(0.2),
                        child: ListTile(
                          onTap: () {
                            //print(patientListName[index]);
                            Navigator.of(context)
                                .pushNamed(PatientProfile.route, arguments: {
                              'c_id': data["result"][index]["c_id"].toString()
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown.shade800,
                            child: Text(data["result"][index]["c_fullname"]
                                .toString()
                                .substring(0, 1)),
                          ),
                          title: Text(
                              data["result"][index]["c_fullname"].toString()),
                        ),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }
}

//For searching
class PatientSearch extends SearchDelegate {
  //Here Full Name must unique.
  List<String> patientListName = [];
  //Here key is name & value as id to pass id to new Screen.
  Map<String, String> patientNameId = new Map();
  PatientSearch(var data) {
    for (int index = 0; index < data["result"].length; index++) {
      patientListName.add(data["result"][index]["c_fullname"].toString());
      patientNameId[data["result"][index]["c_fullname"].toString()] =
          data["result"][index]["c_id"].toString();
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> searchResult = patientListName
        .where((element) => element.toLowerCase().startsWith(query))
        .toList();

    return (query.isEmpty)
        ? Center(
            child: Text("Search Now"),
          )
        : ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ListTile(
                  onTap: () {
                    String idOfClickPatient =
                        patientNameId[searchResult[index]]!;
                    close(context, null);
                    // print("done ${searchResult[index]}");
                    Navigator.of(context).pushNamed(PatientProfile.route,
                        arguments: {'c_id': idOfClickPatient});
                  },
                  title: RichText(
                    text: TextSpan(
                      text: searchResult[index].substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: searchResult[index].substring(query.length),
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
