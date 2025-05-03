import 'package:flutter/material.dart';
import 'video_player_screen.dart'; // استيراد مشغل الفيديو

class PrayerVideoListScreen extends StatelessWidget {
  final String prayerName;

  const PrayerVideoListScreen({super.key, required this.prayerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فيديوهات $prayerName'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (prayerName == 'الفجر') ...[
            const VideoTile(
                videoPath: 'assets/vid1.mp4', title: 'كيفية صلاة الفجر'),
          ] else if (prayerName == 'الظهر') ...[
            const VideoTile(
                videoPath: 'assets/vid1.mp4', title: 'كيفية صلاة الظهر'),
          ] else if (prayerName == 'العصر') ...[
            const VideoTile(
                videoPath: 'assets/vid1.mp4', title: 'كيفية صلاة العصر'),
          ] else if (prayerName == 'المغرب') ...[
            const VideoTile(
                videoPath: 'assets/vid1.mp4', title: 'كيفية صلاة المغرب'),
          ] else if (prayerName == 'العشاء') ...[
            const VideoTile(
                videoPath: 'assets/vid1.mp4', title: 'كيفية صلاة العشاء'),
          ],
        ],
      ),
    );
  }
}

class VideoTile extends StatelessWidget {
  final String videoPath;
  final String title;

  const VideoTile({super.key, required this.videoPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                      videoPath: videoPath)), // الانتقال إلى مشغل الفيديو
            );
          },
          child: const Text('شاهد الفيديو'),
        ),
        const Divider(),
      ],
    );
  }
}
