import 'package:animeop/widgets/event_form%20widget.dart';
import 'package:flutter/material.dart';


class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task ')),
      body: const EventFormWidget(),
    );
  }
}
