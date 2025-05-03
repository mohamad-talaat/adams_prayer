import 'package:flutter/material.dart';
import 'video_list_screen.dart'; // استيراد صفحة قائمة الفيديوهات

class AblutionScreen extends StatelessWidget {
  const AblutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الوضوء'),
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
                MaterialPageRoute(builder: (context) => const VideoListScreen()), // الانتقال إلى صفحة الفيديوهات
              );
            },
            child: const Text('تعلم'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // إضافة وظيفة لتتبع الوضوء
            },
            child: const Text('تتبع'),
          ),
        ],
      ),
    );
  }
}