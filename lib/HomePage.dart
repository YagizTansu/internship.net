import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internship/internPages/SearchPage.dart';
import 'package:internship/internPages/ProcessPage.dart';
import 'package:internship/internPages/NotificationPage.dart';
import 'package:internship/ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? messageToken ="";
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    SearchPage(),
    ProcessPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();
    initInfo();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      if (message.notification != null) {
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notification').doc().set({
          'body':message.notification!.body,
          'title':message.notification!.title
        });
        print('Notification Title: ${message.notification!.title}');
        print('Notification Body: ${message.notification!.body}');
        const snackBar = SnackBar(
          content: Text('Your internship application is approved! Check your notification'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),htmlFormatContentTitle: true
        );
        
        AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
            'internship-net', 'internship-net', importance: Importance.high,
          styleInformation: bigTextStyleInformation,priority: Priority.high,playSound: true,
        );

        NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails
        );
        FlutterLocalNotificationsPlugin().show(0, message.notification!.title, message.notification!.body, notificationDetails,
            payload: message.data['body']);
      }
    });
  }

  initInfo() async{
    var androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeSettings = InitializationSettings(android: androidInitialize);
    FlutterLocalNotificationsPlugin().initialize(initializeSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }
  void requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('granted provisional permission');
    }else{
      print('decline permission');
    }
  }
  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
            (value) {
          setState(() {
            messageToken = value;
            print('token: ' + messageToken!);
          });
          savedToken(messageToken);
        }
    );
  }
  void savedToken(token) async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {'token': token},SetOptions(merge: true));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body:_pages.elementAt(_selectedIndex),
        bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search),
              label: 'Search Intern',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Process',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          selectedFontSize: 15,
          selectedItemColor: Colors.deepOrangeAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 3,
        ),
      ),
    );
  }
}

