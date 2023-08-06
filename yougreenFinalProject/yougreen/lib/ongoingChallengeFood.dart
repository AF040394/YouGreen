import 'package:yougreen/event.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yougreen/global.dart' as global;

class CalendarFood extends StatefulWidget {
  @override
  _CalendarFoodState createState() => _CalendarFoodState();
}

class _CalendarFoodState extends State<CalendarFood> {
  //get the selected event data
  late Map<DateTime, List<Note>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  bool checked = false;
  //hold user score
  var coins = '';
  //get value of the of the action
  var counter = 0;
  //hold the total score
  int totalScore = 0;
  TextEditingController _eventController = TextEditingController();
  //create db reference
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('household/');

  //create an initial state to get score from db and calendar
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    getScore();
  }

  List<Note> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

//get the score from db
  void getScore() {
    ref
        .child('member/')
        .child(global.globalKey)
        .child('score')
        .onValue
        .listen((event) {
      final score = event.snapshot.value;
      setState(() {
        coins = "$score";
      });
    });
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Note event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      //create a button to open the alert dialog
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Completion"),
            actions: [
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "100 coins:  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("No water bottle"),
                      ],
                    ),
                    value: checked,
                    onChanged: (bool? val) {
                      setState(() {
                        counter += 100;
                        var temp = int.parse(coins);
                        //get total score from counter and user score
                        totalScore = counter + temp;
                        checked = !checked;
                        //upload total score in the db
                        ref
                            .child('member')
                            .child(global.globalKey)
                            .update({'score': totalScore.toString()});
                      });
                    }),
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Note(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Note(title: _eventController.text)
                      ];
                    }
                  }
                  //once the ok button is pressed return context(calendar)
                  Navigator.pop(context);
                  _eventController.clear();
                  checked = false;
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
