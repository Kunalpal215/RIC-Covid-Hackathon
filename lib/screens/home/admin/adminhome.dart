import 'package:covid_app/screens/home/admin/announcement.dart';
import 'package:covid_app/screens/home/admin/complaints/complaint_list.dart';
import 'package:covid_app/screens/home/admin/slotmanagescreen.dart';
import 'package:covid_app/screens/home/admin/covid_status/covidstatusupdate.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:covid_app/services/logout_user.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  static const id='/adminhome';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComplaintListAdminScreen()));
              },
              child: Text('Complaints Section'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnnouncementMakeScreen()));
              },
              child: Text('Make an announcement'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SlotManageScreen()));
              },
              child: Text('Add slots'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CovidStatusAdmin()));
              },
              child: Text('Update covid status'),
            ),
            ElevatedButton(
              onPressed: () async {
                await logoutAdmin();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);

              },
              child: Text('Logout admin'),
            ),
          ],
        ),
      ),
    );
  }
}
