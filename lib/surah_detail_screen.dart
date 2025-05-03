import 'package:flutter/material.dart';

class SurahDetailScreen extends StatelessWidget {
  final String surahName;

  const SurahDetailScreen({super.key, required this.surahName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سورة $surahName'),
      ),
      body: Center(
        child: Text(
          'محتوى سورة $surahName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
