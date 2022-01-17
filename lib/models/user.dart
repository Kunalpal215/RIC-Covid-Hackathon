// Importing packages
import 'package:covid_app/constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Importing Firebase packages
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // User's Mobile Number
  final String mobileNumber;

  // User's Name
  String? name;

  // Variable to check if user's document exists in Cloud Firestore
  bool exists = false;

  User({required this.mobileNumber, this.name});

  // Checks if user's document is present in Cloud Firestore and updates 'exists' property
  Future loadExistence() async {
    await FirebaseFirestore.instance
        .collection('users').where('mobile',isEqualTo: mobileNumber).get().
        then((documentSnapshot) {
          print(documentSnapshot.size);
      if (documentSnapshot.size>0) {
        exists = true;
      } else {
        exists = false;
      }
    });
  }

  // Creates and updates documents in Firestore collection 'users' for this user
  Future createAndUpdateDocument(String mobile,String? name) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print(name);
    return users.doc(mobileNumber).set({
      'name': name,
      'mobile': mobile,
    }).then((value) {
      // print('New document created / updated for user');
    }).catchError((e) {
      // print(e.toString());
    });
  }

  // Retrieves data from user's document in Cloud Firestore
  Future retrieveDocument() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(mobileNumber).snapshots().listen((event) {
      name = event.get('name');
      kCurrUser!.name=name;
    });
  }

  // Downloads current user's profile image from Firebase Storage
  Future downloadProfileImage() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    kProfileImagePath = '${appDocDirectory.path}/profile.png';
    File profileImage = File(kProfileImagePath!);
    try {
      await FirebaseStorage.instance
          .ref('$mobileNumber/profile.png')
          .writeToFile(profileImage);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // Uploads current profile image to Firebase Storage
  Future uploadProfileImage() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    kProfileImagePath = '${appDocDirectory.path}/profile.png';
    File profileImage = File(kProfileImagePath!);
    try {
      await FirebaseStorage.instance
          .ref('$mobileNumber/profile.png')
          .putFile(profileImage);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
