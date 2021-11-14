import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/signup_controller.dart';
import 'package:hotel_booking/Utils/unfocusser.dart';
import 'package:hotel_booking/Widgets/text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(SignUpController());
    final width = MediaQuery.of(context).size.width;
    return Unfocuser(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 400,
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      width: width,
                      height: 400,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInDown(
                        duration: 500.milliseconds,
                        delay: 0.seconds,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInDown(
                        duration: 500.milliseconds,
                        delay: 0.3.seconds,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 35,
                      child: FadeInDown(
                        duration: 500.milliseconds,
                        delay: 0.6.seconds,
                        child: Container(
                          width: 80,
                          height: 150,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 240,
                      child: FadeInDown(
                        duration: 500.milliseconds,
                        delay: 0.9.seconds,
                        from: 10,
                        child: Text(
                          "Signup",
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    FadeInDown(
                      duration: 500.milliseconds,
                      delay: 1.1.seconds,
                      from: 30,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: GetBuilder<SignUpController>(builder: (_) {
                          return Form(
                            key: control.formkey,
                            autovalidateMode: control.validationmode,
                            child: Column(
                              children: <Widget>[
                                CustomTextField(
                                  hint: 'Name',
                                  action: TextInputAction.next,
                                  keyboard: TextInputType.name,
                                  textEditingController: control.namecontroller,
                                  validator: (value) {
                                    return control.validatename(value);
                                  },
                                ),
                                CustomTextField(
                                  hint: 'Email',
                                  action: TextInputAction.next,
                                  keyboard: TextInputType.emailAddress,
                                  textEditingController:
                                      control.emailcontroller,
                                  validator: (value) {
                                    return control.validateEmail(value);
                                  },
                                ),
                                CustomTextField(
                                  boxDecoration: const BoxDecoration(),
                                  hint: 'Password',
                                  action: TextInputAction.go,
                                  keyboard: TextInputType.visiblePassword,
                                  hidepass: control.hidepass,
                                  textEditingController:
                                      control.passwordcontroller,
                                  validator: (value) {
                                    return control.validatePassword(value);
                                  },
                                  suffix: control.hidepass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  suffixontap: () {
                                    control.hidepass = !control.hidepass;
                                    _.update();
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 70),
                    FadeInDown(
                      duration: 500.milliseconds,
                      delay: 1.3.seconds,
                      from: 50,
                      child: MaterialButton(
                        height: 50,
                        color: Constants.kprimarycolor,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Obx(() {
                          return !control.loading.value
                              ? Text(
                                  "Register",
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                );
                        }),
                        onPressed: () async {
                          await control.register();
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeInDown(
                      duration: 500.milliseconds,
                      delay: 1.5.seconds,
                      from: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: Text(
                          'Back to Login',
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              color: Constants.kprimarydark,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
