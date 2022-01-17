import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/home/user/pages/announcements/announcements.dart';
import 'package:covid_app/screens/home/user/pages/covid_map/map.dart';
import 'package:covid_app/services/logout_user.dart';
import 'package:flutter/material.dart';

import '../../../../welcome_screen.dart';
class HomePageLanding extends StatefulWidget {
  const HomePageLanding({Key? key}) : super(key: key);

  @override
  _HomePageLandingState createState() => _HomePageLandingState();
}

class _HomePageLandingState extends State<HomePageLanding> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
              Navigator.pushNamed(context, Announcements.id);

            },
            child: Text('Announcements'),
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
    );
  }
}
