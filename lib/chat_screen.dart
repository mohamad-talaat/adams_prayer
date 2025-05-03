import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تشات مع آدَم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  // هنا ستظهر الرسائل
                  ChatMessage(
                      isUser: true, text: 'مرحبًا، كيف يمكنني مساعدتك؟'),
                  ChatMessage(isUser: false, text: 'أحتاج مساعدة في الصلاة.'),
                  ChatMessage(isUser: true, text: 'بالطبع! ماذا تريد أن تعرف؟'),
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // هنا يمكنك إضافة وظيفة لإرسال الرسالة
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final bool isUser;
  final String text;

  const ChatMessage({super.key, required this.isUser, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text),
      ),
    );
  }
}
