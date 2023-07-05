import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';

// TODO: Need to change logic for adding & delete phone & validation for phone.
class Phone extends StatefulWidget {
  static String route = "Phone";

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  int _groupValue = 0;
  final List<String> phoneTypeList = ["Mobile"];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .80,
                    child: ListView.builder(
                        itemCount: phoneTypeList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * .08,
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(phoneTypeList[index]),
                                        SizedBox(
                                          width: 2.0,
                                        ),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: size.width * .40,
                                    height: size.height * .10,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(color: Green),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.blue),
                                        ),
                                        labelText: 'Phone No',
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      phoneTypeList.removeAt(index);
                                    }),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () => showModalBottomSheet<void>(
                    context: context,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter state) {
                          return Container(
                            height: MediaQuery.of(context).size.height * .60,
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Type",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: _myRadioButton(
                                        title: "Work",
                                        value: 1,
                                        onChanged: (newValue) {
                                          state(() {
                                            _groupValue = newValue!;
                                          });
                                          setState(() {
                                            phoneTypeList.add('Work');
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: _myRadioButton(
                                        title: "Mobile",
                                        value: 2,
                                        onChanged: (newValue) {
                                          state(() {
                                            _groupValue = newValue!;
                                          });
                                          setState(() {
                                            phoneTypeList.add('Mobile');
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: _myRadioButton(
                                        title: "Home",
                                        value: 3,
                                        onChanged: (newValue) {
                                          state(() {
                                            _groupValue = newValue!;
                                          });
                                          setState(() {
                                            phoneTypeList.add('Home');
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: _myRadioButton(
                                        title: "Fax",
                                        value: 4,
                                        onChanged: (newValue) {
                                          state(() {
                                            _groupValue = newValue!;
                                          });
                                          setState(() {
                                            phoneTypeList.add('Fax');
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      color: Green,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Add Phone No",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myRadioButton(
      {String? title, int? value, void Function(int?)? onChanged}) {
    return RadioListTile<int>(
      activeColor: Green,
      value: value!,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title!),
      selected: false,
    );
  }
}
