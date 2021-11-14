import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Get.put(OTPController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GetBuilder<OTPController>(builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 40),
                const Image(
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/message.png'),
                ),
                // const SizedBox(height: 80),
                Text(
                  "Verification",
                  style: GoogleFonts.sourceSansPro(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Constants.kprimarydark,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Please enter the 6 digit code sent to \n +93 706-399-999",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey.shade500, height: 1.5),
                ),
                const SizedBox(height: 30),
                VerificationCode(
                    length: 6,
                    autofocus: true,
                    isSecure: true,
                    digitsOnly: true,
                    textStyle: const TextStyle(fontSize: 20),
                    underlineColor: Constants.kprimarydark,
                    fillColor: Colors.black,
                    keyboardType: TextInputType.number,
                    onCompleted: (value) {
                      control.code = value;
                      FocusScope.of(context).unfocus();
                      _.update();
                    },
                    onEditing: (value) {}),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't resive the OTP?",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                    TextButton(
                      onPressed: () {
                        if (control.isResendAgain) return;
                        control.resend();
                      },
                      child: Text(
                        control.isResendAgain
                            ? "Try again in " + control.start.toString()
                            : "Resend",
                        style: const TextStyle(color: Constants.kprimarydark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                MaterialButton(
                  disabledColor: Colors.grey,
                  onPressed: control.code.length < 6
                      ? null
                      : () {
                          control.verify();
                        },
                  color: Constants.kprimarydark,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: 50,
                  child: control.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 3,
                            color: Colors.black,
                          ),
                        )
                      : control.isVerified
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 30,
                            )
                          : const Text(
                              "Verify",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }
}
