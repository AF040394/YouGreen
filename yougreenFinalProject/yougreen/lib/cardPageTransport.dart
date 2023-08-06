import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yougreen/card.dart';

import 'package:yougreen/ongoingChallengeTransport.dart';

class CardPageTransport extends StatefulWidget {
  const CardPageTransport({super.key});

  @override
  State<CardPageTransport> createState() => _CardPageTransport();
}

class _CardPageTransport extends State<CardPageTransport> {
  //hold title of the card
  var displayTitle = '';
  //hold subtitle of the card
  var displaySubtitle = '';
  //store description card
  var descriptionCard = '';
  //create a database connection at the child card/ transport
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('card/Transport');
  //call the card obj and set the values
  var obj = CardType(
      title: 'Car Usage',
      subtitle: 'CO2e 750g per mile',
      description:
          "So driving a car the average annual distance of 9000 miles would use between 3 and 20 per cent of the 10-tonne lifestyle, depending on the type of the car and how you drive it.\n Try to not use your car when you can walk or use public transports ",
      energy: true,
      transport: false,
      food: false,
      coins: '50');
//create a state before the widget build to write and get data from db
  @override
  initState() {
    super.initState();
    write();
    getDataTitle();
    getDataSubtitle();
    getDataDescription();
  }

//method to write data to db
  void write() {
    setState(() {
      ref.set({
        "title": obj.title,
        "subtitle": obj.subtitle,
        "description": obj.description,
        "energy": obj.energy,
        "transport": obj.transport,
        "food": obj.food,
        "coins": obj.coins
      });
    });
  }

//get data title from database
  void getDataTitle() {
    ref.child('title').onValue.listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayTitle = '$name';
      });
    });
  }
  //get data subtitle from db

  void getDataSubtitle() {
    ref.child('subtitle').onValue.listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displaySubtitle = '$name';
      });
    });
  }

  //get subtitle from db
  void getDataDescription() {
    ref.child('description').onValue.listen((event) {
      final name = event.snapshot.value;
      setState(() {
        descriptionCard = '$name';
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
          "CHALLENGES",
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 20,
            letterSpacing: 3.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.0, 40.0, 30.0, 0.0),
          child: Column(
            children: [
              //call the buildcard widget
              buildCard('assets/car.png', displayTitle, displaySubtitle),
              Container(
                width: 300,
                height: 200,
                color: Colors.white,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(descriptionCard)),
              ),
              Divider(
                height: 25,
              ),
              //create a button widget for connecting the calendar transport page
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[900],
                    minimumSize: Size(400, 50),
                    surfaceTintColor: Colors.white),
                child: Text(
                  'Challenge Accepted',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    letterSpacing: 3.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: (() {
                  //connection to calendar transport
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarTransport()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

//create a widget to build the card
  Widget buildCard(name, text, text2) => Container(
        width: 300,
        height: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              name,
              width: 100.0,
              height: 100.0,
            ),
            Divider(height: 15.0),
            Text(text),
            Divider(height: 15.0),
            Text(text2),
          ],
        ),
      );
}
