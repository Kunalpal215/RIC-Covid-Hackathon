// Importing packages
// // Importing Services
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/screens/auth/initial_user_update.dart';
import 'package:covid_app/screens/home/user/home_screen.dart';
import 'package:covid_app/services/load_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String userMobileNumber = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login with mobile number'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(5.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        userMobileNumber = number.phoneNumber!;
                        // print(userMobileNumber);
                      },
                      countries: const ['IN'],
                      selectorConfig: const SelectorConfig(
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 20,
                        useEmoji: true,
                        selectorType: PhoneInputSelectorType.DROPDOWN,
                      ),
                      initialValue: number,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await loginUser(userMobileNumber);
                          }
                        },
                        child: const Text('Get OTP'),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  loginUser(String mobileNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String otp = '';
    setState(() {
      loading = true;
    });
    await auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      timeout: const Duration(seconds: 120),
      // Called when auto detects OTP and is successful
      verificationCompleted: (PhoneAuthCredential credential) async {},

      // Called when error
      verificationFailed: (FirebaseAuthException authException) {
        // print(authException.message);
        setState(() {
          loading = false;
        });
      },

      // Called when OTP Code is sent to mobile number
      codeSent: (String verificationId, [int? resendToken]) async {
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Enter OTP Code (will exire in 2 minutes)'),
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
                  setState(() {
                    loading = true;
                  });

                  confirmlogin(verificationId, otp, auth, mobileNumber);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ],
          ),
        );
      },
      // Called when OTP expires due to timeout
      codeAutoRetrievalTimeout: (String verificationId) {
        if (auth.currentUser == null) {
          // print(verificationId);
          print("Timeout");
          setState(() {
            loading = false;
          });

          Navigator.pushReplacementNamed(context, LoginScreen.id);
          coolalertfailure('OTP timeout expired');
        }
      },
    );
  }

  Future<void> confirmlogin(
      String verificationId, String otp, var auth, String mobileNumber) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    await auth.signInWithCredential(credential).then((value) async {
      bool exists=false;
      await FirebaseFirestore.instance
          .collection('users')
          .where('mobile', isEqualTo: mobileNumber)
          .get()
          .then((documentSnapshot) {
        print(documentSnapshot.size);
        if (documentSnapshot.size > 0) {
          exists = true;
        } else {
          exists = false;
        }
      });
      if (!exists) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return InitialUserUpdate(mobileNumber:mobileNumber
              );
            });
      } else {
        await loadUser(mobileNumber,null,null,null);
        routescreen(mobileNumber);
      }
    }).catchError((err) {
      print(err.toString());
      coolalertfailure('OTP invalid');
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> routescreen(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', mobileNumber);
    print(mobileNumber);
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
  }

  coolalertsuccess(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Success',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.orange,
        backgroundColor: Color(0xFFFDE1AB));
  }

  coolalertfailure(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.orange,
        backgroundColor: Color(0xFFFDE1AB));
  }
}
