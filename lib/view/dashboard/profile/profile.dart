import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/view%20models/profile/profile_controller.dart';
import 'package:tech_media/view%20models/services/session_manager.dart';
import 'package:tech_media/view/login/login_screen.dart';

import '../../../utils/routes/route_name.dart';
import '../../../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, provider, child) {
          return Scaffold(

            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: StreamBuilder(
                  stream: ref
                      .child(SessionController().userId.toString())
                      .onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(alignment: Alignment.bottomCenter,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.mainAppColor)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: provider.image == null ?
                                      map['profile'].toString() == " "
                                          ? const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: AppColors.secondaryColor,
                                      )
                                          : Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            map['profile'].toString()),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                              child: CircularProgressIndicator());
                                        },
                                        errorBuilder: (context, object, stack) {
                                          return Container(
                                            child: const Icon(
                                              Icons.error_outline,
                                              color: AppColors.alertColor,
                                            ),
                                          );
                                        },
                                      ): Stack(
                                        alignment: Alignment.center,
                                        children :[


                                        Image.file(

                                            File(
                                                provider.image!.path
                                            )),
                                          const CircularProgressIndicator()
                                        ] ,
                                      )
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.pickImage(context);
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.mainAppColor,
                                    child: Icon(Icons.add, size: 18,
                                      color: AppColors.whiteColor,),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ReusableRow(
                                title: 'Username',
                                value: map['username'],
                                iconData: Icons.person),
                            ReusableRow(
                                title: 'Email',
                                value: map['email'],
                                iconData: Icons.email),
                            ReusableRow(
                                title: 'Phone',
                                value:
                                map['phone'] == ' '
                                    ? 'xxx-xxx-xxx'
                                    : map['phone'],
                                iconData: Icons.phone)
                            , const SizedBox(
                              height: 40,
                            ),
                        RoundedButton(title: 'logout', onPress: (){
                          auth.signOut().then((value) {
                            Navigator.pushNamed(
                                context,
                                "/login" , arguments: 3);
                          }).onError((error, stackTrace) {
                            Utils.toastMessage(error.toString(), AppColors.alertColor);
                          });


                        })
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Something went wrong!',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                      );
                    }
                  }),
            ),
          );
        },
      ),

    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow({Key? key,
    required this.title,
    required this.value,
    required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .bodyText2,
          ),
          leading: Icon(
            iconData,
            color: AppColors.mainAppColor,
          ),
          trailing: Text(
            value,
            style: Theme
                .of(context)
                .textTheme
                .bodyText2,
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
        )
      ],
    );
  }
}
