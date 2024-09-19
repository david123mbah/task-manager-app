import 'package:animeop/models/event.dart';
import 'package:flutter/material.dart';


// providers/event_provider.dart
import 'package:flutter/foundation.dart';
import 'package:table_calendar/table_calendar.dart';

class EventProvider with ChangeNotifier {
  final List<Event> _events = [];
  DateTime _selectedDay = DateTime.now();

  List<Event> get events => _events;
  DateTime get selectedDay => _selectedDay;

  List<Event> get eventsForSelectedDay {
    return _events.where((event) => isSameDay(event.date, _selectedDay)).toList();
  }
  // add an event 
  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
  // add event date 
  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

   // New delete event method
  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime day) {
    return _events.where((event) => isSameDay(event.date, day)).toList();
  }
}


