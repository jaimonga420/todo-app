// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import './signup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.logout(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    SignupScreen.routeName, (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
