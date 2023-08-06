import 'package:flutter/material.dart';
import 'package:yougreen/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //initialize the database before the app runs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    //call the login page
    home: LogIn(),
  ));
}
