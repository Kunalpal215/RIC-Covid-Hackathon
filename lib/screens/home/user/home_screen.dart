import 'dart:io';

import 'package:covid_app/constants.dart';
import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/home/user/pages/announcements/announcements.dart';
import 'package:covid_app/screens/home/user/pages/booking/slotbooking.dart';
import 'package:covid_app/screens/home/user/pages/feedback/complaint_list.dart';
import 'package:covid_app/screens/home/user/pages/landing/landing.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIdx = 0;
  List Screens = [HomePageLanding(), SlotBooking(),ComplaintListScreen(), ProfileScreen(), Announcements(), WelcomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Management App'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              // Profile Header -->
              UserAccountsDrawerHeader(
                accountName: Text(kCurrUser!.name ?? ''),
                accountEmail: Text(kCurrUser!.mobileNumber),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: const Color(0xFF778899),
                  backgroundImage: FileImage(
                    File(kProfileImagePath!),
                  ),
                ),
                otherAccountsPictures: [
                  IconButton(onPressed: (){
                    setState(() {
                      curIdx=5;
                    });
                    Navigator.pop(context);
                  }, icon: Icon(Icons.logout))
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.home_outlined),
                      title: Text("Home"),
                      onTap: () {
                        setState(() {
                          curIdx = 0;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Courses -->
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.add_box_outlined),
                      title: Text("Book"),
                      onTap: () {
                        setState(() {
                          curIdx = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // Academics -->
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.message_outlined),
                      title: Text("Complaints"),
                      onTap: () {
                        setState(() {
                          curIdx = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.fiber_new_outlined),
                      title: Text("Announcements"),
                      onTap: () {
                        setState(() {
                          curIdx = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.supervised_user_circle_outlined),
                      title: Text("Profile"),
                      onTap: () {
                        setState(() {
                          curIdx = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Job Updates -->
                ],
              ),
            ],
          ),
        ),
      ),
      body: Screens[curIdx],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: curIdx,
      //   onTap: (index) => setState(() {
      //     curIdx = index;
      //   }),
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.add_circle_sharp), label: "Book"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.message), label: "Complaints"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: "Profile"),
      //   ],
      // ),
    );
  }
}
