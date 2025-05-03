import 'package:flutter/material.dart';
import 'prayer_detail_screen.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الصلاة'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'اختر الصلاة:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  PrayerCard(
                    prayerName: 'الفجر',
                    icon: Icons.brightness_3,
                    color: Colors.indigo,
                    context: context,
                  ),
                  PrayerCard(
                    prayerName: 'الظهر',
                    icon: Icons.wb_sunny,
                    color: Colors.orange,
                    context: context,
                  ),
                  PrayerCard(
                    prayerName: 'العصر',
                    icon: Icons.wb_twilight,
                    color: Colors.amber,
                    context: context,
                  ),
                  PrayerCard(
                    prayerName: 'المغرب',
                    icon: Icons.nightlight_round,
                    color: Colors.deepPurple,
                    context: context,
                  ),
                  PrayerCard(
                    prayerName: 'العشاء',
                    icon: Icons.stars,
                    color: Colors.blue,
                    context: context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerCard extends StatelessWidget {
  final String prayerName;
  final IconData icon;
  final Color color;
  final BuildContext context;

  const PrayerCard({
    super.key, 
    required this.prayerName, 
    required this.icon, 
    required this.color,
    required this.context
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => PrayerDetailScreen(prayerName: prayerName),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              prayerName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}