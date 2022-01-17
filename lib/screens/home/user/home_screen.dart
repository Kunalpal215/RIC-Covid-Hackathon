import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/feedback/complaint_list.dart';
import 'package:covid_app/screens/feedback/complaint_register.dart';
import 'package:covid_app/screens/home/user/pages/home_page_info.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIdx = 0;
  List Screens = [HomePageInfo(), ComplaintListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Screens[curIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIdx,
        onTap: (index) => setState(() {
          curIdx = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: "Complaints"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ComplaintScreen.id);
        },
        child: Icon(Icons.mode_edit_outline_outlined),
      ),
    );
  }
}
