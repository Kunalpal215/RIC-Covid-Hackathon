// Importing Packages
import 'package:image_picker/image_picker.dart';

// Pick image from camera
Future pickImageFromCamera() async{
  final ImagePicker picker = ImagePicker();
  try{
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 150,
    );
    return pickedFile;
  }
  catch (err){
    print(err);
  }
}

// Pick image from gallery
Future pickImageFromGallery() async{
  final ImagePicker picker = ImagePicker();
  try{
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 150,
    );
    return pickedFile;
  }
  catch (err){
    print(err);
  }
}