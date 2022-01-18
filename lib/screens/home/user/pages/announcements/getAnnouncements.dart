import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Announcement {

  String text;
  String author;
  String Subject;
  DateTime time;

  Announcement({required this.Subject, required this.text, required this.author,required this.time });
}

class QuoteCard extends StatelessWidget {

  final Announcement quote;
  QuoteCard({ required this.quote });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.Subject,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("From : " +
                    quote.author,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(quote.time.day.toString()+"/"+quote.time.month.toString()+"/"+quote.time.year.toString()),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        )
    );
  }
}

