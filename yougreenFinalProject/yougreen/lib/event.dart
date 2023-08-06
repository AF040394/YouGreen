import 'package:flutter/foundation.dart';

//this is a class for creating a note in the calendar
class Note {
  final String title;
  Note({required this.title});
  String toString() => this.title;
}
