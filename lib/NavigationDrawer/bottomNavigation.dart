import 'package:flutter/material.dart' hide Badge;
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/Screens/calendarScreen.dart';
import 'package:magnolia/Screens/clientScreen.dart';
import 'package:magnolia/Screens/createAppointment.dart';
import 'package:magnolia/Screens/createClient.dart';
import 'package:magnolia/Screens/createEvent.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  static String route = "CustomBottomNavigationBar";
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int? currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    CalendarScreen(),
    ClientScreen(),
    Text("3"),
    Text("4"),
  ];

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
            Navigator.of(context).pushNamed(CreateEvent.route);
          },
          label: 'Create Event',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Green,
        ),
        SpeedDialChild(
          child: Icon(Icons.laptop_chromebook, color: Colors.white),
          backgroundColor: Green,
          onTap: () {
            Navigator.of(context).pushNamed(CreateClient.route);
          },
          label: 'Create Client',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(currentIndex!),
      floatingActionButton: buildSpeedDial(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        //hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Green,
              icon: Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.calendar_today_outlined,
                color: Green,
              ),
              title: Text("Calendar")),
          BubbleBottomBarItem(
              backgroundColor: Green,
              icon: Icon(
                Icons.people,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.people_alt_outlined,
                color: Green,
              ),
              title: Text("Clients")),
          BubbleBottomBarItem(
              backgroundColor: Green,
              icon: Icon(
                Icons.check_box_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.check_box_outlined,
                color: Green,
              ),
              title: Text("Reminder")),
          BubbleBottomBarItem(
              backgroundColor: Green,
              icon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.message_rounded,
                color: Green,
              ),
              title: Text("Messages"))
        ],
      ),
    );
  }
}
