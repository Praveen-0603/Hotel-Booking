import 'package:flutter/material.dart';
import 'package:hotel_booking/Constants/constants.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: Constants.kprimarycolor,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Constants.kprimarycolor,
        ),
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: Constants.kprimarycolor,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Constants.kprimarycolor,
        ),
  );
}
