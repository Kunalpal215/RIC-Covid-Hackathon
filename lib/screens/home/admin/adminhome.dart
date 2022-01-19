import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/screens/home/admin/announcement.dart';
import 'package:covid_app/screens/home/admin/announcementlist.dart';
import 'package:covid_app/screens/home/admin/complaints/complaint_list.dart';
import 'package:covid_app/screens/home/admin/covid_status/covidstatusupdate.dart';
import 'package:covid_app/screens/home/admin/slotmanagescreen.dart';
import 'package:covid_app/screens/welcome_screen.dart';
import 'package:covid_app/services/logout_user.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  static const id = '/adminhome';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: SingleChildScrollView(
        child: Wrap(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ComplaintListAdminScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.pink[100],
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_box_outlined, size: 48.0),
                        Text(
                          'Complaints Section',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnnouncementMakeScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.pink[100],
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.new_label,
                          size: 48.0,
                        ),
                        Text(
                          'Make an announcement',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnnouncementList()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.pink[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.view_agenda_outlined,
                        size: 48.0,
                      ),
                      Text(
                        'View announcements',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SlotManageScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.pink[100],
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_moderator_outlined,
                          size: 48.0,
                        ),
                        Text(
                          'Manage/ Add slots',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CovidStatusAdmin()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.pink[100],
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.update, size: 48.0),
                        Text(
                          'Update covid status',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                CoolAlert.show(
                    context: context,
                    barrierDismissible: false,
                    type: CoolAlertType.confirm,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    onConfirmBtnTap: () async {
                      await logoutUser();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                    },
                    confirmBtnColor: Colors.pink[600]!,
                    backgroundColor: Colors.pink[100]!);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.pink[100],
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.exit_to_app, size: 48.0),
                        Text(
                          'Logout admin',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
