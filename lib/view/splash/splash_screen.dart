// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/view%20models/services/splash_services.dart';

import '../../res/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices services = SplashServices();

  @override
  void initState() {



    // TODO: implement initState
    super.initState();
   services.isLogin(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          // Image(image: AssetImage('assets/images/logo.jpg')),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
                  textAlign: TextAlign.center,
              'Social Media \nApp',
              style: TextStyle(

                  fontFamily: AppFonts.sfProDisplayBold,
                  fontSize: 40,
                  color: Colors. white,
                  fontWeight: FontWeight.w700),
            )),
          )
        ],
      )),
    );
  }
}
