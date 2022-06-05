import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  static const routeName = '/phoneauthscreen';

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  int timeStart = 30;
  bool isWaiting = false;
  String btnName = 'Send';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(oneSec, (timer) {
      if (timeStart == 0) {
        setState(() {
          isWaiting = false;
          timer.cancel();
        });
      } else {
        setState(() {
          timeStart--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
          'Continue with phone',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              phoneField(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Please Enter 6 Digit OTP',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              otpField(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 150),
                child: Text('Send an OTP again in $timeStart secs',
                    style: const TextStyle(
                        color: Colors.yellowAccent, fontSize: 15)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.resolveWith<Size>(
                        (states) => Size(deviceWidth - 60, 60)),
                    shape: MaterialStateProperty.resolveWith((states) =>
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => const Color(0xffff9601))),
                child: const Text(
                  'Let\'s Go',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneField() {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      width: deviceWidth - 40,
      height: 60,
      decoration: BoxDecoration(
          color: const Color(0xff1d1d1d),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Phone number',
            hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                '(+91)',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            suffixIcon: TextButton(
                onPressed: () {
                  startTimer();
                  setState(() {
                    timeStart = 30;
                    isWaiting = true;
                    btnName = 'Resend';
                  });
                },
                child: Text(
                  btnName,
                  style: TextStyle(
                      color: isWaiting ? Colors.grey : Colors.white,
                      fontSize: 17),
                ))),
      ),
    );
  }

  Widget otpField() {
    return OTPTextField(
      spaceBetween: 7,
      length: 6,
      width: MediaQuery.of(context).size.width - 40,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      fieldWidth: 50,
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }
}
