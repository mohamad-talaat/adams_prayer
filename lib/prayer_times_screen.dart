import 'package:flutter/material.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPrayerButton(context, 'الفجر'),
          _buildPrayerButton(context, 'الظهر'),
          _buildPrayerButton(context, 'العصر'),
          _buildPrayerButton(context, 'المغرب'),
          _buildPrayerButton(context, 'العشاء'),
        ],
      ),
    );
  }

  Widget _buildPrayerButton(BuildContext context, String prayerName) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('وقت صلاة $prayerName')),
        );
      },
      child: Text(prayerName),
    );
  }
}