// Importing packages
import 'package:flutter/material.dart';

// Importing Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';

// Importing Screens
import 'package:covid_app/screens/auth/login_screen.dart';
import 'package:covid_app/screens/home/user/home_screen.dart';

// // Importing Services
import 'package:covid_app/services/load_user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// // Function to sign in users using mobile number
loginUser(String mobileNumber, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String otp = '';
  EasyLoading.show(status: 'loading...');
  await auth.verifyPhoneNumber(
    phoneNumber: mobileNumber,
    timeout: const Duration(seconds: 120),
    // Called when auto detects OTP and is successful
    verificationCompleted: (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential).then((value) async {
        await loadUser(mobileNumber);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        EasyLoading.dismiss();
      }).catchError((err) {
        // print(err.toString());
        EasyLoading.dismiss();
      });
    },

    // Called when error
    verificationFailed: (FirebaseAuthException authException) {
      // print(authException.message);
      EasyLoading.dismiss();
    },

    // Called when OTP Code is sent to mobile number
    codeSent: (String verificationId, [int? resendToken]) async {
      EasyLoading.dismiss();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Enter OTP Code'),
          content: TextField(
            onChanged: (val) {
              otp = val;
            },
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child: const Text('LOGIN'),
              onPressed: () async {
                EasyLoading.show(status: 'loading...');
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: otp);
                await auth.signInWithCredential(credential).then((value) async {
                  await loadUser(mobileNumber);
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                  EasyLoading.dismiss();
                }).catchError((err) {
                   print(err.toString());
                });
              },
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, LoginScreen.id);
                EasyLoading.dismiss();
              },
            ),
          ],
        ),
      );
    },
    // Called when OTP expires due to timeout
    codeAutoRetrievalTimeout: (String verificationId) {
      if (auth.currentUser==null) {
        // print(verificationId);
        print("Timeout");
        EasyLoading.dismiss();

        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    },
  );

}
