// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import './signup_screen.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/todo_card.dart';

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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Today\'s Schedule',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/profile.png'),
          )
        ],
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  'Monday 21',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 33),
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: const [
            TodoCard(
                title: "Wake up Bro",
                iconData: Icons.alarm,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                time: "7:00 AM",
                check: true,
                selected: true)
          ],
        ),
      )),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// IconButton(
//               onPressed: () async {
//                 await auth.logout(context);
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                     SignupScreen.routeName, (route) => false);
//               },
//               icon: const Icon(Icons.logout))
