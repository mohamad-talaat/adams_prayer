import 'package:adams_prayer/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //a  backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'صلي مع أدم',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/welcome.jpg',
                  width: 350,
                  height: 350,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to the login screen
                    Navigator.pushReplacement(context , MaterialPageRoute(builder:
                     (context) => const LoginScreen()));
                  },
                  child: const Text('تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
