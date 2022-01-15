// Importing Packages
import 'package:covid_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing Models
import 'package:covid_app/models/user.dart';

// Importing Services
import 'package:covid_app/services/copy_image_file.dart';

// Function to load sign in user's details
Future<void> loadUser(String mobileNumber) async {
  kCurrUser = User(mobileNumber: mobileNumber, name: '');
  await kCurrUser!.loadExistence();
  if (kCurrUser!.exists) {
    await kCurrUser!.retrieveDocument();
    await kCurrUser!.downloadProfileImage();
    await kCurrUser!.uploadProfileImage();
  } else {
    await kCurrUser!.createAndUpdateDocument();
    await copyImageFile(
        'profile.png', '${kCurrUser!.mobileNumber}/profile.png');
    await kCurrUser!.downloadProfileImage();
  }
  print('catch');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('mobile', mobileNumber);
  print('catch2');
}
