import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/screens/home/admin/covid_status/covid_status_form.dart';
import 'package:flutter/material.dart';

class CovidStatusAdmin extends StatefulWidget {
  const CovidStatusAdmin({Key? key}) : super(key: key);

  @override
  _CovidStatusAdminState createState() => _CovidStatusAdminState();
}

class _CovidStatusAdminState extends State<CovidStatusAdmin> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CovidUpdateForm())),
                child: Container(
                  color: Colors.pink[300],
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.15,
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'ADD CASES',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Covid_Table()
          ],
        ),
      ),
    );
  }
}

class Covid_Table extends StatefulWidget {
  const Covid_Table({Key? key}) : super(key: key);

  @override
  _Covid_TableState createState() => _Covid_TableState();
}

class _Covid_TableState extends State<Covid_Table> {
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
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          var totalcasesno = storedocs.length;

          return Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Card(
                child: Text('Active Cases : ${storedocs.length}',
                    style: TextStyle(fontSize: 20.0)),
              ),
            ),
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
                  TableRow(children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [Text('Name')])),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [Text('Hostel')])),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [Text('Room')]),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [Text('Roll')]),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [Text('Delete')]),
                    ),
                  ]),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        child: Column(children: [
                          Text(storedocs[i]['Name'],
                              style: TextStyle(fontSize: 15.0))
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        child: Column(children: [
                          Text(storedocs[i]['Hostel'],
                              style: TextStyle(fontSize: 15.0))
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        child: Column(children: [
                          Text(storedocs[i]['Room'],
                              style: TextStyle(fontSize: 15.0))
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        child: Column(children: [
                          Text(storedocs[i]['Roll'],
                              style: TextStyle(fontSize: 15.0))
                        ]),
                      ),
                      GestureDetector(
                          onTap: () {
                            CoolAlert.show(
                                context: context,
                                barrierDismissible: false,
                                type: CoolAlertType.confirm,
                                text: 'Do you want to delete',
                                confirmBtnText: 'Yes',
                                cancelBtnText: 'No',
                                onConfirmBtnTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(snapshot.data!.docs[i].id)
                                      .update({"covid_status": "negative"});
                                  await FirebaseFirestore.instance
                                      .collection('cases')
                                      .doc(snapshot.data!.docs[i].id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                confirmBtnColor: Colors.pink[600]!,
                                backgroundColor: Colors.pink[100]!);
                          },
                          child: Icon(Icons.delete)),
                    ]),
                  ],
                ],
              ),
            ),
          ]));
        });
  }
}
