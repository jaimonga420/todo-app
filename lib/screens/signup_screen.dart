import 'package:flutter/material.dart';

import '../widgets/login_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: LoginButton(
                    'assets/icons/google.svg', 'Continue with Google'),
              ),
              const LoginButton(
                  'assets/icons/phone.svg', 'Continue with Phone'),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              loginTextField(
                deviceWidth: deviceWidth,
                label: 'Email',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: loginTextField(
                  deviceWidth: deviceWidth,
                  label: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith((states) =>
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    fixedSize: MaterialStateProperty.resolveWith<Size>(
                        (states) => Size(deviceWidth - 100, 50)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => Color(0xfffd746c))),
                child: const Text('Sign Up'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class loginTextField extends StatelessWidget {
  const loginTextField(
      {Key? key, required this.deviceWidth, required this.label})
      : super(key: key);

  final double deviceWidth;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: deviceWidth - 70,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 17, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
