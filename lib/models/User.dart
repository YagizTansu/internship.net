
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Intern.dart';

class UserModel {
  String userName;
  String email;
  List<Intern> savedInterns;
  List<Intern> appliedInterns;

  UserModel(this.userName, this.email, this.savedInterns, this.appliedInterns);


  static UserModel fromMap(Map<String,dynamic> m){
    return UserModel(
        m['userName'],
        m['email'],
        m['savedInterns'],
        m['appliedInterns']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'savedInterns': savedInterns,
      'appliedInterns': appliedInterns,
    };
  }

  void addInternToSaved(Intern intern) async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    savedInterns.add(intern);
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      "savedInterns": savedInterns
    });
  }

/*static UserModel fromDocument(DocumentSnapshot< Map<String, dynamic>> m){
    var snapShot = m.data() as Map<String, dynamic>;

    return UserModel(
        snapShot['userName'],
        snapShot['email'],
        snapShot['savedInterns'],
        snapShot['appliedInterns']
    );
  }*/
}