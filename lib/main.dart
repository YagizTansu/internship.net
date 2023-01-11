import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:internship/companyPages/CompanyPage.dart';
import 'package:internship/HomePage.dart';
import 'package:internship/authentication/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'INTERNSHIP.NET',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 4,
          color: Colors.deepOrangeAccent,
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges() ,
        builder:(context ,snapshot) {
          if(snapshot.hasData){
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(snapshot.data!.uid).snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    final user = snapshot.data!.data();
                    if(user!['userType'] == "intern"){
                      return HomePage();
                    }else{
                      return CompanyPage();
                    }
                  }
                  return Material(child: Center(child: CircularProgressIndicator(),),);
                },
            );
          }
          else{
            return Login();
          }
        },
      ),
    );
  }
}



