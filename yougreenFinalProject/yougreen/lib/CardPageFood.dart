import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yougreen/card.dart';

import 'package:yougreen/ongoingChallengeFood.dart';

class CardPageFood extends StatefulWidget {
  const CardPageFood({super.key});

  @override
  State<CardPageFood> createState() => _CardPageFood();
}

class _CardPageFood extends State<CardPageFood> {
  //store the title of the card
  var displayTitle = '';
  //store the subtitle of the card
  var displaySubtitle = '';
  //store derscription
  var descriptionCard = '';

  //create a db reference at the child card/food
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('card/Food');
  //call the obj card to set the values
  var obj = CardType(
      title: 'Bottle of Water',
      subtitle: 'CO2e 215g',
      description:
          "A bottle a day would add upto 0.6 per cent of the 10-tonne lifestyle.\n Try to don't buy any bottle of water, and use a personal reusable water bottle to stay hydrated ",
      energy: false,
      transport: false,
      food: true,
      coins: '20');
//init the state to call this methods before the widget build
  @override
  initState() {
    super.initState();
    //write the items in db
    write();
    //get data from db
    getDataTitle();
    //get subtitle from db
    getDataSubtitle();
    getDataDescription();
  }

//set the obj values and write them in db
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

//get the card title
  void getDataTitle() {
    ref.child('title').onValue.listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayTitle = '$name';
      });
    });
  }

//get the card subtitle
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
              buildCard('assets/bott.png', displayTitle, displaySubtitle),
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
              //create a widget button to go to the calendar food page
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
                  //connection to the calendar food page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CalendarFood()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

//create the card widget with all the feautures needed
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
