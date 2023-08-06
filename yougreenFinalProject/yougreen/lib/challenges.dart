import 'package:flutter/material.dart';
import 'package:yougreen/CardPageFood.dart';
import 'package:yougreen/cardPageEnergy.dart';
import 'package:yougreen/cardPageTransport.dart';

class Challenges extends StatelessWidget {
  const Challenges({super.key});
//this is the page where the user can choose the challenge type
// the challenges are energy, transport and food
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Color.fromARGB(255, 22, 115, 27),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            //this is the button to go to the card page energy
            child: ElevatedButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardPageEnergy()));
              }),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[900],
                  minimumSize: Size(400, 100),
                  surfaceTintColor: Colors.white),
              child: Text(
                'Energy',
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
            height: 30.0,
          ),
          Center(
            //this is the button to go to the card food page
            child: ElevatedButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardPageFood()));
              }),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[900],
                  minimumSize: Size(400, 100),
                  surfaceTintColor: Colors.white),
              child: Text(
                'Food',
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
            height: 30.0,
          ),
          Center(
            //this is the button to link the card page transport
            child: ElevatedButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardPageTransport()));
              }),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[900],
                  minimumSize: Size(400, 100),
                  surfaceTintColor: Colors.white),
              child: Text(
                'Transport',
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
            height: 30.0,
          ),
          Center(
            //this button is intended to show another link to the ongoing challenge of the user, but has not been implemented
            //it serves just as a proof of concept
            child: ElevatedButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Challenges()));
              }),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[900],
                  minimumSize: Size(400, 100),
                  surfaceTintColor: Colors.white),
              child: Text(
                'Ongoing Challenge',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  letterSpacing: 3.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
