import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yougreen/challenges.dart';
import 'package:yougreen/householdScore.dart';
import 'package:yougreen/global.dart' as global;

//create a stateful  widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //holds the name value from the database
  var displayText = '';
  //holds the score value from the database
  var coins = '';
  //db reference
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              "https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref('household/');
  //create a state to call the 2 methods to retrieve data from db
  @override
  initState() {
    super.initState();

    getDataName();
    getScore();
  }

//get snapshot from db and get the value name
  void getDataName() {
    ref
        .child('member/')
        .child(global.globalKey)
        .child('name')
        .onValue
        .listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayText = '$name';
      });
    });
  }

//get snapshot of db and get score value
  void getScore() {
    ref
        .child('member/')
        .child(global.globalKey)
        .child('score')
        .onValue
        .listen((event) {
      final score = event.snapshot.value;
      setState(() {
        coins = '$score';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 22, 115, 27),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  height: 40.0,
                ),
                //create a row widget to insert avatar image, name and score
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/aru2.png',
                        ),
                        radius: 50,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text(
                          ' Hi ' + displayText,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 70,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.energy_savings_leaf,
                              size: 20,
                              color: Colors.white,
                            ),
                            Text(coins),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    color: Colors.white,
                    height: 200,
                    width: 300,
                    child: Center(
                      //retrieve the image from the asset folder
                      //dependencies changed in pubspec to retrieve image

                      child: Image.asset('assets/graph.png',
                          width: 250.0, height: 250.0),
                    ),
                  ),
                ),
                Divider(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.facebook_rounded, size: 60, color: Colors.white),
                    Icon(Icons.snapchat, size: 60, color: Colors.white),
                    Icon(Icons.whatsapp, size: 60, color: Colors.white),
                  ],
                ),
                Divider(
                  height: 30.0,
                ),
                //display the button widget to access the household leaderboard or the challenges page.
                Center(
                  //challenges button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Challenges()));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(400, 50),
                        primary: Colors.green[900],
                        surfaceTintColor: Colors.white),
                    child: Text(
                      'Challenges',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        letterSpacing: 3.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                Center(
                  //household button
                  child: ElevatedButton(
                    onPressed: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => household()));
                    }),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                        minimumSize: Size(400, 50),
                        surfaceTintColor: Colors.white),
                    child: Text(
                      'Household',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        letterSpacing: 3.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
