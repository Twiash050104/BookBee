import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Navigation/navigation.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print("======== AUTH WRAPPER ========");
        print("Connection: ${snapshot.connectionState}");
        print("User: ${snapshot.data}");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const NavigationScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
