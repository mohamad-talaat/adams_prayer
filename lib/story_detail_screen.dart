import 'package:flutter/material.dart';

class StoryDetailScreen extends StatelessWidget {
  final String storyName;

  const StoryDetailScreen({super.key, required this.storyName});

  @override
  Widget build(BuildContext context) {
    String storyContent = '';

    // محتوى القصة الأولى
    if (storyName == 'قصة 1') {
      storyContent =
          'كان هناك فتى صغير يُدعى محمد. كان يحب مساعدة الآخرين في قريته. في يوم من الأيام، رأى امرأة مسنّة تكافح لحمل سلة ثقيلة. قرر محمد مساعدتها، وعندما فعل ذلك، شكرته المرأة وأخبرته أنه فعل شيئًا عظيمًا.';
    } else {
      storyContent = 'محتوى $storyName'; // يمكنك إضافة محتويات أخرى للقصة هنا
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل $storyName'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            storyContent,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
