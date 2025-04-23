import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/widgets/Calculator/customInput.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = name.toString();
    emailController.text = email.toString();
    passwordController.text = password.toString();
    confirmPassController.text = confirmPassword.toString();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    try {
      print(passwordController.text);
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => print("User created"))
          .catchError((e) => print(e));
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Create Account',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    spacing: 6.0,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Color.fromRGBO(141, 154, 155, 1),
                          fontSize: 15.0,
                        ),
                      ),
                      InkWell(
                          child: const Text(
                            'Log In?',
                            style: TextStyle(
                                color: Color.fromRGBO(0, 128, 128, 1),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () => {Navigator.pushNamed(context, '/')}),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: const Divider(
                      color: Color.fromRGBO(233, 237, 238, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      spacing: 16.0,
                      children: [
                        Input(
                          controller: nameController,
                          hint: 'Jenny Wilson',
                          required: true,
                          label: 'Full Name',
                        ),
                        Input(
                          controller: emailController,
                          hint: 'Enter Email',
                          required: true,
                          label: 'Email',
                        ),
                        Input(
                          controller: passwordController,
                          hint: 'Enter Password',
                          required: true,
                          label: 'Password',
                        ),
                        Input(
                          controller: confirmPassController,
                          hint: 'Enter confirm password',
                          required: true,
                          label: 'Confirm Password',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.maxFinite, 50.0),
                    backgroundColor: const Color.fromRGBO(110, 104, 59, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () => {signUp()},
                  child: const Text('Create Account',
                      style: TextStyle(color: Colors.white, fontSize: 16.0))),
            ],
          ),
        )));
  }
}
