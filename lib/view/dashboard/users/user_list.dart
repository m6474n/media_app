import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/view/dashboard/messages/message_screen.dart';

import '../../../res/color.dart';
import '../../../view models/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('User');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("User List")),
        foregroundColor: Colors.white,
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
        backgroundColor: AppColors.mainAppColor,
      ),
      body: FirebaseAnimatedList(

          query: dbRef,
          defaultChild: const Center(child: CircularProgressIndicator()),
          itemBuilder: (context, snapshot, animation, index) {
            if (SessionController().userId.toString() ==
                snapshot.child('userId').value.toString()) {
              return Container();
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: MessageScreen(
                          image: snapshot.child('profile').value.toString(),
                          receiverId: snapshot.child('userId').value.toString(),
                          name: snapshot.child('username').value.toString(),
                        ),
                        withNavBar: false);
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.mainAppColor)),
                    child: snapshot.child('profile').value.toString() == " "
                        ? Icon(Icons.person)
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            snapshot.child('profile').value.toString()),
                      ),
                    ),
                  ),
                  title: Text(snapshot.child('username').value.toString()),
                  subtitle: Text(snapshot.child('email').value.toString()),
                ),
              );
            }
          }),
    );
  }
}
