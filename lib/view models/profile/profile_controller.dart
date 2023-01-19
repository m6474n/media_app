import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/input_Text.dart';
import 'package:tech_media/view%20models/services/session_manager.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class ProfileController with ChangeNotifier {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('User');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final usernameController = TextEditingController();
  final usernamefocusNode = FocusNode();
  final phoneController = TextEditingController();
  final phonefocusNode = FocusNode();

// final userFocusNode = focusNode;
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final picker = ImagePicker();
  File? _image;

  File? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);

      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      pickCameraImage(context);
                    },
                  ),
                  ListTile(
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

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/Profile Image - ' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask = ref.putFile(File(image!.path));
    await Future.value(uploadTask);
    final newUrl = await ref.getDownloadURL();

    dbRef
        .child(SessionController().userId.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      setLoading(false);
      _image = null;
      Utils.toastMessage('Profile Updated', AppColors.primaryColor);
    }).onError((error, stackTrace) {
      setLoading(false);

      Utils.toastMessage(error.toString(), AppColors.alertColor);
    });
  }

  Future<void> showUsernameDialogAlert(BuildContext context, String name) {
    usernameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Username'),
            content: InputTextField(
              myController: usernameController,
              focusNode: usernamefocusNode,
              onFiledSubmittedValue: (value) {},
              onValidator: (value) {},
              keyboardType: TextInputType.name,
              hint: 'Enter Username',
              obscureText: false,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    dbRef.child(SessionController().userId.toString()).update(
                        {'username': usernameController.text}).then((value) {
                      usernameController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }
  Future<void> showPhoneDialogAlert(BuildContext context, String phone){
    phoneController.text = phone;
    return showDialog(context: context,
        builder: (context){
      return AlertDialog(
        title: Text('Update Phone Number'),
        content: InputTextField(
          myController: phoneController,
          focusNode: phonefocusNode,
          onFiledSubmittedValue: (value) {},
          onValidator: (value) {},
          keyboardType: TextInputType.phone,
          hint: 'Enter Phone',
          obscureText: false,
        ),
        actions: [
          TextButton(
              onPressed: () {
                dbRef.child(SessionController().userId.toString()).update(
                    {'phone': phoneController.text}).then((value) {
                  phoneController.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Ok')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
        ],
      );

        });
  }
 }
