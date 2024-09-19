// widgets/calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';

class CalendarWidget extends StatelessWidget {
  final List<Event> events;
  final Function(DateTime, DateTime, DateTime) onDaySelected;

  const CalendarWidget({
    super.key,
    required this.events,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      eventLoader: (day) {
        return events.where((event) => isSameDay(event.date, day)).toList();
      },
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        // Invoke the callback passed from parent
        onDaySelected(selectedDay, focusedDay, selectedDay);
      },
      calendarStyle: CalendarStyle(
        markersMaxCount: 1,
        markerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}