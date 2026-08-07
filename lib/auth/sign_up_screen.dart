import 'package:flutter/material.dart';
import '../Navigation/navigation.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Services/auth_service.dart';
import 'auth_wrapper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ScrollController scroll = ScrollController();
  double _blur = 0;

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void initState() {
    super.initState();

    scroll.addListener(() {
      final offset = scroll.offset;
      setState(() {
        _blur = (offset / 25).clamp(0, 10);
      });
    });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    confirmpassword.dispose();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                ),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo.png', width: 220),
                        Center(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Book',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Bee',
                                  style: TextStyle(color: Color(0xFFFE9A34)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Add. Track. Review.',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                controller: scroll,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: MediaQuery.of(context).size.height * 0.22,
                    right: 30,
                    bottom: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Reader!',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sign-up to continue your journey.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),

                        TextFormField(
                          controller: name,
                          autofillHints: const [AutofillHints.name],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.yellow.shade50,

                            hintText: 'Name',
                            hintStyle: const TextStyle(fontSize: 15),

                            prefixIcon: Icon(
                              Icons.person_2_outlined,
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
                        const SizedBox(height: 16),

                        ///username
                        TextFormField(
                          controller: email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
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
                        const SizedBox(height: 16),

                        ///password
                        TextFormField(
                          obscureText: isPasswordObscure,
                          controller: password,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.yellow.shade50,

                            hintText: 'Password',
                            hintStyle: const TextStyle(fontSize: 15),

                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: Colors.orange.shade400,
                            ),
                            suffixIcon: IconButton(
                              color: Colors.black54,
                              onPressed: () {
                                setState(() {
                                  isPasswordObscure = !isPasswordObscure;
                                });
                              },
                              icon: isPasswordObscure
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined),
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
                        const SizedBox(height: 16),
                        TextFormField(
                          obscureText: isConfirmPasswordObscure,
                          controller: confirmpassword,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }

                            if (value != password.text) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.yellow.shade50,

                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(fontSize: 15),

                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: Colors.orange.shade400,
                            ),
                            suffixIcon: IconButton(
                              color: Colors.black54,
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordObscure =
                                      !isConfirmPasswordObscure;
                                });
                              },
                              icon: isConfirmPasswordObscure
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined),
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
                        const SizedBox(height: 44),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            minimumSize: Size(double.infinity, 54),
                            padding: EdgeInsets.zero,
                            backgroundColor: Color(0xFFFE9A34),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                          email: email.text.trim(),
                                          password: password.text.trim(),
                                        );

                                await userCredential.user!.updateDisplayName(
                                  name.text.trim(),
                                );
                                await userCredential.user!.reload();

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user!.uid)
                                    .set({
                                      'name': name.text.trim(),
                                      'email': email.text.trim(),
                                      'createdAt': FieldValue.serverTimestamp(),
                                    });

                                if (!context.mounted) return;

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationScreen(),
                                  ),
                                );
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),

                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: Row(
                            children: [
                              Expanded(child: Divider(color: Colors.black12)),
                              Text(
                                ' or continue with ',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Expanded(child: Divider(color: Colors.black12)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        Center(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(180, 48),
                            ),
                            onPressed: () async {
                              try {
                                final userCredential = await AuthService()
                                    .signInWithGoogle();
                                if (!context.mounted) return;

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const AuthWrapper(),
                                  ),
                                  (route) => false,
                                );

                                if (userCredential == null) {
                                  return;
                                }

                                // AuthWrapper will automatically navigate
                              } on FirebaseAuthException catch (e) {
                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.message ?? 'Google Sign-In failed',
                                    ),
                                  ),
                                );
                              } catch (e) {
                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Something went wrong.'),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  width: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
