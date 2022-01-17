// Importing General Packages
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Covid App',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: const Text(
                'Login as user',
                style: TextStyle(fontSize: 22.5, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AdminLoginScreen.id);
              },
              child: const Text(
                'Login as admin',
                style: TextStyle(fontSize: 22.5, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
