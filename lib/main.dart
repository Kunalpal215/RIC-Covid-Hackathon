import 'package:covid_app/constants.dart';
import 'package:covid_app/models/admin.dart';
import 'package:covid_app/models/user.dart';
import 'package:covid_app/screens/auth/adminlogin.dart';
import 'package:covid_app/screens/auth/login_screen.dart';
import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/home/admin/adminhome.dart';
import 'package:covid_app/screens/home/user/home_screen.dart';
import 'package:covid_app/screens/home/user/pages/Covid_Cases/cases_info.dart';
import 'package:covid_app/screens/home/user/pages/booking/myslots.dart';
import 'package:covid_app/screens/home/user/pages/booking/slotbooking.dart';
import 'package:covid_app/screens/home/user/pages/covid_map/map.dart';
import 'package:covid_app/screens/home/user/pages/feedback/complaint_register.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:covid_app/services/load_user.dart';
import 'package:covid_app/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Initializing Firebase App
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Management',
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink,
      ),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        MapScreen.id: (context) => MapScreen(),
        ComplaintScreen.id: (context) => ComplaintScreen(),
        AdminLoginScreen.id: (context) => AdminLoginScreen(),
        AdminHome.id: (context) => AdminHome(),
        SlotBooking.id: (context) => SlotBooking(),
        MySlots.id: (context) => MySlots(),
        Cases_info.id: (context) => Cases_info()
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
