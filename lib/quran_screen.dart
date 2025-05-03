import 'package:flutter/material.dart';
import 'surah_detail_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سور القرآن'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          QuranButton(surahName: 'الفاتحة', context: context),
          QuranButton(surahName: 'البقرة', context: context),
          QuranButton(surahName: 'آل عمران', context: context),
          QuranButton(surahName: 'النساء', context: context),
          QuranButton(surahName: 'المائدة', context: context),
          QuranButton(surahName: 'الأنعام', context: context),
        ],
      ),
    );
  }
}

class QuranButton extends StatelessWidget {
  final String surahName;
  final BuildContext context;

  const QuranButton({super.key, required this.surahName, required this.context});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // توجيه المستخدم إلى صفحة تفاصيل السورة
        Navigator.push(
          this.context,
          MaterialPageRoute(
            builder: (context) => SurahDetailScreen(surahName: surahName),
          ),
        );
      },
      child: Text(surahName),
    );
  }
}