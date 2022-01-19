import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AnnouncementMakeScreen extends StatefulWidget {
  const AnnouncementMakeScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementMakeScreenState createState() => _AnnouncementMakeScreenState();
}

class _AnnouncementMakeScreenState extends State<AnnouncementMakeScreen> {
  TextEditingController authorController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth*0.1),
              width: screenWidth*0.7,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Your Name",
                ),
                keyboardType: TextInputType.text,
                controller: authorController,
                validator: (value){
                  if(value==null || value.isEmpty) return "This field can't be null";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth*0.1),
              width: screenWidth*0.7,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Subject"
                ),
                keyboardType: TextInputType.text,
                controller: subjectController,
                // onChanged: (value){
                //   subject=value;
                // },
                validator: (value){
                  if(value==null || value.isEmpty) return "This field can't be null";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth*0.1),
              width: screenWidth*0.7,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Description",
                ),
                keyboardType: TextInputType.text,
                controller: textController,
                validator: (value){
                  if(value==null || value.isEmpty) return "This field can't be null";
                  return null;
                },
              ),
            ),
            GestureDetector(onTap: (){
              if(formKey.currentState!.validate()){
                FirebaseFirestore.instance.collection('Announcements').add({"TimeStamp":DateTime.now(),"announcement":textController.text,"author":authorController.text,"subject": subjectController.text ,"email": FirebaseAuth.instance.currentUser!.email});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully made the announcement")));
                Navigator.pop(context);
              }
            }, child: Container(
              color: Colors.pinkAccent,
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
    );
  }
}
