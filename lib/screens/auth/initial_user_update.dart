import 'package:covid_app/constants.dart';
import 'package:covid_app/screens/home/user/home_screen.dart';
import 'package:covid_app/services/load_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialUserUpdate extends StatefulWidget {
  const InitialUserUpdate({Key? key,required this.mobileNumber}) : super(key: key);
  final String mobileNumber;
  @override
  _InitialUserUpdateState createState() => _InitialUserUpdateState();
}

class _InitialUserUpdateState extends State<InitialUserUpdate> {
  final _formKey2 = GlobalKey<FormState>();
  var covis_status = ['positive', 'negative'];
  var vaccine_status = ['zero', 'single', 'double', 'third'];
  String dropdownvaluevaccinestatus = 'zero';
  String dropdownvaluecovidstatus = 'negative';
  TextEditingController namecontroller=new TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: AlertDialog(
        title: const Text('Update Profile'),
        content: loading?Center(child:CircularProgressIndicator()):Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Form(
              key: _formKey2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: namecontroller,
                            onChanged: (text) => kCurrUser!.name = text,
                            decoration: const InputDecoration(
                                hintText: "Enter your Name"),
                            enabled: true,
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'Enter name';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(4.0),
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
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: DropdownButton<String>(
                              // Initial Value
                              value: dropdownvaluecovidstatus,

                              // Down Arrow Icon
                              icon: const Icon(
                                  Icons.keyboard_arrow_down),

                              // Array list of items
                              items:
                              covis_status.map((String items) {
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
                                  kCurrUser!.covidstatus=dropdownvaluecovidstatus;
                                });
                              },
                            ),
                            flex: 2,
                          ),
                          Flexible(
                            child: DropdownButton<String>(
                              // Initial Value
                              value: dropdownvaluevaccinestatus,

                              // Down Arrow Icon
                              icon: const Icon(
                                  Icons.keyboard_arrow_down),

                              // Array list of items
                              items: vaccine_status
                                  .map((String items) {
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
                                  kCurrUser!.vaccinestatus=dropdownvaluevaccinestatus;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      child: Text("Update Profile"),
                      onPressed: () async {
                        if (_formKey2.currentState!.validate()) {
                          await routescreen(widget.mobileNumber,namecontroller.text,);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> routescreen(String mobileNumber,String name) async {
    setState(() {
      loading=true;
    });
    await loadUser(mobileNumber, name, dropdownvaluecovidstatus, dropdownvaluevaccinestatus);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', mobileNumber);
    print(mobileNumber);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
  }
}
