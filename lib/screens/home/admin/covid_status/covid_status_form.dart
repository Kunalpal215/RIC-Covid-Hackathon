import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CovidUpdateForm extends StatefulWidget {
  const CovidUpdateForm({Key? key}) : super(key: key);

  @override
  _CovidUpdateFormState createState() => _CovidUpdateFormState();
}

class _CovidUpdateFormState extends State<CovidUpdateForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> hostels = [
    "Brahmaputra",
    "Dihing",
    "Manas",
    "Lohit",
    "Barak",
    "Umiam",
    "Disang",
    "Dibang",
    "Dhansiri",
    "Subansiri",
    "Kameng"
  ];
  List<String> covid_status = ["positive","negative"];
  String selectedHostel = "Brahmaputra";
  String covidValue="positive";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth * 0.1),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                keyboardType: TextInputType.text,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "This field can't be null";
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hostel",style: TextStyle(fontSize: screenWidth*0.06,fontWeight: FontWeight.bold),),
                    DropdownButton<String>(
                        value: selectedHostel,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: hostels
                            .map((e) => DropdownMenuItem<String>(value: e,child: Text(e),),)
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedHostel = value!;
                          });
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text("Covid Status",style: TextStyle(fontSize: screenWidth*0.06,fontWeight: FontWeight.bold),),
                    DropdownButton<String>(
                        value: covidValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: covid_status
                            .map((e) => DropdownMenuItem<String>(value: e,child: Text(e),),)
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            covidValue = value!;
                          });
                        }),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.1),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Mobile Number"),
                keyboardType: TextInputType.phone,
                controller: mobileController,
                // onChanged: (value){
                //   subject=value;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "This field can't be null";
                  if(value.length!=10) return "Mobile number must be a 10 digit number";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.1),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Roll Number",
                ),
                keyboardType: TextInputType.text,
                controller: rollController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "This field can't be null";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.1),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Room Number",
                ),
                keyboardType: TextInputType.text,
                controller: roomController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "This field can't be null";
                  return null;
                },
              ),
            ),
            GestureDetector(
                onTap: () async {
                  if(formKey.currentState!.validate()){
                     DocumentSnapshot person = await FirebaseFirestore.instance.collection('users').doc("+91"+mobileController.text).get();
                     if(!person.exists){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("This user is not registered with us.")));
                       return;
                     }
                     String earlierStatus = person["covid_status"];
                     if(earlierStatus=="negative" && covidValue=="positive"){
                       FirebaseFirestore.instance.collection('users').doc("+91"+mobileController.text).update({"covid_status":"positive"});
                       FirebaseFirestore.instance.collection('cases').doc("+91"+mobileController.text).set({"Date":DateTime.now(),"Hostel":selectedHostel,"Name":nameController.text,"Roll":rollController.text,"Room":roomController.text});
                     }
                     if(earlierStatus=="positive" && covidValue=="negative"){
                       FirebaseFirestore.instance.collection('users').doc("+91"+mobileController.text).update({"covid_status":"negative"});
                       FirebaseFirestore.instance.collection('cases').doc("+91"+mobileController.text).delete();
                     }
                     Navigator.pop(context);
                  }
                },
                child: Container(
                  color: Colors.blueAccent,
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.15,
                  margin: EdgeInsets.all(screenWidth * 0.1),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
