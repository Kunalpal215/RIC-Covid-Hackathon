// Importing Packages

// Importing Models
import 'package:covid_app/models/user.dart';

// Current logged in user (by default null)
dynamic kMobileNumber;
User? kCurrUser;

// Path of profile image to be displayed
String? kProfileImagePath;

// Content to share for invite a friend
String kShareSubject = 'Friend Invite';
String kShareText =
    'Hey! I invite you to join Food App. Join now using this link https://locationtrackerapp.page.link/register-now';
