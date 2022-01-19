import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SlotUsers extends StatefulWidget {
  const SlotUsers({Key? key,required this.id}) : super(key: key);
final String id;
  @override
  _SlotUsersState createState() => _SlotUsersState();
}

class _SlotUsersState extends State<SlotUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Booked Users')),
      body:ListView(

        children:[ StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance.collection('appointments').doc(widget.id).collection('bookings').snapshots(),

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
    List<QueryDocumentSnapshot> storedocs = snapshot.data!.docs;

            return Center(
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      // defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          borderRadius: BorderRadius.circular(3),
                          width: 0.6),
                      children: [

                        TableRow(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(children:[Text('Name')])
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child:Column(children:[Text('Hostel')])
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child:Column(children:[Text('Room')]),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child:Column(children:[Text('Roll')]),
                              ),


                            ]),
                        for (var i = 0; i < storedocs.length; i++) ...[
                          TableRow( children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              child:Column(children:[Text(storedocs[i]['name'] , style: TextStyle(fontSize: 15.0)) ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child:Column(children:[Text(storedocs[i]['hostel'] , style: TextStyle(fontSize: 15.0)) ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child:Column(children:[Text(storedocs[i]['room'] , style: TextStyle(fontSize: 15.0)) ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child:Column(children:[Text(storedocs[i]['roll'] , style: TextStyle(fontSize: 15.0)) ]),
                            ),




                          ]),
                        ],
                      ],
                    ),
                  ),
                ])
            );
          }),],
      ),
    );
  }
}
