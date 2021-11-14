import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hotel_booking/Controllers/login_controller.dart';
import 'package:hotel_booking/Utils/unfocusser.dart';
import 'package:hotel_booking/Widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(LoginController());
    return Unfocuser(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill),
                ),
                child: Stack(
                  children: <Widget>[
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
                      top: 230,
                      child: FadeInDown(
                        duration: 500.milliseconds,
                        delay: 0.8.seconds,
                        from: 50,
                        child: Text(
                          "Login",
                          style: GoogleFonts.sourceSansPro(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInDown(
                      duration: 500.milliseconds,
                      delay: 0.8.seconds,
                      from: 50,
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
                        child: GetBuilder<LoginController>(builder: (_) {
                          return Form(
                            key: control.formkey,
                            autovalidateMode: control.validationmode,
                            child: Column(
                              children: <Widget>[
                                CustomTextField(
                                  hint: 'Email',
                                  keyboard: TextInputType.emailAddress,
                                  action: TextInputAction.next,
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
                                  hidepass: control.hidepass,
                                  keyboard: TextInputType.visiblePassword,
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
                    const SizedBox(height: 20),
                    FadeInDown(
                      duration: 250.milliseconds,
                      delay: 0.9.seconds,
                      from: 50,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot Password ?',
                            style: GoogleFonts.sourceSansPro(
                              textStyle: const TextStyle(
                                color: Constants.kprimarycolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed('ForgotPassword');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    FadeInDown(
                      duration: 500.milliseconds,
                      delay: 1.0.seconds,
                      from: 40,
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
                                  "Login",
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
                        onPressed: () {
                          control.login();
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    FadeInDown(
                      duration: 500.milliseconds,
                      delay: 1.2.seconds,
                      from: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: "Dont't have an Account?",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' SignUp',
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: const TextStyle(
                                    color: Constants.kprimarycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('Signup');
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
