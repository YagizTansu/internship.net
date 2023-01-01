import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "INTERNSHIP.NET",
          style: TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SettingsPage()));
            },
          )
        ],
      ),
      body: Center(child: Column(
        children: [
          Text("profile"),
          Text(user.email!),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, child: Text("Log out"),)
        ],
      )),
    );
  }
}
