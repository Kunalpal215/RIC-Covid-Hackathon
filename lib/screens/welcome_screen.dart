// Importing General Packages
import 'package:covid_app/components/animatedbuttonui.dart';
import 'package:covid_app/screens/auth/adminlogin.dart';
import 'package:flutter/material.dart';

// Importing Firebase Packages

// Importing Screens
import 'package:covid_app/screens/auth/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Colors.pink,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Center(
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Covid Management\nApp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/welcomescreenlogo.png',
                width: 250,
                height: 250,
              ),
              const Spacer(),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: const AnimatedButtonUI(
                    text: "I AM A USER"),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AdminLoginScreen.id);
                },
                child: const AnimatedButtonUI(
                    text: "I AM A ADMIN"),
              ),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
