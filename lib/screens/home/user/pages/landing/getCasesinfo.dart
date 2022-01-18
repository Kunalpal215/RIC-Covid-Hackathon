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

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Active",
                          style: TextStyle(
                              fontSize: 21
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${storedocs.length}",
                          style: TextStyle(
                              fontSize: 36
                          ),
                        ),
                        Text(
                          "+1",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12,width: 0.7)
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 21
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$totalcasesno",
                          style: TextStyle(
                              fontSize: 36
                          ),
                        ),
                        Text(
                          "+33",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),

              Center(
                child: Text(
                    "The statistics of the cases have been collected from Covid Response Team.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black38
                  ),
                ),
              ),
            ],
          );
        });
  }
}

