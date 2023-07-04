
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TimeOfTheDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = 7;

  @override
  TimeOfDay read(BinaryReader reader) {
    int hour = reader.read();
    int min = reader.read();
    return TimeOfDay(hour: hour, minute: min);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.write(obj.hour);
    writer.write(obj.minute);
  }
}