import 'package:flutter/material.dart';
import '../models/event.dart';

class EventListTile extends StatelessWidget {
  final Event event;

  const EventListTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: event.color.withOpacity(0.2), 
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Title
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Event Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.deepPurpleAccent),
                const SizedBox(width: 8),
                Text(
                  'Date: ${event.date.toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Event Start Time
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.deepPurpleAccent),
                const SizedBox(width: 8),
                Text(
                  'Start: ${event.startTime.format(context)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Event End Time
            Row(
              children: [
                const Icon(Icons.access_time_filled, size: 16, color: Colors.deepPurpleAccent),
                const SizedBox(width: 8),
                Text(
                  'End: ${event.endTime.format(context)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Event Location
            if (event.location.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.location_pin, size: 16, color: Colors.deepPurpleAccent),
                  const SizedBox(width: 8),
                  Text(
                    'Location: ${event.location}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

            // Other event fields (participants, notes, etc.)
            const SizedBox(height: 8),
            if (event.notes.isNotEmpty)
              Text(
                'Notes: ${event.notes}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
