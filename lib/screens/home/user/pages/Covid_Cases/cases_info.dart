import 'package:flutter/material.dart';
import 'package:covid_app/screens/home/user/pages/Covid_Cases/cases_table.dart';


class Cases_info extends StatefulWidget {
  static const id = '/Cases_info';
  const Cases_info({Key? key}) : super(key: key);

  @override
  _Cases_infoState createState() => _Cases_infoState();
}

class _Cases_infoState extends State<Cases_info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Status'),
      ),
      body: Covid_Table()
    );
  }
}
