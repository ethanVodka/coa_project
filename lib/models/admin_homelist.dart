import 'package:flutter/material.dart';

class AdminHomeList {
  AdminHomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<AdminHomeList> homeList = [
    AdminHomeList(
      imagePath: 'assets/images/manage.png',
      //navigateScreen: DesignCourseHomeScreen(),
    ),
    AdminHomeList(
      imagePath: 'assets/images/cocktail_1.png',
      //navigateScreen: IntroductionAnimationScreen(),
    ),
    AdminHomeList(
      imagePath: 'assets/images/cocktail_2.png',
      //navigateScreen: HotelHomeScreen(),
    ),
    AdminHomeList(
      imagePath: 'assets/images/cocktail_3.png',
      //navigateScreen: FitnessAppHomeScreen(),
    ),
    AdminHomeList(
      imagePath: 'assets/images/entrance.png',
      //navigateScreen: DesignCourseHomeScreen(),
    ),
  ];
}
