import 'package:flutter/material.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/images/text_logo_opa.png',
      //navigateScreen: DesignCourseHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/cocktail_1.png',
      //navigateScreen: IntroductionAnimationScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/cocktail_2.png',
      //navigateScreen: HotelHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/cocktail_3.png',
      //navigateScreen: FitnessAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/entrance.png',
      //navigateScreen: DesignCourseHomeScreen(),
    ),
  ];
}
