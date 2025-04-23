import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_stack.dart';
import 'package:flutter_application_1/app/routes/auth_stack.dart';

class RootStack extends StatelessWidget {
  const RootStack({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData) {
          return const AppStack();
        } else {
          return const AuthStack();
        }
      },
    );
  }
}
