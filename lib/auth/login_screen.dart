import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../Navigation/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController username = TextEditingController();
  late TextEditingController password = TextEditingController();

  bool isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: MediaQuery.of(context).size.height * 0.28,
                    right: 30,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Login to continue your journey',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),

                      ///username
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.yellow.shade50,

                          hintText: 'Email or Username',
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
                        obscureText: isObscure,
                        controller: password,
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
                                isObscure = !isObscure;
                              });
                            },
                            icon: isObscure
                                ? Icon(Icons.visibility_outlined)
                                : Icon(Icons.visibility_off_outlined),
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.orange.shade700),
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigationScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
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
                          onPressed: () {},
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
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {},
                            child: Text(
                              "Sign up",
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
            ],
          ),
        ),
      ),
    );
  }
}
