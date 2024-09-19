import 'package:flutter/material.dart';


// models/event.dart

class Event {
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isAllDay;
  final String repeat;
  final List<String> tags;
  final List<String> participants;
  final String location;
  final Color color;
  final Duration notifyBefore;
  final String notes;

  Event({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.repeat = 'Never',
    this.tags = const [],
    this.participants = const [],
    this.location = '',
    required this.color,
    this.notifyBefore = const Duration(minutes: 30),
    this.notes = '',
  });
}