import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/views/login.dart';
import 'package:flutter_application_1/app/views/signup.dart';

class AuthStack extends StatelessWidget {
  const AuthStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (context) => const Login();
            break;
          case '/signup':
            builder = (context) => const Signup();
            break;
          default:
            builder = (context) => const Login();
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
