import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Totalcases extends StatefulWidget {
  const Totalcases({Key? key}) : super(key: key);

  @override
  _TotalcasesState createState() => _TotalcasesState();
}

class _TotalcasesState extends State<Totalcases> {

  final Stream<QuerySnapshot> studentsStream =
          FirebaseFirestore.instance.collection('cases').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [CircularProgressIndicator()],
            ) ;
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          var totalcasesno = (storedocs.removeAt(0))['Total Cases'];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${storedocs.length}",
                      style: TextStyle(
                          fontSize: 38
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Active Cases",
                      style: TextStyle(
                          fontSize: 22
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$totalcasesno",
                      style: TextStyle(
                          fontSize: 38
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Total cases",
                      style: TextStyle(
                          fontSize: 22
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}

