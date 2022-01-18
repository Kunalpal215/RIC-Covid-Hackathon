import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/screens/home/user/pages/announcements/getAnnouncements.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetAnnouncements extends StatefulWidget {
  const GetAnnouncements({Key? key}) : super(key: key);

  @override
  _GetAnnouncementsState createState() => _GetAnnouncementsState();
}

class _GetAnnouncementsState extends State<GetAnnouncements> {
  @override
  Widget build(BuildContext context) {
    return           StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Announcements')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: CarouselSlider.builder(
              itemCount: storedocs.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: false,
              ),
              itemBuilder: (context, index, realIdx) {
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${storedocs[index]['subject']}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Divider(),
                        Text(
                          'Description - ${storedocs[index]['announcement']}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                        Text(
                          'Author - ${storedocs[index]['author']??''}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          '${timeConvert(storedocs[index]['TimeStamp'])}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                     ],   )

                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
  String timeConvert(Timestamp timeInMillis) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        timeInMillis.millisecondsSinceEpoch);
    var formattedtime = DateFormat('dd-MM-yy').format(time);
    return formattedtime;
  }
}
