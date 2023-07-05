import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Screens/createClientDetailName.dart';
import 'package:magnolia/Screens/phoneScreen.dart';

class CreateClientDetail extends StatefulWidget {
  @override
  _CreateClientDetailState createState() => _CreateClientDetailState();
}

class _CreateClientDetailState extends State<CreateClientDetail> {
  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Text(
            "Client Type:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.0,
          ),
          InkWell(
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
                      height: MediaQuery.of(context).size.height * .45,
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choose Client Type",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, top: 10.0),
                              child: _myRadioButton(
                                title: "Adult",
                                value: 1,
                                onChanged: (newValue) =>
                                    state(() => _groupValue = newValue!),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: _myRadioButton(
                                title: "Minor",
                                value: 2,
                                onChanged: (newValue) =>
                                    state(() => _groupValue = newValue!),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: _myRadioButton(
                                title: "Couple",
                                value: 3,
                                onChanged: (newValue) =>
                                    state(() => _groupValue = newValue!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            child: rowDetail(
              "Adult",
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(CreateClientDetailName.route),
            child: rowDetail("Name"),
          ),
          Divider(),
          Text(
            'Contact Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(Phone.route),
            child: rowDetail("Add Phone"),
          ),
          SizedBox(
            height: 5,
          ),
          rowDetail("Add Email"),
          Divider(),
          InkWell(
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
                      height: MediaQuery.of(context).size.height * .30,
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choose Clinician",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 16.0),
                              child: Text(
                                "Poorna Bhattacharya",
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, left: 16.0),
                              child: Text(
                                "Anal Patel",
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            child: rowDetail("Administrative"),
          ),
        ],
      ),
    );
  }

  Widget _myRadioButton(
      {String? title, int? value, void Function(int?)? onChanged}) {
    return RadioListTile<int>(
      activeColor: Green,
      value: value!,
      groupValue: _groupValue,
      onChanged: onChanged!,
      title: Text(title!),
      selected: false,
    );
  }

  Padding rowDetail(var text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 18.0,
          ),
        ],
      ),
    );
  }
} //class
