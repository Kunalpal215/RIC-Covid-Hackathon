// Importing Packages
import 'package:covid_app/screens/home/user/pages/announcements/getAnnouncements.dart';
import 'package:flutter/material.dart';

class Announcements extends StatefulWidget {
  static const id = '/announcements';
  static const title='All Announcements';
  Announcements({Key? key}) : super(key: key);

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListAnnouncements(),
    );
  }
}


