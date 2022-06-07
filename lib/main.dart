import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/addtodo_screen.dart';
import 'screens/phoneauth_screen.dart';
import 'services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Widget currentPage = const SignupScreen();
Auth auth = Auth();

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() {
    String token = auth.getToken().toString();

    // ignore: unnecessary_null_comparison
    if (token != null) {
      setState(() {
        currentPage = const HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddTodoScreen(),
      routes: {
        '/homescreen': (context) => const HomeScreen(),
        '/signupscreen': (context) => const SignupScreen(),
        '/phoneauthscreen': (context) => const PhoneAuthScreen(),
      },
    );
  }
}
