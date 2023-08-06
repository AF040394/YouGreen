import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yougreen/global.dart' as global;

class household extends StatefulWidget {
  const household({super.key});

  @override
  State<household> createState() => _householdState();
}

//this is the class for displaying the leaderboard of the household
class _householdState extends State<household> {
  //hold name of cristina
  var displayNameCristina = '';
  //hold household name of cristina
  var displayHouseholdCristina = '';
  //hold the score of cristina
  var displayCoinsCristina = '';
  //hold andrea name
  var displayNameAndrea = '';
  //hold household name
  var displayHouseholdAndrea = '';
  //hold andrea score
  var displayCoinsAndrea = '';
  //create a db reference to retrieve data at child household
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('household/');
//create a state to retrieve all usefuol information from db before the widget build
  @override
  initState() {
    super.initState();

    getDataCristinaTitle();
    getDataCristinaHousehold();
    getDataCristinaCoins();
    getDataAndreaTitle();
    getDataAndreaHousehold();
    getDataAndreaCoins();
  }

//get cristina name from db
  void getDataCristinaTitle() {
    ref
        .child('member/')
        .child('-NRTHNO6uk0biTXWTTtF')
        .child('name')
        .onValue
        .listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayNameCristina = '$name';
      });
    });
  }

//get cristina household from db
  void getDataCristinaHousehold() {
    ref
        .child('member/')
        .child('-NRTHNO6uk0biTXWTTtF')
        .child('household')
        .onValue
        .listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayHouseholdCristina = '$name';
      });
    });
  }

//get critina score from db
  void getDataCristinaCoins() {
    ref
        .child('member/')
        .child('-NRTHNO6uk0biTXWTTtF')
        .child('score')
        .onValue
        .listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayCoinsCristina = '$name';
      });
    });
  }

//get andrea name from db
  void getDataAndreaTitle() {
    ref
        .child('member/')
        .child('-NRTGkBQcri0cYDRQa0C')
        .child('name')
        .onValue
        .listen((event) {
      final nameA = event.snapshot.value;
      setState(() {
        displayNameAndrea = '$nameA';
      });
    });
  }

//get andrea household from db
  void getDataAndreaHousehold() {
    ref
        .child('member/')
        .child('-NRTGkBQcri0cYDRQa0C')
        .child('household')
        .onValue
        .listen((event) {
      final houseA = event.snapshot.value;
      setState(() {
        displayHouseholdAndrea = '$houseA';
      });
    });
  }

//get andrea score
  void getDataAndreaCoins() {
    ref
        .child('member/')
        .child('-NRTGkBQcri0cYDRQa0C')
        .child('score')
        .onValue
        .listen((event) {
      final scoreA = event.snapshot.value;
      setState(() {
        displayCoinsAndrea = '$scoreA';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 22, 115, 27),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 22, 115, 27),
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "YOUGREEN",
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 20,
              letterSpacing: 3.0,
              color: Colors.white,
            ),
          ),
        ),
        //create a list view
        body: ListView(children: [
          Center(
              child: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //create a data table
              DataTable(columns: [
                //set datatable top columns for NAME, HOUSEHOLD AND SCORE
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Household',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Score',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ], //implement first row with cristina informations
                  rows: [
                    DataRow(cells: [
                      //display critina name
                      DataCell(Text(displayNameCristina,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ))),
                      //display cristina household
                      DataCell(Text(displayHouseholdCristina,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ))),
                      //display cristina score
                      DataCell(Text(displayCoinsCristina,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          )))
                    ]),
                    //create another row for andrea values
                    DataRow(cells: [
                      //display andrea name
                      DataCell(Text(displayNameAndrea,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ))),
                      //display andrea household
                      DataCell(Text(displayHouseholdAndrea,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ))),
                      //dispplay andrea score
                      DataCell(Text(displayCoinsAndrea,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          )))
                    ]),
                  ])
            ],
          ))),
        ]));
  }
}
