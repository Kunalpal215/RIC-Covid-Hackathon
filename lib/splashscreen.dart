import 'package:covid_app/models/admin.dart';
import 'package:covid_app/screens/auth/adminlogin.dart';
import 'package:covid_app/screens/home/user/home_screen.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:covid_app/services/load_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'models/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getdetails() async {
    // Checking if user previously logged in using SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kMobileNumber = prefs.getString('mobile');
    kEmail = prefs.getString('email');
    //Check if user exists
    if (kMobileNumber != null) {
      kCurrUser = User(mobileNumber: kMobileNumber);
      await loadUser(kMobileNumber,null,null,null,null,null,null);
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
    //Check if admin exists
    else if (kEmail != null) {
      kCurrAdmin = Admin(email: kEmail);
      Navigator.pushReplacementNamed(context, AdminLoginScreen.id);
    }
    else{
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:CircularProgressIndicator()),);
  }

  @override
  void initState() {
    getdetails();
  }
}
