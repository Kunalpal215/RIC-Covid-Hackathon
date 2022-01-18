import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ComplaintReply extends StatefulWidget {
  String userId;
  String complaintId;
  bool flag;
  ComplaintReply({required this.userId,required this.complaintId,required this.flag});
  @override
  _ComplaintReplyState createState() => _ComplaintReplyState();
}

class _ComplaintReplyState extends State<ComplaintReply> {
  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text('Complaint Description'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userId)
              .collection('complaints')
              .doc(widget.complaintId)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Container(
              width: screenWidth,
              //height: screenHeight*0.9,
              decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02, vertical: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.02),
                    child: Text(
                      snapshot.data!["subject"],
                      style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.02),
                    child: Text(
                      snapshot.data!["text"],
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                  widget.flag==true ? Container(
                    margin: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth * 0.7,
                          child: TextFormField(
                            controller: _text,
                          ),
                        ),
                        ElevatedButton(
                          child: Text('Send'),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .collection('complaints')
                                .doc(widget.complaintId).update({"solved":true,"reply":_text.text});
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ) : Container(
                    margin: EdgeInsets.all(screenWidth * 0.02),
                    child: Text(
                      "Admin reply : " +
                      snapshot.data!["reply"],
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
