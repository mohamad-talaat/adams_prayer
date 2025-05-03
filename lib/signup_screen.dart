import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'home_screen.dart'; // Make sure this import is correct

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordObscured = true;
   bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerWithEmailAndPassword() async {
    // Ensure keyboard is hidden
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        // Create the user account
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // --->>> Check if user is null just in case (though unlikely if no exception)
        if (credential.user == null) {
          throw Exception("فشل إنشاء المستخدم، الرجاء المحاولة مرة أخرى.");
        }

        // Add user data to Firestore
        // !!! THIS IS WHERE THE PERMISSION_DENIED ERROR OCCURRED !!!
        // !!! Make sure Firestore API is enabled in your Firebase project !!!
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'uid': credential.user!.uid, // Good practice to store uid
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'prayers': {
            'fajr': 0,
            'dhuhr': 0,
            'asr': 0,
            'maghrib': 0,
            'isha': 0,
          },
          'ablutionCount': 0,
        });

        // Update user profile (Optional but good practice)
        await credential.user!.updateDisplayName(_nameController.text.trim());
        // You could also update the photoURL here if you had one

        if (!mounted) return; // Check if the widget is still in the tree

        // Navigate to HomeScreen ONLY after successful auth AND firestore write
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            _errorMessage = 'كلمة المرور ضعيفة جداً';
          } else if (e.code == 'email-already-in-use') {
            _errorMessage = 'البريد الإلكتروني مستخدم بالفعل';
          } else if (e.code == 'invalid-email') {
            _errorMessage = 'صيغة البريد الإلكتروني غير صحيحة';
          } else {
            _errorMessage = e.message ?? 'حدث خطأ أثناء المصادقة';
            if (kDebugMode) {
              print('FirebaseAuthException Code: ${e.code}');
              print('FirebaseAuthException Message: ${e.message}');
            }
          }
        });
      } catch (e) {
        setState(() {
          // Check if it's a Firestore specific exception for better message
          if (e is FirebaseException && e.plugin == "cloud_firestore") {
            _errorMessage =
                'خطأ في قاعدة البيانات: ${e.message ?? "يرجى المحاولة مرة أخرى"}';
            if (e.code == 'permission-denied') {
              _errorMessage =
                  'خطأ في الأذونات. تأكد من تفعيل Firestore API في المشروع.';
            }
          } else {
            _errorMessage = 'حدث خطأ غير متوقع: ${e.toString()}';
          }
          if (kDebugMode) {
            print('Caught General Exception: $e');
          }
        });
      } finally {
        // Ensure isLoading is set to false even if an error occurs or widget is unmounted
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      // Form validation failed
      setState(() {
        _errorMessage = 'يرجى ملء جميع الحقول بشكل صحيح.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
        centerTitle: false, // <-- Set title to start
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // Apply requested padding here
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 16.0), // <-- Adjusted Padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder (Uncomment if you have one)
                // Image.asset(
                //   'assets/images/login.jpg', // Ensure this path is correct
                //   height: 150, // Adjust size as needed
                // ),
                // const SizedBox(height: 30),

                // Registration Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          // Use const
                          labelText: 'الاسم',
                          prefixIcon: const Icon(Icons.person),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            // Use trim()
                            return 'يرجى إدخال الاسم';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          // Use const
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: const Icon(Icons.email),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            // Use trim()
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          // Basic email regex (consider using a package for robust validation if needed)
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'يرجى إدخال بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: const Icon(Icons.lock),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ), // <-- Changed Border

                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            tooltip: 'عرض/إخفاء كلمة المرور',
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            tooltip: 'عرض/إخفاء كلمة المرور',
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                          labelText: 'تأكيد كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى تأكيد كلمة المرور';
                          }
                          if (value != _passwordController.text) {
                            return 'كلمات المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12), // Adjusted spacing

                      // Error Message Display
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center, // Center error message
                          ),
                        ),

                      const SizedBox(height: 20), // Adjusted spacing

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _isLoading ? null : _registerWithEmailAndPassword,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), 
                            ),
                        
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24, // Match text size better
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white), // Spinner color
                                  ),
                                )
                              : const Text(
                                  'إنشاء حساب',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                     Navigator.pop(context);
                                  },
                            child: const Text('تسجيل الدخول'),
                          ),
                          const Text('لديك حساب بالفعل؟'),
                        ],
                      ),
                      const SizedBox(height: 20), // Add some bottom space
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
