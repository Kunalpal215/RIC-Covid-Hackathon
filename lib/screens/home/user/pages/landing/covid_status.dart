import 'package:flutter/material.dart';
import 'package:covid_app/constants.dart';


class Covid_Status extends StatefulWidget {

  const Covid_Status({Key? key}) : super(key: key);

  @override
  _Covid_StatusState createState() => _Covid_StatusState();
}

class _Covid_StatusState extends State<Covid_Status> {
  @override
  Widget build(BuildContext context) {

    if (kCurrUser!.covidstatus == "positive") {
      return Card(
        color: Colors.red[800],
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
             ListTile(
              textColor: Colors.white,
              title: Text('Infected',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                  ),
              ),
              // subtitle: Text('Infected',
              //   style: TextStyle(
              //     fontSize: 20,
              //   ),),
            ),
          ],
        ),
      );
    }
    else if(kCurrUser!.covidstatus == "negative"){
      return Card(
        color: Colors.green[800],
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              ListTile(
                textColor: Colors.white,
                title: Text('Safe',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1.8,
                  ),
                ),
                // subtitle: Text('Infected',
                //   style: TextStyle(
                //     fontSize: 20,
                //   ),),
              ),
            ],
          ),
        ),
      );
    }
    else {
      return Card(
        color: Colors.yellow[800],
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              ListTile(
                textColor: Colors.white,
                title: Text('Error',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1.8,
                  ),
                ),
                // subtitle: Text('Infected',
                //   style: TextStyle(
                //     fontSize: 20,
                //   ),),
              ),
            ],
          ),
        ),
      );
    }
  }
}
