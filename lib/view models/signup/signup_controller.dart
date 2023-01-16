import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../../res/color.dart';
import '../services/session_manager.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Users');

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signup(BuildContext context , String username, String email, String password) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();

        databaseRef
            .child(value.user!.uid.toString())
            .set({
          'uid:' : value.user!.uid.toString(),
          'email' : value.user!.email.toString(),
          'onlineStatus' : 'onOne',
          'phone' : ' ',
          'profile' : ' ',
          'username' : username,


        })
            .then((value) {
          setLoading(false);
          Navigator.pushNamed(context, RouteName.dashboardView);
        })
            .onError((error, stackTrace) {
          Utils.toastMessage(error.toString(), AppColors.alertColor);
          setLoading(false);
        });
        Utils.toastMessage(
            'User Created Successfully!', AppColors.primaryMaterialColor);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString(), AppColors.alertColor);
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString(), AppColors.primaryMaterialColor);
    }
  }
}
