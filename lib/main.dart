
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // إضافة Firebase
import 'firebase_options.dart'; // استدعاء ملف الإعدادات اللي تولد لما سويت flutterfire configure
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكدنا أن Flutter مهيأ قبل Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ربط الإعدادات
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
