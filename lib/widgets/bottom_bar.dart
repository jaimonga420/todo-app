import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/addtodo_screen.dart';
import '../screens/signup_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void onItemTap(index) async {
    if (index == 0) {
      Navigator.pushNamed(context, AddTodoScreen.routeName);
    }
    if (index == 1) {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamed(SignupScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.black87,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purple])),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              label: ""),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: ""),
        ]);
  }
}
