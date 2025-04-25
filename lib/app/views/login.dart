import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/store/providers/user_provider.dart';
import 'package:flutter_application_1/app/store/services/user_service.dart';
import 'package:flutter_application_1/app/views/signup.dart';
import 'package:flutter_application_1/app/widgets/Calculator/customInput.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  String email = '';
  String password = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = email.toString();
    passwordController.text = password.toString();
  }

  void login() {
    try {
      ref.read(userStateProvider.notifier).signIn(
            emailController.text,
            passwordController.text,
          );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 30.0, bottom: 30.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('LOGIN',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Don’t have an account?',
                            style: TextStyle(
                              color: Color.fromRGBO(141, 154, 155, 1),
                              fontSize: 15.0,
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: InkWell(
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 128, 128, 1),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            onTap: () =>
                                {Navigator.pushNamed(context, '/signup')},
                          )),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Divider(color: Color.fromRGBO(233, 237, 238, 1))),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Input(
                      controller: emailController,
                      hint: 'Enter your email',
                      label: 'Email',
                      required: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      controller: passwordController,
                      hint: 'Enter your password',
                      label: 'Password',
                      required: true,
                    ),
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text('Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 128, 128, 1))),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => {login()},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.maxFinite, 50.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: const Color.fromRGBO(0, 128, 128, 1)),
                child: const Text('LOGIN',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              )
            ],
          ),
        )));
  }
}
