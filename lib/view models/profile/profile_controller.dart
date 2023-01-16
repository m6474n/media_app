import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view%20models/services/session_manager.dart';

import '../../utils/utils.dart';
class ProfileController with ChangeNotifier {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('Users');
firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

bool _loading = false ;
bool get loading  => _loading;
 setLoading(bool value){
   _loading = value;
   notifyListeners();

 }


final picker = ImagePicker();
File? _image ;

File? get image => _image;


Future pickGalleryImage(BuildContext context)async{
  final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

  if(pickedFile != null){
    _image = File(pickedFile.path);
    uploadImage(context);
    notifyListeners();
  }

}Future pickCameraImage(BuildContext context)async{
  final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

  if(pickedFile != null){
    _image = File(pickedFile.path);
    uploadImage(context);

    notifyListeners();
  }

}
  void pickImage(context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            children: [ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                pickCameraImage(context);
              },
            ),ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);

                pickGalleryImage(context);
              },
            ),
            ],
          ),
        ),
      );
    });
  }
void uploadImage(BuildContext context)async{
  setLoading(true);
firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/Profile Image - '+SessionController().userId.toString());
firebase_storage.UploadTask uploadTask = ref.putFile(File(image!.path));
await Future.value(uploadTask);
final newUrl = await ref.getDownloadURL();

dbRef.child(SessionController().userId.toString()).update({
  'profile' : newUrl.toString()
}).then((value){
  setLoading(false);
  _image = null;
  Utils.toastMessage('Profile Updated', AppColors.primaryColor);
}).onError((error, stackTrace){
  setLoading(false);

  Utils.toastMessage(error.toString(), AppColors.alertColor);
});
}

}