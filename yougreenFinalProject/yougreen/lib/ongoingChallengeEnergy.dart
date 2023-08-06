import 'package:yougreen/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yougreen/global.dart' as global;

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //save the selected events
  late Map<DateTime, List<Note>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  bool checked = false;
  //create a variabl;e to calculate the total score
  var totalScore = 0;
  //hold score user from db
  var coins = '';
  //counter used to add coins based on the action selected
  var counter = 0;
  TextEditingController _eventController = TextEditingController();
  //database connection
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('household/');

//set an initial state for calendar and to get score from db
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    getScore();
  }

  List<Note> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

//get the score from the user
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
        title: Text("Energy Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //calendar obj
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
      //button to open the alert dialog to insert the action
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
                          "25 coins:  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("5 email removed"),
                      ],
                    ),
                    value: checked,
                    //this is the logic to add the score to the user account in db
                    onChanged: (bool? val) {
                      setState(() {
                        counter += 25;
                        var temp = int.parse(coins);
                        //get the total score
                        totalScore = counter + temp;
                        //check the box
                        checked = !checked;
                        //upload the total score in db
                        ref
                            .child('member')
                            .child(global.globalKey)
                            .update({'score': totalScore.toString()});
                      });
                    }),
              ),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "50 coins:  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("10 email removed"),
                      ],
                    ),
                    value: checked,
                    onChanged: (bool? val) {
                      //this is the logic to add the score to the user account in db
                      setState(() {
                        counter += 50;

                        var temp = int.parse(coins);
                        //get the total score
                        totalScore = counter + temp;
                        //check the box
                        checked = !checked;
                        //upload the total score in db
                        ref
                            .child('member')
                            .child(global.globalKey)
                            .update({'score': counter.toString()});
                      });
                    }),
              ),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "75 coins:  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("15 email removed"),
                      ],
                    ),
                    value: checked,
                    onChanged: (bool? val) {
                      //this is the logic to add the score to the user account in db
                      setState(() {
                        counter += 75;
                        var temp = int.parse(coins);
                        //get the total score
                        totalScore = counter + temp;
                        //check the box
                        checked = !checked;
                        //upload the total score in db
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
                      counter += 50;

                      setState(() {
                        ref
                            .child('member')
                            .child(global.globalKey)
                            .update({'score': totalScore.toString()});
                      });
                    }
                  }
                  //oonce the ok button is pressed, there is a link to the context
                  // to the calendar
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
