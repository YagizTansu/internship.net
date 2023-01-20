import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:internship/models/Internship.dart';
import 'package:internship/models/User.dart';

class ApplicantDetailPage extends StatefulWidget {
  const ApplicantDetailPage({Key? key,required this.user,required this.internship}) : super(key: key);
  final UserModel user;
  final Internship internship;

  @override
  State<ApplicantDetailPage> createState() => _ApplicantDetailPageState();
}

class _ApplicantDetailPageState extends State<ApplicantDetailPage> {
  void sendPushMessage(String token ,String body, String title) async {
    print("here");
    try{
      http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String,String>{
            'Content-Type': 'application/json',
            'Authorization':'key=AAAAWpncKX4:APA91bFYDQNE8ziO8gCKinLCk0Ya5_h55ikJrepSA-GDorr7wxA52cIUn-SLaLwymUgVaUEZuAB7AcvWX5kR39qx-vbhX8zFR548CVIsUgeboQgOhVEUPwnyH8M2iy7KugOgAJxdx9aH'
          },
          body: jsonEncode(
              <String,dynamic>{
                'priority': 'high',
                'data':  <String,dynamic>{
                  'click-action': 'FLUTTER_NOTIFICATION_CLICK',
                  'status': 'done',
                  'body': body,
                  'title':title,
                },
                "notification" : <String,dynamic>{
                  "title": title,
                  "body": body,
                  "android_channel_id": "internship-net"
                },
                "to":token
              }
          )
      );
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
              children:[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/logo.png"),
                    minRadius: 50.0,
                  ),
                ),
                Text(
                 widget.user.userName,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cover Leter",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cv",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                       var user= await FirebaseFirestore.instance.collection('users')
                            .where('userEmail',isEqualTo:widget.user.email).get()
                           .then((QuerySnapshot querySnapshot) => {
                       querySnapshot.docs.forEach((doc) {
                         sendPushMessage(doc["token"],widget.internship.companyName +" - "+ widget.internship.internshipTitle, "Your application is approved");
                       })
                       });
                       Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("Approve",
                          style: TextStyle(
                              fontSize: 20
                          ),),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        var user= await FirebaseFirestore.instance.collection('users')
                            .where('userEmail',isEqualTo:widget.user.email).get()
                            .then((QuerySnapshot querySnapshot) => {
                          querySnapshot.docs.forEach((doc) {
                            sendPushMessage(doc["token"],widget.internship.companyName +" - "+ widget.internship.internshipTitle, "Your application is rejected");
                          })
                        });
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("Reject"
                          ,style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade600
                      ),),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
