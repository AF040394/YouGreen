import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

//card class
class CardType {
  final String title;
  final String subtitle;
  final String description;
  final bool energy;
  final bool transport;
  final bool food;
  final String coins;
  // ignore: deprecated_member_use

  CardType(
      {required this.title,
      required this.subtitle,
      required this.description,
      required this.energy,
      required this.transport,
      required this.food,
      required this.coins});
}
