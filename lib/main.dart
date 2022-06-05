import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
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

Widget currentPage = SignupScreen();
Auth auth = Auth();

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() {
    String token = auth.getToken().toString();
    print(token);
    if (token != null) {
      setState(() {
        currentPage = HomeScreen();
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
      home: currentPage,
      routes: {
        '/homescreen': (context) => const HomeScreen(),
        '/signupscreen': (context) => const SignupScreen(),
      },
    );
  }
}
