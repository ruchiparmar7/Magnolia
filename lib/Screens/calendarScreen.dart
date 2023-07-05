import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Custom/Color.dart';
import 'package:magnolia/NavigationDrawer/Drawer.dart';
import 'package:magnolia/model/CalendarModel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// TODO: UI syncfusion package part need to add
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime now = new DateTime.now();

  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting('Conference', startTime.add(const Duration(hours: 3)),
        endTime.add(const Duration(hours: 3)), const Color(0xFF0F8644), false));
    meetings.add(Meeting('Conference', startTime.add(const Duration(hours: 5)),
        endTime.add(const Duration(hours: 5)), const Color(0xFF0F8644), false));
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Container(
          child: SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime(now.year, now.month, now.day),
            monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              showAgenda: true,
            ),
            dataSource: MeetingDataSource(_getDataSource()),
            selectionDecoration: BoxDecoration(
              color: Green.withOpacity(.2),
              border: Border.all(color: Green, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              shape: BoxShape.rectangle,
            ),
            todayHighlightColor: Colors.red,
            showNavigationArrow: true,
            cellEndPadding: 5,
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
