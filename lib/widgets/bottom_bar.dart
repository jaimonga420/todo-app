import 'package:flutter/material.dart';

import '../screens/addtodo_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(backgroundColor: Colors.black87, items: [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: ""),
      BottomNavigationBarItem(
          icon: Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.purple])),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AddTodoScreen.routeName);
              },
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          label: ""),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          label: ""),
    ]);
  }
}
