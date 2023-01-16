import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../../res/color.dart';
import '../services/session_manager.dart';

class LoginController with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(
      BuildContext context,  String email, String password) {
    setLoading(true);
    try {
      auth
       .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.dashboardView);
        SessionController().userId = value.user!.uid.toString();

        Utils.toastMessage(
            'Login Successfully!', AppColors.primaryMaterialColor);
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
