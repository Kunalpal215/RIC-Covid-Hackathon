import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/screens/home/user/pages/feedback/complaint_info.dart';
import 'package:covid_app/screens/home/user/pages/feedback/complaint_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ComplaintListScreen extends StatefulWidget {
  const ComplaintListScreen({Key? key}) : super(key: key);

  @override
  _ComplaintListScreenState createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('complaints').orderBy('timestamp',descending: true).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          if(docs.length==0){
            return Center(child: Text("No complaints registered from you!"));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComplaintInfo(docId: docs[index].id,)));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  color: Colors.yellow,
                  child: Column(
                    children: [
                      Text(docs[index]["subject"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Reply Status : " + (docs[index]["solved"]==true ? "Yes" : "No")),
                          Text(docs[index]["complaint_date"].toDate().day.toString() + "/" + docs[index]["complaint_date"].toDate().month.toString() + "/" + docs[index]["complaint_date"].toDate().year.toString()),
                        ],
                      ),
                      Text(docs[index]["text"]),
                    ],
                  ),
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
}
