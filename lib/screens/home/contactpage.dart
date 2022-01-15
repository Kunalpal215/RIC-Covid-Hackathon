import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

const iOSLocalizedLabels = false;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late Iterable<Contact> _contacts;

  @override
  void initState() {
    super.initState();
  }

//Getting all contact
//   Future<void> getContacts() async {
//     final Iterable<Contact> contacts = await ContactsService.getContacts();
//     setState(() {
//       _contacts = contacts.where((element) => element.phones.toList().length > 0);
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
