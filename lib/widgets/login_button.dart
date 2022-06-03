import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginButton extends StatelessWidget {
  const LoginButton(this.imagePath, this.buttonText, {Key? key})
      : super(key: key);

  final String imagePath;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
    return InkWell(
      onTap: () async {

      },
      child: Container(
        width: deviceWidth - 60,
        height: 60,
        child: Card(
            color: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(width: 1, color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                )
              ],
            )),
      ),
    );
  }
}
