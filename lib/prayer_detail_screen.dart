import 'package:flutter/material.dart';
import 'prayer_video_list_screen.dart'; // استيراد صفحة الفيديوهات الجديدة

class PrayerDetailScreen extends StatelessWidget {
  final String prayerName;

  const PrayerDetailScreen({super.key, required this.prayerName}); // إضافة super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$prayerName - تفاصيل'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'اختر ما تريد:',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrayerVideoListScreen(prayerName: prayerName)), // الانتقال إلى صفحة الفيديوهات الجديدة
              );
            },
            child: const Text('تعلم'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // إضافة وظيفة لتتبع الصلاة
            },
            child: const Text('تتبع'),
          ),
        ],
      ),
    );
  }
}