import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/home/homepage.dart';
import 'package:tech_media/view/dashboard/profile/profile.dart';
import 'package:tech_media/view/dashboard/users/user_list.dart';
import '../../utils/utils.dart';
import '../../view models/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controler = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScren() {
    return [
      const HomePage(),
      const SafeArea(child: Center(child: Text('Chat'))),
      const SafeArea(child: Center(child: Text('Add post'))),
      const UserListScreen(),
      const ProfileScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navbarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home, color: AppColors.mainAppColor),
          activeColorPrimary: AppColors.mainAppColor,
          inactiveIcon: const Icon(
            Icons.home,
            color: Colors.grey,
          )),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat, color: AppColors.mainAppColor),
          activeColorPrimary: AppColors.mainAppColor,
          inactiveIcon: const Icon(
            Icons.chat,
            color: Colors.grey,
          )),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.add,),
          activeColorPrimary: AppColors.mainAppColor,
          activeColorSecondary: AppColors.whiteColor,


          ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.supervised_user_circle, color: AppColors.mainAppColor),
          activeColorPrimary: AppColors.mainAppColor,
          inactiveIcon: const Icon(
            Icons.supervised_user_circle,
            color: Colors.grey,
          )),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person, color: AppColors.mainAppColor),
          activeColorPrimary: AppColors.mainAppColor,
          inactiveIcon: const Icon(
            Icons.person,
            color: Colors.grey,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return
   PersistentTabView(
          context,
          screens: _buildScren(),
          items: _navbarItem(),
          controller: controler,
          decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
          navBarStyle: NavBarStyle.style15,
          backgroundColor: Colors.grey.shade200,


   );
  }
}
