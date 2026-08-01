import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/glassback_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});
  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController email = TextEditingController();

  bool isLoading = false;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: GlassBackButton(),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        "Enter your email address and we'll send you the link to reset your password.",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black.withOpacity(0.75),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        autofillHints: const [AutofillHints.email],
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }

                          final emailRegex = RegExp(
                            r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );

                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.yellow.shade50,

                          hintText: 'Email',
                          hintStyle: const TextStyle(fontSize: 15),

                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.orange.shade400,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.orange.shade300,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.orange.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.orange.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          minimumSize: Size(double.infinity, 54),
                          padding: EdgeInsets.zero,
                          backgroundColor: Color(0xFFFE9A34),
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (_formkey.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                          email: email.text.trim(),
                                        );

                                    if (!mounted) return;

                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            "Email Sent",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Text(
                                            "If an account with this email exists, a password reset link has been sent. "
                                            "Please check your inbox and spam folder.",
                                            style: TextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                ); // Close dialog
                                                Navigator.pop(
                                                  context,
                                                ); // Go back to Login
                                              },
                                              child: const Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Color(0xFFFE9A34),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    String message;

                                    switch (e.code) {
                                      case 'user-not-found':
                                        message =
                                            'No account found with this email.';
                                        break;

                                      case 'invalid-email':
                                        message = 'Please enter a valid email.';
                                        break;

                                      default:
                                        message =
                                            'Something went wrong. Please try again.';
                                    }

                                    if (!mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)),
                                    );
                                  }
                                }
                              },
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Send Reset Link',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
