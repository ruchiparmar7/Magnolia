import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/services.dart';
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/NavigationDrawer/Drawer.dart';

// TODO : Remaining location,clinican & alert.
class CreateEvent extends StatefulWidget {
  static String route = "CreateEvent";
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TimeOfDay? _time;
  DateTime? _currentDate;

  List<String> _durationHM = ['H', 'M'];

  String? _selectedDuration;

  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.now();
    _currentDate = DateTime.now();
    _selectedDuration = _durationHM[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _currentDate!,
        firstDate: DateTime(_currentDate!.year),
        lastDate: DateTime(_currentDate!.year + 100));
    if (pickedDate != null && pickedDate != _currentDate)
      setState(() {
        _currentDate = pickedDate;
      });
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _time!,
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.indigo,
            accentColor: Colors.indigo,
            //colors schema = button , selected value color
            colorScheme: ColorScheme.light(primary: Green),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (time != null)
      setState(() {
        _time = time;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Client"),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Text("choose"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                  child: Column(
                    children: [
                      funRow("Location", "Unassigned",
                          leftImg: Icon(
                            Icons.circle,
                            size: 23.0,
                          ),
                          rightImg: Icon(
                            Icons.arrow_forward_ios,
                            size: 15.0,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      funRow("Clinician", "XYZ",
                          leftImg: Icon(
                            Icons.people,
                            size: 23.0,
                          ),
                          rightImg: Icon(
                            Icons.arrow_forward_ios,
                            size: 15.0,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("All Day")
                            ],
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: new Switch(
                              value: true,
                              onChanged: (bool value1) {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(color: Colors.black),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.grey[200],
                          child: funRow("Date",
                              "${_currentDate!.day}-${_currentDate!.month}-${_currentDate!.year}",
                              leftImg: Icon(
                                Icons.timer,
                                size: 23.0,
                              ),
                              rightImg: Icon(
                                Icons.arrow_forward_ios,
                                size: 15.0,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () => _pickTime(context),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.grey[200],
                          child: funRow("Time", "${_time!.format(context)}",
                              leftImg: Icon(
                                Icons.timer,
                                size: 23.0,
                              ),
                              rightImg: Icon(
                                Icons.arrow_forward_ios,
                                size: 15.0,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // funRow(
                      //   "Duration",
                      //   "50 minutes",
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 23.0,
                              ),
                              Text("Duration"),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .10,
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'),
                                    ),
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              DropdownButton(
                                value: _selectedDuration,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedDuration = newValue;
                                  });
                                },
                                items: _durationHM.map((hm) {
                                  return DropdownMenuItem(
                                    child: new Text(hm),
                                    value: hm,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(color: Colors.black),
                      SizedBox(
                        height: 10.0,
                      ),
                      funRow("Repeat", "Never",
                          leftImg: Icon(
                            Icons.sync,
                            size: 23.0,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                  child: Column(children: [
                    funRow(
                      "Alert",
                      "Choose",
                      leftImg: Icon(
                        Icons.alarm,
                        size: 23.0,
                      ),
                      rightImg: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    funRow("Billing", "\$0"),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget funRow(var leftText, var rightText, {Icon? leftImg, Icon? rightImg}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            leftImg ??
                Container(
                  width: 23.0,
                ),
            SizedBox(
              width: 5.0,
            ),
            Text(leftText)
          ],
        ),
        Row(
          children: [
            Text(rightText),
            SizedBox(
              width: 5.0,
            ),
            rightImg ??
                Container(
                  width: 23.0,
                ),
          ],
        )
      ],
    );
  }
}
