import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coa_project/admin/admin_account.dart';
import 'package:coa_project/home_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_theme.dart';
import 'admin/admin_management.dart';
import 'custom_drawer/admin_drawer_user_controller.dart';
import 'custom_drawer/admin_home_drawer.dart';
import 'package:flutter/material.dart';
import 'models/user_model.dart';

class AdminNavigationHomeScreen extends StatefulWidget {
  final User user;
  const AdminNavigationHomeScreen({required this.user, super.key});

  @override
  AdminNavigationHomeScreenState createState() => AdminNavigationHomeScreenState();
}

class AdminNavigationHomeScreenState extends State<AdminNavigationHomeScreen> {
  Widget? screenView;
  DrawerIndexAdmin? drawerIndex;
  AppUser? appUser;

  //ユーザ情報を取得して構造体に格納
  //この先複数回のアクセスを防ぐため
  Future<void> _setUser(User user) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('register').doc('user').get();
    String snapName = snapshot['name'];
    String snapPhone = snapshot['phone'];
    String snapEmail = snapshot['email'];

    appUser = AppUser(snapName, snapPhone, snapEmail);
  }

  @override
  void initState() {
    _setUser(widget.user);
    drawerIndex = DrawerIndexAdmin.home;
    screenView = const AdminHome();
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
          body: AdminDrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndexAdmin drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndexAdmin drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndexAdmin.home:
          setState(() {
            screenView = const AdminHome();
          });
          break;
        case DrawerIndexAdmin.account:
          setState(() {
            screenView = const AdminAccountScreen();
          });
          break;
        case DrawerIndexAdmin.manage:
          setState(() {
            screenView = const AminManagementScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
