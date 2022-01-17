import 'package:covid_app/screens/welcome_screen.dart';
import 'package:covid_app/services/logout_user.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  static const id='/adminhome';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () async {
                await logoutAdmin();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);

              },
              child: Text('Logout admin'),
            ),
          ],
        ),
      ),

    );
  }
}
