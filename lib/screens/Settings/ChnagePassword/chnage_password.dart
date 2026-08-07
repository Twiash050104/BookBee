import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/glassback_button.dart';
import 'package:flutter_bookbee/auth/forgot_password_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  bool isoldpasswordObscure = true;
  bool isnewpasswordObscure = true;
  bool isconfirmpasswordObscure = true;

  void initState() {
    super.initState();
  }

  void dispose() {
    oldpassword.dispose();
    newpassword.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: AppBar(
                  leading: GlassBackButton(),

                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    'Password',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: isoldpasswordObscure,
                      controller: oldpassword,
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

                        hintText: 'Old Password',
                        hintStyle: const TextStyle(fontSize: 15),

                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.orange.shade400,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.black54,
                          onPressed: () {
                            setState(() {
                              isoldpasswordObscure = !isoldpasswordObscure;
                            });
                          },
                          icon: isoldpasswordObscure
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
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
                    //const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotpasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.orange.shade700),
                        ),
                      ),
                    ),

                    //const SizedBox(height: 20),
                    TextFormField(
                      obscureText: isnewpasswordObscure,
                      controller: newpassword,
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

                        hintText: 'New Password',
                        hintStyle: const TextStyle(fontSize: 15),

                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.orange.shade400,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.black54,
                          onPressed: () {
                            setState(() {
                              isnewpasswordObscure = !isnewpasswordObscure;
                            });
                          },
                          icon: isnewpasswordObscure
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
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
                    const SizedBox(height: 20),

                    TextFormField(
                      obscureText: isconfirmpasswordObscure,
                      controller: confirmpassword,
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
                              isconfirmpasswordObscure =
                                  !isconfirmpasswordObscure;
                            });
                          },
                          icon: isconfirmpasswordObscure
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.3,
                          54,
                        ),
                        padding: EdgeInsets.zero,
                        backgroundColor: Color(0xFFFE9A34),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
