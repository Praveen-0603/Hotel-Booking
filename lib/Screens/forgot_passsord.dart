import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/forgot_controller.dart';
import 'package:hotel_booking/Utils/unfocusser.dart';
import 'package:hotel_booking/Widgets/text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(ForgotController());
    return Unfocuser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Forgot Password',
            style: GoogleFonts.sourceSansPro(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              FadeInDown(
                duration: 500.milliseconds,
                child: const Image(
                  height: 300,
                  width: 300,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/forgot-password.png'),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(30),
                child: FadeInDown(
                  duration: 500.milliseconds,
                  delay: 0.3.seconds,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Constants.kprimarylight.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 15),
                          )
                        ]),
                    child: GetBuilder<ForgotController>(builder: (_) {
                      return Form(
                        key: control.formkey,
                        autovalidateMode: control.validationmode,
                        child: CustomTextField(
                          hint: 'Enter your email',
                          boxDecoration: const BoxDecoration(),
                          keyboard: TextInputType.emailAddress,
                          textEditingController: control.emailcontroller,
                          action: TextInputAction.go,
                          validator: (value) {
                            return control.validateEmail(value);
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: FadeInDown(
                  duration: 500.milliseconds,
                  delay: 0.6.seconds,
                  from: 60,
                  child: MaterialButton(
                    height: 50,
                    color: Constants.kprimarycolor,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      "Send Email",
                      style: GoogleFonts.sourceSansPro(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    onPressed: () {
                      control.sendemail();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
