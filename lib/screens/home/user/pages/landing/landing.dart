import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/home/user/pages/announcements/announcements.dart';
import 'package:covid_app/screens/home/user/pages/covid_map/map.dart';
import 'package:covid_app/services/logout_user.dart';
import 'package:covid_app/screens/home/user/pages/landing/getCasesinfo.dart';
import 'package:flutter/material.dart';

import '../../../../welcome_screen.dart';
class HomePageLanding extends StatefulWidget {
  static const title = 'Covid Management App';
  const HomePageLanding({Key? key}) : super(key: key);

  @override
  _HomePageLandingState createState() => _HomePageLandingState();
}

class _HomePageLandingState extends State<HomePageLanding> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 220,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(15, 25, 15, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),]
            ),
            child: Totalcases()
          ),
      GestureDetector(
          onTap: ()=>Navigator.pushNamed(context,MapScreen.id),
          child: Container(
            width: screenWidth,
            height: screenWidth * 0.15,
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'VIEW COVID MAP',
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.pink,
            ),
          ))
        ],
      ),
    );
  }
}
