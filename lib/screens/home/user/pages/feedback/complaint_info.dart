import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ComplaintInfo extends StatefulWidget {
  String docId;
  ComplaintInfo({required this.docId});
  @override
  _ComplaintInfoState createState() => _ComplaintInfoState();
}

class _ComplaintInfoState extends State<ComplaintInfo> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('complaints').doc(widget.docId).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          return Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1,vertical: screenWidth*0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(snapshot.data!["subject"],style: TextStyle(fontSize: 20),),
                Text(snapshot.data!["text"]),
                Text("Reply Status : " + (snapshot.data!["solved"]==true ? "Yes" : "No")),
                snapshot.data!["solved"]==false ? Text("No reply from admin till now!") : Text("Admin Reply : " + snapshot.data!["reply"]),
              ],
            ),
          );
        },
      )
    );
  }
}
