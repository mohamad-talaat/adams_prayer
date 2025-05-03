import 'package:adams_prayer/login_screen.dart';
import 'package:adams_prayer/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text(
          'مرحبًا بك في حسابك ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'يمكنك إدارة إعدادات حسابك هنا.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 200),
            Center(
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                    onPressed: () async {
                      // تسجيل الخروج من Firebase
                      await FirebaseAuth.instance.signOut();
                      // العودة إلى شاشة تسجيل الدخول
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                      );
                    },
                    child: const Text(
                      'تسجيل الخروج',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
