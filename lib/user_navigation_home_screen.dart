import 'package:coa_project/home_user.dart';
import 'package:coa_project/user/user_about_screen.dart';
import 'package:coa_project/user/user_account_screen.dart';
import 'package:coa_project/user/user_booking_screen.dart';
import 'package:coa_project/user/user_help_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app_theme.dart';
import 'custom_drawer/drawer_user_controller.dart';
import 'custom_drawer/home_drawer.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  final User user;
  const NavigationHomeScreen({required this.user, super.key});

  @override
  NavigationHomeScreenState createState() => NavigationHomeScreenState();
}

class NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.home;
    screenView = const UserHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.home:
          setState(() {
            screenView = const UserHome();
          });
          break;
        case DrawerIndex.bookking:
          setState(() {
            screenView = const BookingScreen();
          });
          break;
        case DrawerIndex.about:
          setState(() {
            screenView = const AboutScreen();
          });
          break;
        case DrawerIndex.help:
          setState(() {
            screenView = const HelpScreen();
          });
          break;
        case DrawerIndex.account:
          setState(() {
            screenView = const AccountScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
