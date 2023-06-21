import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  Event(this.title);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Event>> _events = {
    DateTime(2023, 6, 1): [Event('이벤트 1')],
    DateTime(2023, 6, 5): [Event('이벤트 2')],
    DateTime(2023, 6, 10): [Event('이벤트 3')],
  };

  @override
  Widget build(BuildContext context) {
    final DateTime firstDay = DateTime.now().subtract(Duration(days: 365));
    final DateTime lastDay = DateTime.now().add(Duration(days: 365));
    final DateTime focusedDay = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('달력'),
      ),
      body: TableCalendar<Event>(
        calendarFormat: _calendarFormat,
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
        },
        eventLoader: (day) => _events[day] ?? [],
      ),
    );
  }
}