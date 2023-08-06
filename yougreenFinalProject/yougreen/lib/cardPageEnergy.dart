import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yougreen/card.dart';

import 'package:yougreen/ongoingChallengeEnergy.dart';

class CardPageEnergy extends StatefulWidget {
  const CardPageEnergy({super.key});

  @override
  State<CardPageEnergy> createState() => _CardPageEnergy();
}

class _CardPageEnergy extends State<CardPageEnergy> {
  //store title from card
  var displayTitle = '';
  //store subtititle from card
  var displaySubtitle = '';
  //store description from card
  var descriptionCard = '';
  //store value of coins
  var coins = '';
//get database reference
  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('card/Energy');
  //set the obj values
  var obj = CardType(
      title: 'Email',
      subtitle: 'CO2e 100g',
      description:
          'An email can generate 100g of C02e, and most of the time we waste this energy for emails\n that we do not need.\n\n  to remove emails from your inbox and unsuscribe to newsletters that you do not use. Every email and newsletter you remove you will save more than 100CO2e per email!',
      energy: true,
      transport: false,
      food: false,
      coins: '10');

  @override
  initState() {
    super.initState();
    write();
    getDataTitle();
    getDataSubtitle();
    getDataDescription();
  }

//write the obj values in the db
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

//get the title from the db
  void getDataTitle() {
    ref.child('title').onValue.listen((event) {
      final name = event.snapshot.value;
      setState(() {
        displayTitle = '$name';
      });
    });
  }

//get subtitle from db
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
      //display the title of the page with Appbar widget
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
              //the three parameters are the asset image, the title of the card from db and the subtitle card from db
              buildCard('assets/email.png', displayTitle, displaySubtitle),
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
              //button for accepting the challenge and move to Ongoing challenge
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
                  //move to the calendar energy page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Calendar()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

//create the card widget that will get 4
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
