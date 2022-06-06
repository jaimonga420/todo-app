// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../widgets/login_button.dart';
import '../screens/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const routeName = '/signupscreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoginMode = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  String errorMessage = '';

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
              Text(
                isLoginMode ? 'Sign In' : 'Sign Up',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: LoginButton(
                    'assets/icons/google.svg', 'Continue with Google', true),
              ),
              LoginButton(
                  'assets/icons/phone.svg', 'Continue with Phone', false),
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
                textController: emailController,
                obscureText: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: LoginTextField(
                  deviceWidth: deviceWidth,
                  label: 'Password',
                  textController: pwdController,
                  obscureText: true,
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Color(0xfffd746c),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (!isLoginMode) {
                          try {
                            await firebaseAuth.createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: pwdController.text.trim());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.routeName,
                                (Route<dynamic> route) => false);
                          } on firebase_auth.FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              errorMessage =
                                  'The email address is already in use by another account.';
                            }
                            final authErrorSnackbar =
                                SnackBar(content: Text(errorMessage));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(authErrorSnackbar);
                          } catch (e) {
                            final errorSnackbar =
                                SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorSnackbar);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else if (isLoginMode) {
                          try {
                            await firebaseAuth.signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: pwdController.text.trim());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.routeName, (route) => false);
                          } on firebase_auth.FirebaseAuthException catch (e) {
                            debugPrint(e.code);
                            if (e.code == 'user-not-found') {
                              errorMessage = 'No use found.';
                            }
                            if (e.code == 'wrong-password' ||
                                e.code == 'invalid-email') {
                              errorMessage = 'Invalid email/password.';
                            }

                            final authErrorSnackbar = SnackBar(
                              content: Text(errorMessage),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(authErrorSnackbar);
                          } catch (e) {
                            final errorSnackbar =
                                SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorSnackbar);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith((states) =>
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          fixedSize: MaterialStateProperty.resolveWith<Size>(
                              (states) => Size(deviceWidth - 100, 50)),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) => const Color(0xfffd746c))),
                      child: Text(isLoginMode ? 'Sign In' : 'Sign Up'),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoginMode
                        ? 'Don\'t have an account?'
                        : 'Already have an account?',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginMode = !isLoginMode;
                        });
                      },
                      child: Text(
                        isLoginMode ? 'Sign Up' : 'Sign In',
                        style: const TextStyle(
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

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {Key? key,
      required this.deviceWidth,
      required this.label,
      required this.textController,
      required this.obscureText})
      : super(key: key);

  final double deviceWidth;
  final String label;
  final TextEditingController textController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: deviceWidth - 70,
      child: TextFormField(
        controller: textController,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 17, color: Colors.white),
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
