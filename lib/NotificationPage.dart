import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Center(child: Text("notification")),
    );
  }
}
