import 'package:flutter/material.dart';
import 'story_detail_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قصص'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          StoryButton(storyName: 'قصة 1', context: context),
          StoryButton(storyName: 'قصة 2', context: context),
          StoryButton(storyName: 'قصة 3', context: context),
          StoryButton(storyName: 'قصة 4', context: context),
          StoryButton(storyName: 'قصة 5', context: context),
        ],
      ),
    );
  }
}

class StoryButton extends StatelessWidget {
  final String storyName;
  final BuildContext context;

  const StoryButton({super.key, required this.storyName, required this.context});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // توجيه المستخدم إلى صفحة تفاصيل القصة
        Navigator.push(
          this.context,
          MaterialPageRoute(
            builder: (context) => StoryDetailScreen(storyName: storyName),
          ),
        );
      },
      child: Text(storyName),
    );
  }
}