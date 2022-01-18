import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySlots extends StatefulWidget {
  const MySlots({Key? key}) : super(key: key);
  static const id = '/myslots';

  @override
  _MySlotsState createState() => _MySlotsState();
}

class _MySlotsState extends State<MySlots> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('My booked slots'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(30, 10),bottomRight: Radius.elliptical(30, 10))
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(kCurrUser!.mobileNumber)
                  .collection('bookings')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return Center(
                      child: Text("No slots have been booked by you!"));
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFDE1AB),
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
                            '${docs[index]["type"].toUpperCase()}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          Divider(),
                          Text(
                            'Location- ${docs[index]["location"] ?? ''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            'Description- ${docs[index]["description"] ?? ''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            'Slot from- ${timeConvert(docs[index]["slot_from"])}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Slot to- ${timeConvert(docs[index]["slot_to"])}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              CoolAlert.show(
                                context: context,
                                barrierDismissible: false,
                                type: CoolAlertType.confirm,
                                text: 'Do you want to delete this booked slot',
                                confirmBtnText: 'Yes',
                                cancelBtnText: 'No',
                                onConfirmBtnTap: () =>
                                    deleteslot(docs[index].id),
                                confirmBtnColor: Colors.orange,
                                backgroundColor: Color(0xFFFDE1AB),
                              );
                            },
                            child: Text(
                              'Delete this booked slot',
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String timeConvert(Timestamp timeInMillis) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        timeInMillis.millisecondsSinceEpoch);
    var formattedtime = DateFormat('dd-MM-yyyy hh:mm a').format(time);
    return formattedtime;
  }

  void deleteslot(String id) {
    Navigator.pop(context);
    setState(() {
      loading = true;
    });
    DocumentReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(kCurrUser!.mobileNumber);
    users.collection('bookings').doc(id).delete().then((value) {
      DocumentReference appointments =
          FirebaseFirestore.instance.collection('appointments').doc(id);
      appointments.collection('bookings').doc(kCurrUser!.mobileNumber).delete().then((value) {
        coolalertsuccess('Deleted successfully');
        setState(() {
          loading = false;
        });
      }).catchError((e) {
        coolalertfailure(e);
        setState(() {
          loading = false;
        });
      });
    }).catchError((e) {
      coolalertfailure(e);
      setState(() {
        loading = false;
      });
    });
  }

  coolalertsuccess(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Success',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.orange,
        backgroundColor: Color(0xFFFDE1AB));
  }

  coolalertfailure(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.orange,
        backgroundColor: Color(0xFFFDE1AB));
  }
}
