// Importing packages
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/constants.dart';

// Importing Firebase packages
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class User {
  // User's Mobile Number
  final String mobileNumber;

  // User's Name
  String? name;

  // User's Name
  String? covidstatus;

  // User's Name
  String? vaccinestatus;

  // User's Name
  String? hostel;

  // User's Name
  String? room;

  // User's Name
  String? roll;

  // Variable to check if user's document exists in Cloud Firestore
  bool exists = false;

  User(
      {required this.mobileNumber,
      this.name,
      this.covidstatus,
      this.vaccinestatus,this.hostel,this.room,this.roll});

  // Checks if user's document is present in Cloud Firestore and updates 'exists' property
  Future loadExistence() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('mobile', isEqualTo: mobileNumber)
        .get()
        .then((documentSnapshot) {
      print(documentSnapshot.size);
      if (documentSnapshot.size > 0) {
        exists = true;
      } else {
        exists = false;
      }
    });
  }

  // Creates and updates documents in Firestore collection 'users' for this user
  Future createdocument(
      String mobile, String? name, String? covid, String? vaccine,String? hostel,String?room,String?roll) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print(mobile);
    return users.doc(mobile).set({
      'name': name,
      'mobile': mobile,
      'covid_status': covid,
      'vaccine_status': vaccine,
      'position': GeoPoint(0, 0),
      'hostel':hostel,
      'room':room,
      'roll':roll
    }).then((value) {
      print('New document created / updated for user');
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future updatedocument(
      String mobile, String? name, String? covid, String? vaccine,String? hostel,String?room,String?roll) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(mobile).update({
      'name': name,
      'mobile': mobile,
      'covid_status': covid,
      'vaccine_status': vaccine,
      'hostel':hostel,
      'room':room,
      'roll':roll
    }).then((value) {
      // print('New document created / updated for user');
    }).catchError((e) {
      // print(e.toString());
    });
  }

  // Retrieves data from user's document in Cloud Firestore
  Future retrieveDocument() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users
        .where('mobile', isEqualTo: mobileNumber)
        .snapshots()
        .listen((event) {
      kCurrUser!.name = event.docs.first['name'];
      kCurrUser!.covidstatus = event.docs.first['covid_status'];
      kCurrUser!.vaccinestatus = event.docs.first['vaccine_status'];
      kCurrUser!.hostel = event.docs.first['hostel'];
      kCurrUser!.room = event.docs.first['room'];
      kCurrUser!.roll = event.docs.first['roll'];
    });
  }

  // Downloads current user's profile image from Firebase Storage

}
