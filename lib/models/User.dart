
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Intern.dart';

class UserModel {
  String userName;
  String email;

  UserModel(this.userName, this.email);

  static UserModel fromMap(Map<String,dynamic> m){
    return UserModel(
        m['userName'],
        m['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
    };
  }

}