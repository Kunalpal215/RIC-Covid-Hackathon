import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);
  static const id = "/complaintscreen";
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  String subject="";
  String text="";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(screenWidth*0.1),
                width: screenWidth*0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Subject of complaint"
                  ),
                  onChanged: (value){
                    subject=value;
                  },
                  validator: (value){
                    if(value=="") return "This field can't be null";
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(screenWidth*0.1),
                width: screenWidth*0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Description of complaint"
                  ),
                  onChanged: (value){
                    text=value;
                  },
                  validator: (value){
                    if(value=="") return "This field can't be null";
                    return null;
                  },
                ),
              ),
              GestureDetector(onTap: (){
                if(formKey.currentState!.validate()){
                  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('complaints').add({"timestamp":DateTime.now().microsecondsSinceEpoch,"subject":subject,"text":text,"solved":false,"complaint_date":DateTime.now()});
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your complaint got registered")));
                  Navigator.pop(context);
                }
              }, child: Container(
                color: Colors.blueAccent,
                width: screenWidth*0.1,
                height: screenWidth*0.15,
                margin: EdgeInsets.all(screenWidth*0.1),
                child: Center(
                  child: Text('Submit',style: TextStyle(color: Colors.white),),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
