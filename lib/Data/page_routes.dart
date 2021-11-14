import 'package:get/get.dart';
import 'package:hotel_booking/Screens/auth_wrapper.dart';
import 'package:hotel_booking/Screens/confirmation_page.dart';
import 'package:hotel_booking/Screens/forgot_passsord.dart';
import 'package:hotel_booking/Screens/home_screen.dart';
import 'package:hotel_booking/Screens/hotel_details.dart';
import 'package:hotel_booking/Screens/login_screen.dart';
import 'package:hotel_booking/Screens/mybookings_screen.dart';
import 'package:hotel_booking/Screens/notification_screen.dart';
import 'package:hotel_booking/Screens/onboarding_screen.dart';
import 'package:hotel_booking/Screens/otp_screen.dart';
import 'package:hotel_booking/Screens/popular_hotels.dart';
import 'package:hotel_booking/Screens/profile_screen.dart';
import 'package:hotel_booking/Screens/settings_screen.dart';
import 'package:hotel_booking/Screens/signup_screen.dart';
import 'package:hotel_booking/Screens/terms_conditions.dart';
import 'package:hotel_booking/Screens/wrapper.dart';

class PageRoutes {
  static List<GetPage> pages = [
    GetPage(name: '/', page: () => const Wrapper()),
    GetPage(name: '/AuthWrapper', page: () => const AuthWrapper()),
    GetPage(name: '/Login', page: () => const LoginScreen()),
    GetPage(name: '/Signup', page: () => const SignUpScreen()),
    GetPage(name: '/OTP', page: () => const OTPScreen()),
    GetPage(name: '/Home', page: () => const HomeScreen()),
    GetPage(name: '/OnBoarding', page: () => const OnboardingScreen()),
    GetPage(name: '/ForgotPassword', page: () => const ForgotPasswordScreen()),
    GetPage(name: '/HotelDetails', page: () => const HotelDetailsScreen()),
    GetPage(name: '/ConfirmationPage', page: () => const ConfirmationScreen()),
    GetPage(name: '/ProfilePage', page: () => const ProfileScreen()),
    GetPage(name: '/Notifications', page: () => const NotificationScreen()),
    GetPage(name: '/Mybookings', page: () => const MyBookingScreen()),
    GetPage(name: '/Settings', page: () => const SettingScreen()),
    GetPage(name: '/Popularhotels', page: () => PopularHotelsScreen()),
    GetPage(name: '/Terms', page: () => const TermsandConditionsPage()),
  ];
}
