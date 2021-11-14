import 'package:flutter/material.dart';
import 'package:hotel_booking/Constants/constants.dart';
import 'package:hotel_booking/Controllers/profile_controller.dart';

Widget changepassword(ProfileController control) {
  if (control.formstate.value == 'CURRENT') {
    return ProfiletextFields(
      textEditingController: control.checkpassword,
      hinttext: 'Enter Current Password',
      icon1: const Icon(
        Icons.close,
      ),
      btn1action: () {
        control.formstate.value = 'DEFAULT';
        control.clear();
      },
      icon2: control.loading.value
          ? const Padding(
              padding: EdgeInsets.all(6),
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.arrow_forward),
      btn2action: () async {
        if (control.checkpassword.text.isNotEmpty) {
          await control.validatepassword(control.checkpassword.text);
        }
        if (control.currentpassstatus.value) {
          control.formstate.value = 'NEWPASS';
        }
      },
    );
  } else if (control.formstate.value == 'NEWPASS') {
    return Form(
      key: control.firstpasskey,
      autovalidateMode: control.autovalid.value,
      child: ProfiletextFields(
        textEditingController: control.firstnewpassctrl,
        hinttext: 'Enter new Password',
        icon1: const Icon(Icons.close),
        btn1action: () {
          control.formstate.value = 'DEFAULT';
          control.clear();
        },
        icon2: const Icon(Icons.arrow_forward),
        btn2action: () {
          if (control.checkvalidation()) {
            control.formstate.value = 'AGAIN';
          }
        },
        onChanged: (value) {
          control.newpassword = value;
        },
        validator: (value) {
          return control.checknewpass(value!);
        },
      ),
    );
  } else if (control.formstate.value == 'AGAIN') {
    return Form(
      key: control.secondpasskey,
      autovalidateMode: control.autovalid.value,
      child: ProfiletextFields(
        textEditingController: control.secondnewpassctrl,
        hinttext: 'Enter Password again',
        obscure: true,
        icon1: const Icon(Icons.arrow_back),
        btn1action: () {
          control.formstate.value = 'NEWPASS';
        },
        icon2: control.loading.value
            ? const Padding(
                padding: EdgeInsets.all(6),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.check),
        btn2action: () {
          if (control.checkvalidationagain()) {
            control.updatepassword(control.newpassword);
          }
        },
        onChanged: (value) {
          control.newpassword2 = value;
        },
        validator: (value) {
          return control.checknewpassmatch(value!);
        },
      ),
    );
  }
  return const Text('Change Password',
      style: TextStyle(color: Constants.ksecondarycolor));
}

class ProfiletextFields extends StatelessWidget {
  const ProfiletextFields({
    Key? key,
    required this.textEditingController,
    required this.hinttext,
    required this.btn1action,
    required this.btn2action,
    required this.icon1,
    required this.icon2,
    this.keyboard = TextInputType.visiblePassword,
    this.obscure = false,
    this.onsubmitted,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hinttext;
  final Function() btn1action;
  final Function() btn2action;
  final Widget icon1;
  final Widget icon2;
  final Function(String)? onChanged;
  final Function(String)? onsubmitted;
  final String? Function(String?)? validator;
  final bool obscure;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      keyboardType: keyboard,
      controller: textEditingController,
      autofocus: true,
      textInputAction: TextInputAction.go,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onsubmitted,
      decoration: InputDecoration(
        hintText: hinttext,
        border: InputBorder.none,
        suffixIcon: Theme(
          data: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.black,
                ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: btn1action,
                icon: icon1,
              ),
              IconButton(
                onPressed: btn2action,
                icon: icon2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
