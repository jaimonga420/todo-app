// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('todos').snapshots();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: StreamBuilder(
            stream: _stream,
            builder: ((context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    IconData icondata;
                    Color iconColor;
                    switch (snapshot.data.docs[index]['category']) {
                      case 'Food':
                        icondata = Icons.food_bank;
                        iconColor = const Color(0xffff6d6e);
                        break;
                      case 'Workout':
                        icondata = Icons.sports_gymnastics;
                        iconColor = const Color(0xfff39732);
                        break;
                      case 'Work':
                        icondata = Icons.work;
                        iconColor = const Color(0xff6557ff);
                        break;
                      case 'Design':
                        icondata = Icons.art_track;
                        iconColor = const Color(0xff234ebd);
                        break;
                      case 'Run':
                        icondata = Icons.run_circle;
                        iconColor = const Color(0xff2bc8d9);
                        break;
                      default:
                        icondata = Icons.work;
                        iconColor = const Color(0xff6557ff);
                        break;
                    }
                    return TodoCard(
                        title: snapshot.data.docs[index]['title'],
                        iconData: icondata,
                        iconBgColor: Colors.white,
                        iconColor: iconColor,
                        time: "7:00 AM",
                        check: true,
                        selected: true);
                  });
            })),
      ),
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
