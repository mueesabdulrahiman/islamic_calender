import 'package:calendar/providers/arab.dart';
import 'package:calendar/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalender extends StatefulWidget {
  @override
  _MainCalenderState createState() => _MainCalenderState();
}

class _MainCalenderState extends State<MainCalender> {
//  CalendarController _calendarController;

  String _arabMonth = "";
  DateTime? _selectedDay;
  DateTime _focusedDaty = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    //  _calendarController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    Provider.of<Data>(context, listen: false).setevent(selectedDate);

    setState(() {
      if (!isSameDay(selectedDate, _selectedDay)) {
        _selectedDay = selectedDate;
        _focusedDaty = focusedDate;
      }
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    var start = HijriCalendar.fromDate(first);
    var end = HijriCalendar.fromDate(last);
    String mn =
        "${start.getLongMonthName()} - ${end.getLongMonthName()} ${end.hYear}";
    Provider.of<Arab>(context, listen: false).setMonth(mn);
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    var start = HijriCalendar.fromDate(first);
    var end = HijriCalendar.fromDate(last);
    String mn =
        "${start.getLongMonthName()} - ${end.getLongMonthName()} ${end.hYear}";
    Provider.of<Arab>(context, listen: false).setMonth(mn);
    Provider.of<Data>(context, listen: false).setevent(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en',
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        // selectedColor: Colors.green,
      ),
      headerStyle: const HeaderStyle(
          headerMargin: EdgeInsets.only(top: 0),
          //centerHeaderTitle: true,
          titleCentered: true),
      focusedDay: _focusedDaty,
      firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      onDaySelected: _onDaySelected,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      // DateTime.now().month.isEven
      //     ? DateTime(DateTime.now().year, DateTime.now().month, 30)
      //     : DateTime(DateTime.now().year, DateTime.now().month, 31),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) => Text(
          "${DateFormat.LLLL().format(day)} ${day.year}",
          textAlign: TextAlign.center,
        ),
        defaultBuilder: (context, date, events) {
          var hDate = HijriCalendar.fromDate(date);
          int dy = hDate.hDay;
          return Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text("${date.day}"),
                Positioned(
                  top: 7,
                  right: 7,
                  child: Text(
                    "$dy",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        selectedBuilder: (context, date, events) {
          var hDate = HijriCalendar.fromDate(date);
          int dy = hDate.hDay;
          return Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(5),
            // padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "${date.day}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Text(
                    "$dy",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        todayBuilder: (context, date, events) {
          var hDate = HijriCalendar.fromDate(date);
          int dy = hDate.hDay;
          return Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(5),
            // padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "${date.day}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Text(
                    "$dy",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
