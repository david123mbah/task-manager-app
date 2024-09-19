import 'package:flutter/material.dart';


class WeatherItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const WeatherItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(label),
      ],
    );
  }
}