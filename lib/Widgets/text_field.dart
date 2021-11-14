import 'package:flutter/material.dart';
import 'package:hotel_booking/Constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.keyboard,
    required this.textEditingController,
    required this.validator,
    this.boxDecoration,
    this.suffixontap,
    this.suffix,
    this.hidepass = false,
    required this.action,
  }) : super(key: key);
  final String hint;
  final TextInputType keyboard;
  final TextInputAction action;
  final BoxDecoration? boxDecoration;
  final FormFieldValidator validator;
  final VoidCallback? suffixontap;
  final IconData? suffix;
  final bool hidepass;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: boxDecoration ??
          BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: TextFormField(
        textInputAction: action,
        cursorColor: Constants.kprimarylight,
        controller: textEditingController,
        keyboardType: keyboard,
        validator: validator,
        obscureText: hidepass,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: GestureDetector(
            child: Icon(suffix),
            onTap: suffixontap,
          ),
        ),
      ),
    );
  }
}
