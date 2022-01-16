import 'package:covid_app/screens/covid_map/map.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:covid_app/screens/auth/edit_profile_screen.dart';
import 'package:covid_app/models/user.dart';
 import 'package:covid_app/screens/auth/edit_profile_screen.dart';
import 'package:covid_app/screens/auth/login_screen.dart';
import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/home/home_screen.dart';
 import 'package:covid_app/screens/auth/profile_screen.dart';
import 'package:covid_app/screens/home/home_screen.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
 import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Initializing Firebase App
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Checking if user previously logged in using SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  kMobileNumber = prefs.getString('mobile');
  var temp = prefs.getString('mobile');
  if (temp != null) {
    kCurrUser = User(mobileNumber: temp, name: 'demo-name');
    kCurrUser!.retrieveDocument();
    kCurrUser!.downloadProfileImage();
  }
  configLoading();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false;
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
      title: 'covid_app',
      home:
          (kCurrUser == null) ?
         const WelcomeScreen()
      :const HomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        MapScreen.id : (context) => MapScreen(),
      },
      builder: EasyLoading.init(),

    );
  }

  @override
  void initState() {
    super.initState();
  }
}
