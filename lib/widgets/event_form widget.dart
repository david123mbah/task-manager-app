import 'package:animeop/models/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';

class EventFormWidget extends StatefulWidget {
  const EventFormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EventFormWidgetState createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends State<EventFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date = DateTime.now();
  late TimeOfDay _startTime = TimeOfDay.now();
  late TimeOfDay _endTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
  bool _isAllDay = false;
  String _repeat = 'Never';
  final List<String> _tags = [];
  final List<String> _participants = [];
  String _location = '';
  Duration _notifyBefore = const Duration(minutes: 30);
  String _notes = '';
  String _importance = 'Medium'; // Default importance level
  final List<String> _importanceOptions = ['Low', 'Medium', 'High'];
  final Map<String, Color> _importanceColors = {
    'Low': Colors.green,
    'Medium': Colors.yellow,
    'High': Colors.red,
  };

  final List<String> _repeatOptions = ['Never', 'Daily', 'Weekly', 'Monthly'];
  final List<String> _notifyBeforeOptions = [
    'None', '5 minutes', '10 minutes', '30 minutes', '1 hour', '1 day'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newEvent = Event(
        title: _title,
        date: _date,
        startTime: _startTime,
        endTime: _endTime,
        isAllDay: _isAllDay,
        repeat: _repeat,
        tags: _tags,
        participants: _participants,
        location: _location,
        notifyBefore: _notifyBefore,
        notes: _notes,
        color: _importanceColors[_importance]!,
      );
      Provider.of<EventProvider>(context, listen: false).addEvent(newEvent);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event added successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitleField(),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 16),
              _buildAllDayCheckbox(),
              const SizedBox(height: 16),
              _buildStartTimePicker(),
              const SizedBox(height: 16),
              _buildEndTimePicker(),
              const SizedBox(height: 20),
              _buildRepeatDropdown(),
              const SizedBox(height: 16),
              _buildLocationField(),
              const SizedBox(height: 16),
              _buildNotifyBeforeDropdown(),
              const SizedBox(height: 16),
              _buildImportanceDropdown(),
              const SizedBox(height: 16),
              _buildNotesField(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Event Title',
        labelStyle: const TextStyle(
          color: Colors.deepPurpleAccent,
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
      onSaved: (value) => _title = value!,
    );
  }

  ListTile _buildDatePicker() {
    return ListTile(
      title: Text('Event Date: ${_date.toLocal().toString().split(' ')[0]}', style: const TextStyle(fontSize: 16)),
      leading: const Icon(Icons.calendar_today, color: Colors.deepPurpleAccent),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          setState(() {
            _date = pickedDate;
          });
        }
      },
    );
  }

  CheckboxListTile _buildAllDayCheckbox() {
    return CheckboxListTile(
      title: const Text('All-Day Event'),
      value: _isAllDay,
      onChanged: (value) {
        setState(() {
          _isAllDay = value!;
        });
      },
    );
  }

  ListTile _buildStartTimePicker() {
    return ListTile(
      title: Text('Start Time: ${_startTime.format(context)}', style: const TextStyle(fontSize: 16)),
      leading: const Icon(Icons.access_time, color: Colors.deepPurpleAccent),
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: _startTime,
        );
        if (pickedTime != null) {
          setState(() {
            _startTime = pickedTime;
          });
        }
      },
    );
  }

  ListTile _buildEndTimePicker() {
    return ListTile(
      title: Text('End Time: ${_endTime.format(context)}', style: const TextStyle(fontSize: 16)),
      leading: const Icon(Icons.access_time_filled, color: Colors.deepPurpleAccent),
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: _endTime,
        );
        if (pickedTime != null) {
          setState(() {
            _endTime = pickedTime;
          });
        }
      },
    );
  }

  DropdownButtonFormField<String> _buildRepeatDropdown() {
    return DropdownButtonFormField<String>(
      value: _repeat,
      decoration: const InputDecoration(labelText: 'Repeat'),
      items: _repeatOptions.map((repeatOption) {
        return DropdownMenuItem(
          value: repeatOption,
          child: Text(repeatOption),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _repeat = value!;
        });
      },
    );
  }

  TextFormField _buildLocationField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Location',
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => _location = value!,
    );
  }

  DropdownButtonFormField<String> _buildNotifyBeforeDropdown() {
    return DropdownButtonFormField<String>(
      value: _notifyBeforeOptions.firstWhere((element) => element == '30 minutes'),
      decoration: const InputDecoration(labelText: 'Notify Before'),
      items: _notifyBeforeOptions.map((notifyOption) {
        return DropdownMenuItem(
          value: notifyOption,
          child: Text(notifyOption),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _notifyBefore = Duration(minutes: int.parse(value!.split(' ')[0]));
        });
      },
    );
  }

  DropdownButtonFormField<String> _buildImportanceDropdown() {
    return DropdownButtonFormField<String>(
      value: _importance,
      decoration: const InputDecoration(labelText: 'Importance'),
      items: _importanceOptions.map((importanceOption) {
        return DropdownMenuItem(
          value: importanceOption,
          child: Text(importanceOption),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _importance = value!;
        });
      },
    );
  }

  TextFormField _buildNotesField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Notes',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onSaved: (value) => _notes = value!,
    );
  }

  ElevatedButton _buildSubmitButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: const Text('Save Event', style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: _submitForm,
    );
  }
}
