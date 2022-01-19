// Importing Packages
import 'package:covid_app/constants.dart';
import 'package:covid_app/models/admin.dart';

// Importing Models
import 'package:covid_app/models/user.dart';

// Importing Services
import 'package:covid_app/services/copy_image_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Function to load sign in user's details
Future<bool> loadUser(String mobileNumber,String? name, String? covidstatus,String? vaccinestatus,String?hostel,String?room,String? roll) async {
  print('${mobileNumber} ${name} ${covidstatus} ${vaccinestatus}');
  kCurrUser = User(mobileNumber: mobileNumber,name:name,covidstatus: covidstatus,vaccinestatus: vaccinestatus,hostel:hostel,room:room,roll:roll);
  await kCurrUser!.loadExistence();
  if (kCurrUser!.exists) {
    await kCurrUser!.retrieveDocument();
    await kCurrUser!.downloadProfileImage();
    await kCurrUser!.uploadProfileImage();
  } else {
    await kCurrUser!.createdocument(mobileNumber,name, covidstatus,vaccinestatus,hostel,room,roll);
    await copyImageFile(
        'profile.png', '${kCurrUser!.mobileNumber}/profile.png');
    await kCurrUser!.downloadProfileImage();
  }
  print(kCurrUser!.exists);
  return kCurrUser!.exists;
}

Future<void> loadAdmin(String email) async {
  kCurrAdmin = Admin(email: email);

  print('catch');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  print('catch2');
}
