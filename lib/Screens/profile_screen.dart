import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Controllers/profile_controller.dart';
import 'package:hotel_booking/Screens/profile_overview.dart';
import 'package:hotel_booking/Utils/unfocusser.dart';
import 'package:hotel_booking/Widgets/profile_textfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profilectrl = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 10,
      ),
      body: Unfocuser(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ProfileOverview(
                                url: profilectrl.profileurl.value));
                          },
                          child: CircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.black,
                            child: ClipOval(
                              child: profilectrl.profileurl.value == ''
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, uri) =>
                                          const Center(
                                        child: Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      imageUrl: profilectrl.profileurl.value,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'About Me',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Constants.kprimarycolor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Name',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Text(
                        profilectrl.userdata.value.name!,
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Constants.ksecondarycolor,
                          ),
                        ),
                      ),
                      const Divider(),
                      Text(
                        'Email',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Text(
                        profilectrl.userdata.value.email!,
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Constants.ksecondarycolor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Profile Settings',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Constants.kprimarycolor,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        leading: const Icon(Icons.history,
                            color: Constants.ksecondarycolor),
                        minLeadingWidth: 0,
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Constants.ksecondarycolor),
                        title: const Text('My Bookings',
                            style: TextStyle(color: Constants.ksecondarycolor)),
                        onTap: () {
                          Get.toNamed('Mybookings');
                        },
                      ),
                      const Divider(),
                      ListTile(
                        focusColor: Colors.transparent,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        leading: const Icon(Icons.person_outline_outlined,
                            color: Constants.ksecondarycolor),
                        minLeadingWidth: 0,
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Constants.ksecondarycolor),
                        title: profilectrl.taponchangename.value
                            ? ProfiletextFields(
                                textEditingController:
                                    profilectrl.changenametextctrl,
                                hinttext: 'Enter new Name',
                                keyboard: TextInputType.name,
                                icon1: const Icon(Icons.close),
                                btn1action: () {
                                  profilectrl.taponchangename.value = false;
                                  profilectrl.clear();
                                },
                                icon2: const Icon(Icons.check),
                                btn2action: () {
                                  if (profilectrl
                                      .changenametextctrl.text.isNotEmpty) {
                                    profilectrl.changename(
                                        Get.find<FirebaseAuthController>()
                                            .user
                                            ?.uid,
                                        profilectrl.changenametextctrl.text);
                                  }
                                },
                              )
                            : const Text("Change Username",
                                style: TextStyle(
                                    color: Constants.ksecondarycolor)),
                        onTap: () {
                          if (profilectrl.formstate.value == 'DEFAULT') {
                            profilectrl.taponchangename.value = true;
                          } else {
                            profilectrl.formstate.value = 'DEFAULT';
                            profilectrl.taponchangename.value = true;
                          }
                        },
                      ),
                      const Divider(),
                      ListTile(
                        focusColor: Colors.transparent,
                        leading: const Icon(Icons.lock_outline_rounded,
                            color: Constants.ksecondarycolor),
                        minLeadingWidth: 0,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Constants.ksecondarycolor),
                        title: changepassword(profilectrl),
                        onTap: () {
                          if (profilectrl.taponchangename.value) {
                            profilectrl.taponchangename.value = false;
                            profilectrl.formstate.value = 'CURRENT';
                          } else {
                            profilectrl.formstate.value = 'CURRENT';
                          }
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout,
                            color: Constants.ksecondarycolor),
                        minLeadingWidth: 0,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Constants.ksecondarycolor),
                        title: const Text("Log Out",
                            style: TextStyle(color: Constants.ksecondarycolor)),
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.SCALE,
                            title: 'Logout',
                            desc: 'Are you sure ?',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              await Get.find<FirebaseAuthController>().logout();
                            },
                          ).show();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
