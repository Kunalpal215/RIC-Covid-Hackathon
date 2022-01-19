import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class SlotAddScreen extends StatefulWidget {
  const SlotAddScreen({Key? key}) : super(key: key);

  @override
  _SlotAddScreenState createState() => _SlotAddScreenState();
}

class _SlotAddScreenState extends State<SlotAddScreen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime slot_from = DateTime.now();
  DateTime slot_to = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Type (Covid Test/Vaccination)",
                ),
                keyboardType: TextInputType.text,
                controller: typeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be null";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Description"),
                keyboardType: TextInputType.text,
                controller: descController,
                // onChanged: (value){
                //   subject=value;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be null";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              width: screenWidth * 0.7,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Location",
                ),
                keyboardType: TextInputType.text,
                controller: locationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be null";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              width: screenWidth * 0.7,
              child: DateTimeFormField(
                firstDate: DateTime.now(),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Slot from',
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                initialValue: slot_from,
                validator: (e) {
                  if (slot_from == null) {
                    return "This field can't be null";
                  } else {
                    return null;
                  }
                },
                onDateSelected: (DateTime value) {
                  print(value);
                  slot_from = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              width: screenWidth * 0.7,
              child: DateTimeFormField(
                firstDate: DateTime.now(),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Slot to',
                ),
                initialValue: slot_to,
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) {
                  if (slot_to == null) {
                    return "This field can't be null";
                  } else {
                    return null;
                  }
                },
                onDateSelected: (DateTime value) {
                  print(value);
                  slot_to = value;
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  FirebaseFirestore.instance.collection('appointments').add({
                    "slot_from": slot_from,
                    "slot_to": slot_to,
                    "type": typeController.text,
                    "description": descController.text,
                    "location": locationController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Successfully added this slot")));
                  Navigator.pop(context);
                }
              },
              child: Container(
                color: Colors.pinkAccent,
                width: screenWidth * 0.1,
                height: screenWidth * 0.15,
                margin: EdgeInsets.all(screenWidth * 0.1),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
