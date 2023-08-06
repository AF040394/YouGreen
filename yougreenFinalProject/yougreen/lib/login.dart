import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yougreen/homepage.dart';
import 'package:yougreen/global.dart' as global;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Map uniqueIdMap = new Map<String, dynamic>();
  TextEditingController _name = TextEditingController();
  TextEditingController _household = TextEditingController();

  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              'https://yougreeb-512a6-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('household/');

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 22, 115, 27),
        //appbar widget for the top of the screen
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: Column(children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/aru2.png',
                ),
                radius: 50,
              ),
              Divider(
                height: 40.0,
              ),
              //textfield to insert name
              Center(
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name',
                      hintText: 'Enter Your Name'),
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Center(
                //textfield to insert household nickname
                child: TextField(
                  controller: _household,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter household nickname',
                      hintText: 'Enter household nickname'),
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (() async {
                    //save name from text field
                    var name = _name.text;
                    //create a database event and get the child member
                    DatabaseEvent event = await ref.child('member').once();

                    //this is a the map version of the snapshot
                    final mapDb = new Map<String, dynamic>.from(
                        event.snapshot.value as Map<dynamic, dynamic>);
                    mapDb.forEach((key, value) {
                      //key contains all the keys of the children nodes of memeber
                      print(key);
                      //store the key in a temporary file to save in case the condition is true
                      var temp = key;
                      //uniqueIdMap will map the entries of each key, Identifying the key values name,
                      //household and score and the new values corresponding to each key
                      uniqueIdMap = new Map<String, dynamic>.from(
                          value as Map<dynamic, dynamic>);
                      uniqueIdMap.forEach((key, value) {
                        if (value == name) {
                          // save the ID of the user in a global variable
                          //it will be used as child reference for the code
                          global.globalKey = temp;
                        }
                      });
                    });
                    //connection to the homepage
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green[900],
                      minimumSize: Size(400, 50),
                      surfaceTintColor: Colors.white),
                  child: Text(
                    'Log In',
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
          ),
        ));
  }
}
