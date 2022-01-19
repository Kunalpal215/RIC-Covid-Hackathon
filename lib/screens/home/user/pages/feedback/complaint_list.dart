import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/screens/home/user/pages/feedback/complaint_info.dart';
import 'package:covid_app/screens/home/user/pages/feedback/complaint_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintListScreen extends StatefulWidget {
  static const title='My Complaints';
  const ComplaintListScreen({Key? key}) : super(key: key);

  @override
  _ComplaintListScreenState createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
            .collection('complaints')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          if (docs.length == 0) {
            return Center(child: Text("No complaints registered from you!"));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10.0),
                margin:
                EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${docs[index]["subject"]}',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Divider(),
                    Text(
                      '${docs[index]["text"]}',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    Divider(),
                    Text(
                      timeConvert(docs[index]["complaint_date"]),
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ComplaintInfo(
                              docId: docs[index].id,
                            )));
                      },
                      child: Text(
                        'View Details',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ComplaintScreen.id);
        },
        tooltip: 'Ask a complaint',
        child: Icon(Icons.mode_edit_outline_outlined),
      ),
    );
  }
  String timeConvert(Timestamp timeInMillis) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        timeInMillis.millisecondsSinceEpoch);
    var formattedtime = DateFormat('dd-MM-yyyy hh:mm a').format(time);
    return formattedtime;
  }
}
