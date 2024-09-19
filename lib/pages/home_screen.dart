import 'package:animeop/widgets/eventlist_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/providers/event_provider.dart';
import 'Task_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(' Time Table ,'),
            
          ),
          body: Column(
            children: [
              Container(),
              const SizedBox(height: 30),
              
              Expanded(
                child: ListView.builder(
                  itemCount: eventProvider.eventsForSelectedDay.length,
                  itemBuilder: (context, index) {
                    final event = eventProvider.eventsForSelectedDay[index];

                    // Wrap the EventListTile with Dismissible for swipe-to-delete functionality
                    return Dismissible(
                      key: Key(event.hashCode.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        eventProvider.deleteEvent(event);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${event.title} deleted')));
                      },
                      child: EventListTile(
                          event: event), // Pass the event including color
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventsScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
