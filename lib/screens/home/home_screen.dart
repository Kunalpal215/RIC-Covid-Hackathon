// // Importing packages
// import 'package:flutter/cupertino.dart';
import 'package:covid_app/screens/covid_map/map.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:covid_app/services/logout_user.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/screens/auth/profile_screen.dart';
// import 'package:covid_app/services/share_app.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // Importing Screens
// import 'package:covid_app/screens/welcome_screen.dart';
// import 'package:covid_app/screens/auth/profile_screen.dart';
// import 'package:covid_app/constants.dart';
// import 'package:covid_app/screens/home/contactpage.dart';

// // Importing Services
// import 'package:covid_app/services/logout_user.dart';
// import 'package:covid_app/services/permissions.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
        ],
        title: const Text(
          'Home Screen',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, MapScreen.id);
              },
              child: Text('Covid Map'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, ProfileScreen.id);

              },
              child: Text('profile'),
            ),
            ElevatedButton(
              onPressed: () async {
                await logoutUser();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);

              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );

  }

  @override
  void initState() {

  }
}
