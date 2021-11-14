import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Controllers/onboard_controller.dart';
import 'package:hotel_booking/Data/onboard_data.dart';
import 'package:hotel_booking/Utils/custom_clipper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(OnboardController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5, top: 10),
              alignment: Alignment.centerRight,
              child: GetBuilder<OnboardController>(builder: (_) {
                return FadeIn(
                  delay: 1.seconds,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                    child: Text(
                      control.currentindex == 2 ? 'Done' : 'Skip',
                      style: const TextStyle(
                        color: Constants.kprimarylight,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Get.offAndToNamed('AuthWrapper');
                      Get.find<FirebaseAuthController>()
                          .getstorage
                          .write('isFirstTime', false);
                    },
                  ),
                );
              }),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    child: SlideInUp(
                      from: 500,
                      duration: 500.milliseconds,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: ClipPath(
                          clipper: RoundedClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.52,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0XFF706de0).withOpacity(0.95),
                                  Constants.kprimarydark,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  PageView.builder(
                    controller: control.pagecontroller,
                    itemCount: 3,
                    onPageChanged: (index) {
                      control.currentindex = index;
                      control.update();
                    },
                    itemBuilder: (context, index) {
                      return _buildimage(
                        image: onboardimages[index],
                        title: onboardtitle[index],
                        info: onboardata[index],
                      );
                    },
                  ),
                  Positioned(
                    bottom: 30,
                    child: GetBuilder<OnboardController>(
                      builder: (_) {
                        return SmoothPageIndicator(
                          controller: control.pagecontroller,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            expansionFactor: 4.0,
                            dotHeight: 5.0,
                            dotWidth: 5.0,
                            activeDotColor: Colors.white,
                            spacing: 6.0,
                            paintStyle: PaintingStyle.fill,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildimage(
    {required String image, required String title, required String info}) {
  return Column(
    children: [
      SlideInDown(
        duration: 500.milliseconds,
        from: 500,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          height: 300,
        ),
      ),
      const SizedBox(height: 50),
      FadeIn(
        duration: 300.milliseconds,
        delay: 0.6.seconds,
        child: Text(
          title,
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: FadeIn(
          duration: 500.milliseconds,
          delay: 0.6.seconds,
          child: Text(
            info,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
              textStyle: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
