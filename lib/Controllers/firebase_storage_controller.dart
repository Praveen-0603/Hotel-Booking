import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_booking/Controllers/firebase_auth_controller.dart';
import 'package:hotel_booking/Controllers/homescreen_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FireBaseStorageController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? imgfile;
  String? uid = Get.find<FirebaseAuthController>().user?.uid;

  Future<void> addprofileimage(BuildContext context) async {
    if (await _getImage()) {
      try {
        await _uploadimage(context);
        Get.find<HomeScreenController>().getprofilepicture();
        Get.back();
        Fluttertoast.showToast(msg: 'Profile updated');
      } on FirebaseException catch (e) {
        Get.showSnackbar(
          GetBar(
            snackStyle: SnackStyle.FLOATING,
            message: e.message,
            backgroundColor: Colors.red,
            duration: 2.seconds,
          ),
        );
      }
    }
  }

  Future<bool> _getImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) {
      return false;
    } else {
      imgfile = await ImageCropper.cropImage(
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          hideBottomControls: true,
        ),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        sourcePath: img.path,
      );
      if (imgfile != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> _uploadimage(BuildContext context) async {
    _showLoaderDialog(context);
    Reference firestorageref =
        _firebaseStorage.ref().child('users/$uid/profileimage');
    await firestorageref.putFile(imgfile!);
    Navigator.pop(context);
  }

  Future<String> getdownloadurl() async {
    ListResult _filecheck =
        await FirebaseStorage.instance.ref().child("users/$uid/").listAll();
    if (_filecheck.items.isNotEmpty) {
      Reference reference =
          FirebaseStorage.instance.ref().child('users/$uid/profileimage');
      return reference.getDownloadURL();
    }
    return 'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png';
  }
}

_showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.only(left: 7),
          child: const Text("Uploading..."),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
