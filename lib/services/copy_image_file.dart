// Importing Packages
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Importing Firebase Packages
import 'package:firebase_storage/firebase_storage.dart';

// Copies an image file from 'from' path to 'to' path within Firebase Storage
Future copyImageFile(String from, String to) async{
  Directory appDirectory = await getApplicationDocumentsDirectory();
  String localImagePath = '${appDirectory.path}/temp.png';
  File localImageFile = File(localImagePath);
  try{
    await FirebaseStorage.instance
        .ref(from)
        .writeToFile(localImageFile);
    try{
      await FirebaseStorage.instance
          .ref(to)
          .putFile(localImageFile);
    } on FirebaseException catch (err){
      print(err);
    }
  } on FirebaseException catch (err){
    print(err);
  }
}