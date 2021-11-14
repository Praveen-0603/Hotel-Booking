import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  int currentindex = 0;
  final pagecontroller = PageController(
    initialPage: 0,
  );
}
