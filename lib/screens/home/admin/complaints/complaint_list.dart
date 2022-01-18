import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/screens/home/admin/complaints/complaint_reply.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ComplaintListAdminScreen extends StatefulWidget {
  const ComplaintListAdminScreen({Key? key}) : super(key: key);

  @override
  _ComplaintListAdminScreenState createState() =>
      _ComplaintListAdminScreenState();
}

class _ComplaintListAdminScreenState extends State<ComplaintListAdminScreen> {
  int curIdx = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Future<List<Widget>> getComplaints(
        List<QueryDocumentSnapshot> docs, bool solveStatus) async {
      List<Widget> complaints = [];
      for (int i = 0; i < docs.length; i++) {
        QuerySnapshot complaint =
            await docs[i].reference.collection('complaints').get();
        complaint.docs.forEach((element) {
          if (element["solved"] == solveStatus) {
            complaints.add(
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ComplaintReply(
                            userId: docs[i].id,
                            complaintId: element.id,
                            flag: curIdx==0 ? true : false,
                          )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.all(screenWidth * 0.017),
                          child: Text(
                            element["subject"].length > 40
                                ? element["subject"].substring(0, 39) + "..."
                                : element["subject"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: screenWidth * 0.02,
                                left: screenWidth * 0.02),
                            child: Text("Name :" + docs[i]["name"]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.02),
                            child: Text(", Complaint date : " +
                                element["complaint_date"]
                                    .toDate()
                                    .day
                                    .toString() +
                                "/" +
                                element["complaint_date"]
                                    .toDate()
                                    .month
                                    .toString() +
                                "/" +
                                element["complaint_date"]
                                    .toDate()
                                    .year
                                    .toString()),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(element["text"]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
      }
      return complaints;
    }

    List<Widget> screens = [
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          return FutureBuilder<List<Widget>>(
            future: getComplaints(docs, false),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView(
                children: snapshot.data!,
              );
            },
          );
        },
      ),
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          return FutureBuilder<List<Widget>>(
            future: getComplaints(docs, true),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView(
                children: snapshot.data!,
              );
            },
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Admin Complaint Screen'),),
      body: screens[curIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIdx,
        onTap: (index){
          setState(() {
            curIdx=index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded), label: "Active Complaints"),
          BottomNavigationBarItem(
              icon: Icon(Icons.anchor_outlined), label: "Solved Complaints"),
        ],
      ),
    );
  }
}
