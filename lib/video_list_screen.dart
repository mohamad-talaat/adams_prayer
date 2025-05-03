import 'package:flutter/material.dart';
import 'video_player_screen.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الفيديوهات'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('فيديو 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VideoPlayerScreen(videoPath: 'assets/video1.mp4'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('فيديو 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VideoPlayerScreen(videoPath: 'assets/video2.mp4'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('فيديو 3'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VideoPlayerScreen(videoPath: 'assets/video3.mp4'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
