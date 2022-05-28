import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homily/model/calendarEvent.dart';
import 'package:homily/screens/calendarPage/addEventPage.dart';
import 'package:homily/service/currentUser.dart';
import 'package:homily/service/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({Key? key}) : super(key: key);

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  CalendarController? _calendarController;
  Map<DateTime, List<dynamic>>? _events;
  List<dynamic>? _selectedEvents;
  TextEditingController? _eventController;
  SharedPreferences? prefs;

  Future<List?> _getCalendarEvents() async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    List? _calendarEvent = await OurDatabase()
        .getCalendarEvents(_currentUser.getCurrentUser.groupId!);
    print(_calendarEvent);
  }

  Future<List?> _getEvent() async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CalendarEvent _calendarEvent =
        await OurDatabase().getEvent(_currentUser.getCurrentUser.groupId!);
    print(_calendarEvent);
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs?.getString("events") ?? '{}')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H O M I L Y'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              calendarController: _calendarController,
              headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
              ),
              onDaySelected: (date, events, _) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            ..._selectedEvents!.map(
              (event) => ListTile(
                title: Text(event),
              ),
            ),
            ElevatedButton(onPressed: () => _getEvent(), child: Text("PRINT"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEventPage()),
        ),
      ),
    );
  }
}
