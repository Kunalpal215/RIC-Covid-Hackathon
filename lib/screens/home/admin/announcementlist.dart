import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({Key? key}) : super(key: key);

  @override
  _AnnouncementListState createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All announcements'),
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Announcements')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

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
                      '${docs[index]["announcement"]}',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        CoolAlert.show(
                            context: context,
                            barrierDismissible: false,
                            type: CoolAlertType.confirm,
                            text:
                            'Do you want to delete this announcement?',
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            confirmBtnColor: Colors.pink[600]!,
                            backgroundColor: Colors.pink[100]!);
                        onConfirmBtnTap:
                            () {
                          FirebaseFirestore.instance
                              .collection('Announcements')
                              .doc(docs[index].id)
                              .delete();
                        }
                        ,
                        );
                      },
                      child: Text(
                        'Delete this announcements',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
