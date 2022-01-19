// Importing Packages

import 'dart:io';

import 'package:covid_app/constants.dart';
import 'package:covid_app/services/load_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile';
  static const title = 'My Profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _status = true;
  bool loading = false;
  final FocusNode myFocusNode = FocusNode();
  late Map<String, dynamic> userdata;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController hostel = TextEditingController();
  TextEditingController room = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController vaccineController = TextEditingController();
  TextEditingController covidStatusController = TextEditingController();
  final keys = GlobalKey<FormState>();

  @override
  void initState() {
    namecontroller.text = kCurrUser!.name!;
    phonecontroller.text = kCurrUser!.mobileNumber;
    hostel.text = kCurrUser!.hostel!;
    roll.text = kCurrUser!.roll!;
    room.text = kCurrUser!.room!;
    dropdownvaluevaccinestatus = kCurrUser!.vaccinestatus!;
    dropdownvaluecovidstatus = kCurrUser!.covidstatus!;
  }

  var covis_status = ['positive', 'negative'];
  var vaccine_status = ['zero', 'single', 'double', 'third'];
  late String dropdownvaluevaccinestatus;
  late String dropdownvaluecovidstatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: keys,
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.png'
                                  ),
                                ),
                              ),

                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status ? _getEditIcon() : Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      controller: namecontroller,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Field cant be null';
                                        }
                                      },
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Hostel',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Field cant be null';
                                        }
                                      },
                                      controller: hostel,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Hostel",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Room number',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Field cant be null';
                                        }
                                      },
                                      controller: room,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Room nuumber",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              ),
                            ), Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Roll',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Field cant be null';
                                        }
                                      },
                                      controller: roll,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Roll no.",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Mobile',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: phonecontroller,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Mobile Number"),
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Covid Status',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      child: Text(
                                        'Vaccine Status',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: IgnorePointer(
                                      ignoring: true,
                                      child: DropdownButton<String>(
                                        // Initial Value
                                        value: dropdownvaluecovidstatus,

                                        // Down Arrow Icon
                                        icon: Container(),

                                        // Array list of items
                                        items: covis_status.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvaluecovidstatus =
                                                newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: IgnorePointer(
                                      ignoring: _status,
                                      child: DropdownButton<String>(
                                        // Initial Value
                                        value: dropdownvaluevaccinestatus,

                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items:
                                            vaccine_status.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvaluevaccinestatus =
                                                newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            !_status ? _getActionButtons() : Container(),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: RaisedButton(
                child: Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  if (keys.currentState!.validate()) {
                    setState(() {
                      _status = true;

                      FocusScope.of(context).requestFocus(FocusNode());
                      loading = true;
                    });
                    kCurrUser!.name = namecontroller.text;

                    kCurrUser!.covidstatus = dropdownvaluecovidstatus;
                    kCurrUser!.vaccinestatus = dropdownvaluevaccinestatus;
                    await kCurrUser!.updatedocument(
                        kCurrUser!.mobileNumber,
                        namecontroller.text,

                        dropdownvaluecovidstatus,
                        dropdownvaluevaccinestatus, hostel.text,
                      room.text,
                      roll.text,);
                    await kCurrUser!.retrieveDocument();
                    await loadUser(kCurrUser!.mobileNumber, null, null, null,null,null,null);
                    setState(() {
                      loading = false;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.pink[200],
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
