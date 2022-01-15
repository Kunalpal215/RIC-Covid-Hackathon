// Importing Packages
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:covid_app/constants.dart';
import 'package:image_picker/image_picker.dart';

// Importing Services
import 'package:covid_app/services/pick_image.dart';
import 'package:covid_app/services/load_user.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = '/edit';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  File image = File(kProfileImagePath!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Your Profile',
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image(
                image: FileImage(
                  image,
                ),
              ),
              radius: 100,
            ),
            Text(
              kCurrUser!.mobileNumber,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: kCurrUser!.name
              ),
              onChanged: (val){
                if(val != ''){
                  kCurrUser!.name = val;
                }
              },
            ),
            ElevatedButton(
              child: Text(
                'Upload from Camera',
              ),
              onPressed: () async{
                final PickedFile newImage = await pickImageFromCamera();
                setState(() {
                  if(newImage != null){
                    image = File(newImage.path);
                  }
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Upload from Gallery',
              ),
              onPressed: () async{
                final PickedFile newImage = await pickImageFromGallery();
                setState(() {
                  if(newImage != null){
                    image = File(newImage.path);
                  }
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.check,
        ),
        onPressed: () async{
          await kCurrUser!.createAndUpdateDocument();
          await kCurrUser!.retrieveDocument();
          await image.copy(kProfileImagePath!);
          await kCurrUser!.uploadProfileImage();
          await kCurrUser!.downloadProfileImage();
          await loadUser(kCurrUser!.mobileNumber);
          Navigator.pop(context);
        },
      ),
    );
  }
}
