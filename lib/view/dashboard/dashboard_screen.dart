import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../utils/utils.dart';
import '../../view models/services/session_manager.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(SessionController().userId.toString()),

      actions: [TextButton(onPressed: (){
        auth.signOut().then((value) {
          Navigator.pushNamed(context, RouteName.loginView);
          Utils.toastMessage('Logout!', AppColors.alertColor);
        }).onError((error, stackTrace){
          Utils.toastMessage(error.toString(), AppColors.alertColor);
        });
      }, child: Icon(Icons.logout_outlined, color: Colors.red,))],
      automaticallyImplyLeading: false,
      ),
      body: Column(children: [
       Text('hello')
      ],),
    );
  }
}
