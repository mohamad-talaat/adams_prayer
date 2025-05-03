import 'package:flutter/material.dart';
import 'ablution_screen.dart'; // استيراد صفحة الوضوء
import 'prayer_screen.dart'; // استيراد صفحة الصلاة
import 'stories_screen.dart'; // استيراد صفحة القصص
import 'chat_screen.dart'; // استيراد صفحة الدردشة
import 'quran_screen.dart'; // استيراد صفحة القرآن
import 'account_screen.dart'; // استيراد صفحة الحساب

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // المتغير لتتبع الصفحة الحالية

  final List<Widget> _pages = [
    const HomeContent(), // الصفحة الرئيسية
    const QuranScreen(), // صفحة القرآن
    const AccountScreen(), // صفحة الحساب
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // تحديث الصفحة الحالية
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
      ),
      body: _pages[_selectedIndex], // عرض الصفحة الحالية
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الصفحة الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'القرآن',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'الحساب',
          ),
        ],
        currentIndex: _selectedIndex, // تحديد الصفحة الحالية
        onTap: _onItemTapped, // التعامل مع النقر على العناصر
      ),
    );
  }
}

// محتوى الصفحة الرئيسية
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png', // تأكد من وجود صورة في مجلد assets
            width: 150,
            height: 150,
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'تعلم الصلاة مع آدَم',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AblutionScreen()),
                );
              },
              child: const Text('الوضوء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const PrayerScreen()), // الانتقال إلى صفحة الصلاة
                );
              },
              child: const Text('الصلاة'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ChatScreen()), // الانتقال إلى صفحة الدردشة
                );
              },
              child: const Text('تشات مع آدَم'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const StoriesScreen()), // الانتقال إلى صفحة القصص
                );
              },
              child: const Text('قصص'),
            ),
          ],
        ),
      ],
    );
  }
}
