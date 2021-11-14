import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;

  UserModel({this.email, this.name});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    name = doc['name'];
    email = doc['email'];
  }
}
