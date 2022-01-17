// Importing Packages
import 'package:covid_app/screens/home/user/pages/announcements/getAnnouncements.dart';
import 'package:flutter/material.dart';

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


