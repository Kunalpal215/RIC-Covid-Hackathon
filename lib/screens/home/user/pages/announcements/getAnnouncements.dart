import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Quote {

  String text;
  String author;
  String Subject;
  DateTime time;

  Quote({required this.Subject, required this.text, required this.author,required this.time });
}

class QuoteCard extends StatelessWidget {

  final Quote quote;
  QuoteCard({ required this.quote });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.Subject,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("From : " +
                    quote.author,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(quote.time.day.toString()+"/"+quote.time.month.toString()+"/"+quote.time.year.toString()),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        )
    );
  }
}

class ListAnnouncements extends StatefulWidget {
  const ListAnnouncements({Key? key}) : super(key: key);

  @override
  _ListAnnouncementsState createState() => _ListAnnouncementsState();
}

class _ListAnnouncementsState extends State<ListAnnouncements> {

  final Stream<QuerySnapshot> studentsStream =
        FirebaseFirestore.instance.collection('Announcements').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          
          for (var i = 0; i < storedocs.length; i++){
            var temp = new Quote(Subject: storedocs[i]['subject'],text: storedocs[i]['announcement'] , author: storedocs[i]['author'], time: storedocs[i]['TimeStamp'].toDate());
            storedocs[i] = QuoteCard(quote: temp);
          }

          return Container(
            child: ListView.builder(
              itemCount: storedocs.length,
              itemBuilder: (BuildContext context, int index) {
                return storedocs[index];
              }),
          );
        });
  }
}
