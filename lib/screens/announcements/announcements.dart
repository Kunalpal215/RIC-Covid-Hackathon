// Importing Packages
import 'package:flutter/material.dart';
import 'package:covid_app/screens/announcements/getAnnouncements.dart';

class Announcements extends StatefulWidget {
  static const id = '/announcements';

  Announcements({Key? key}) : super(key: key);

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: ListAnnouncements(),
    );
  }
}


