import 'package:flutter/material.dart';
//import 'video_list_screen.dart'; // استيراد صفحة قائمة الفيديوهات
import 'prayer_detail_screen.dart';
class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الصلاة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'اختر الصلاة:',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          PrayerButton(prayerName: 'الفجر', context: context),
          PrayerButton(prayerName: 'الظهر', context: context),
          PrayerButton(prayerName: 'العصر', context: context),
          PrayerButton(prayerName: 'المغرب', context: context),
          PrayerButton(prayerName: 'العشاء', context: context),
        ],
      ),
    );
  }
}

class PrayerButton extends StatelessWidget {
  final String prayerName;
  final BuildContext context;

  const PrayerButton({super.key, required this.prayerName, required this.context});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          this.context,
          MaterialPageRoute(
            builder: (context) => PrayerDetailScreen(prayerName: prayerName),
          ),
        );
      },
      child: Text(prayerName),
    );
  }
}