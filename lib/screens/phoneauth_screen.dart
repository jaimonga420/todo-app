import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo_app/services/auth_services.dart';

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
  TextEditingController phoneController = TextEditingController();
  final auth = Auth();
  String finalVerificationId = '';
  String smsCode = '';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(oneSec, (timer) {
      if (timeStart == 0) {
        setState(() {
          isWaiting = false;
          timer.cancel();
        });
      } else {
        if (mounted) {
          setState(() {
            timeStart--;
          });
        }
      }
    });
  }

  void setData(String verificationId) {
    setState(() {
      finalVerificationId = verificationId;
    });
    startTimer();
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
                onPressed: () {
                  auth.signInWithPhone(context, finalVerificationId, smsCode);
                },
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
    return Container(
      width: deviceWidth - 40,
      height: 60,
      decoration: BoxDecoration(
          color: const Color(0xff1d1d1d),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        style: const TextStyle(color: Colors.white, fontSize: 17),
        controller: phoneController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: 'Phone number',
            hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                '(+91)',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            suffixIcon: TextButton(
                onPressed: () async {
                  setState(() {
                    timeStart = 30;
                    isWaiting = true;
                    btnName = 'Resend';
                  });
                  auth.verifyOtp(
                      context, '+91 ${phoneController.text}', setData);
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
        backgroundColor: const Color(0xff1d1d1d),
      ),
      fieldWidth: 50,
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        setState(() {
          smsCode = pin;
        });
      },
    );
  }
}
