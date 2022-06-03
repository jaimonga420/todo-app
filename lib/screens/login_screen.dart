import 'package:flutter/material.dart';

import '../widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
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
              
              LoginTextField(
                deviceWidth: deviceWidth,
                label: 'Email',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: LoginTextField(
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
                        (states) => const Color(0xfffd746c))),
                child: const Text('Sign In'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField(
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
        style: const TextStyle(fontSize: 17, color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 17, color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 1, color: Colors.amber),
            )),
      ),
    );
  }
}
