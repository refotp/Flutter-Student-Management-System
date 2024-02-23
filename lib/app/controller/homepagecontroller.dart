import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  HomePageController get instance => Get.find();

  var scaffoldState = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldState.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldState.currentState?.closeDrawer();
  }
}
