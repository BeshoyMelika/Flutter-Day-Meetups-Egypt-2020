
import 'package:flutter/material.dart';

class Task{
  String title;
  DateTime date;
  bool status;
  Task({this.date, this.title, this.status = false});
}