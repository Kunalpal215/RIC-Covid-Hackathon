// Importing packages
import 'package:covid_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';

// Function to logout user, and delete user data from SharedPreferences
Future logoutUser() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("mobile");
  kCurrUser = null;
  kMobileNumber = null;
}
