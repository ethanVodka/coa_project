import 'package:flutter/material.dart';

class UserHomeList {
  UserHomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<UserHomeList> homeList = [
    UserHomeList(
      imagePath: 'assets/images/text_logo_opa.png',
      //navigateScreen: DesignCourseHomeScreen(),
    ),
    UserHomeList(
      imagePath: 'assets/images/cocktail_1.png',
      //navigateScreen: IntroductionAnimationScreen(),
    ),
    UserHomeList(
      imagePath: 'assets/images/cocktail_2.png',
      //navigateScreen: HotelHomeScreen(),
    ),
    UserHomeList(
      imagePath: 'assets/images/cocktail_3.png',
      //navigateScreen: FitnessAppHomeScreen(),
    ),
    UserHomeList(
      imagePath: 'assets/images/entrance.png',
      //navigateScreen: DesignCourseHomeScreen(),
    ),
  ];
}
