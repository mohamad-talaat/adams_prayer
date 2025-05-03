import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message ?? 'حدث خطأ أثناء تسجيل الدخول';
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'حدث خطأ غير متوقع';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, navigate to the home screen
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'حدث خطأ أثناء تسجيل الدخول بحساب Google';
        if (kDebugMode) {
            print('------ Google Sign-In Error ------');
      print('Error Type: ${e.runtimeType}'); // What kind of error is it?
      print('Error Message: ${e.toString()}'); // The specific error message
      print('Stack Trace: ${e}'); // Where the error occurred in the code
      print('---------------------------------');
          print(e);
        }
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/login.jpg',
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Login Form
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              prefixIcon: const Icon(Icons.email),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'يرجى إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordObscured,
                          decoration: InputDecoration(suffixIcon: IconButton(
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
                            labelText: 'كلمة المرور',
                            prefixIcon: const Icon(Icons.lock),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                        const SizedBox(height: 8),

                        // Error Message
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : _signInWithEmailAndPassword,
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.green[50]),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Google Sign-In Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Image.asset(
                              'assets/images/google_logo.png',
                              height: 24,
                            ),
                            label: const Text('تسجيل الدخول بحساب Google'),
                            onPressed: _isLoading ? null : _signInWithGoogle,
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.green[50]),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Register Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text('إنشاء حساب'),
                            ),
                            const Text('ليس لديك حساب؟'),
                          ],
                        ),
                      ],
                    ),
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
