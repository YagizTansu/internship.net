import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: Center(child: Text("profile")),
    );
  }
}
