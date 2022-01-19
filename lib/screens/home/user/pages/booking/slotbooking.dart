import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/constants.dart';
import 'package:covid_app/screens/home/user/pages/booking/myslots.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotBooking extends StatefulWidget {
  static const id = '/slotbooking';
  static const title='Book a slot';
  const SlotBooking({Key? key}) : super(key: key);

  @override
  _SlotBookingState createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> {
  final DateTime _now = DateTime.now();
  late DateTime _start;
  late DateTime _end;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return loading
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('appointments')
                .where('slot_from', isGreaterThanOrEqualTo: _start).orderBy('slot_from',descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length + 1,
                itemBuilder: (context, index) {

                  if (index != 0) {

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
                            '${docs[index - 1]["type"].toUpperCase()}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          Divider(),
                          Text(
                            'Location- ${docs[index - 1]["location"]??''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            'Description- ${docs[index - 1]["description"]??''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            'Slot from- ${timeConvert(docs[index - 1]["slot_from"])}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Slot to- ${timeConvert(docs[index - 1]["slot_to"])}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              CoolAlert.show(
                                context: context,
                                barrierDismissible: false,
                                type: CoolAlertType.confirm,
                                text: 'Do you want to book this slot',
                                confirmBtnText: 'Yes',
                                cancelBtnText: 'No',
                                onConfirmBtnTap: () => confirmbooking(
                                    docs[index - 1].id, docs[index-1]),
                                  confirmBtnColor: Colors.pink[600]!,
                                  backgroundColor: Colors.pink[100]!
                              );
                            },
                            child: Text(
                              'Book this slot',
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children:[ Container( width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: ()=>Navigator.pushNamed(context,MySlots.id),
                              child: Container(
                            color: Colors.pink[300],
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.15,
                            margin: EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                'VIEW ALL MY BOOKINGS',
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                          )),
                        ),
                  if (docs.isEmpty)
                  Center(
                  child: Text("No Slots are available this time !")),

                        ]
                      ),
                    );
                  }
                },
              );
            },
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    _end = DateTime(_now.year, _now.month, _now.day + 1, 23, 59, 59);
  }

  String timeConvert(Timestamp timeInMillis) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        timeInMillis.millisecondsSinceEpoch);
    var formattedtime = DateFormat('dd-MM-yyyy hh:mm a').format(time);
    return formattedtime;
  }

  void confirmbooking(String id, DocumentSnapshot doc) {
    Navigator.pop(context);
    setState(() {
      loading = true;
    });
    DocumentReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(kCurrUser!.mobileNumber);
    users.collection('bookings').doc(id).set({
      'slotid': id,
      'slot_from': doc['slot_from'],
      'slot_to': doc['slot_to'],
      'type': doc['type'],
      'location': doc['location'],
      'description':doc['description']??''
    }).then((value) {
      DocumentReference appointments =
          FirebaseFirestore.instance.collection('appointments').doc(id);
      appointments.collection('bookings').doc(kCurrUser!.mobileNumber).set({
        'name': kCurrUser!.name,
        'mobile': kCurrUser!.mobileNumber,
        'hostel':kCurrUser!.hostel!,
        'room':kCurrUser!.room!,
        'roll':kCurrUser!.roll!,
      }).then((value) {
        coolalertsuccess('Booked slot successfully');
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
        confirmBtnColor: Colors.pink[600]!,
        backgroundColor: Colors.pink[100]!
    );
  }

  coolalertfailure(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.pink[600]!,
        backgroundColor: Colors.pink[100]!
    );
  }
}
