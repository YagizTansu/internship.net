import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return SafeArea(
      child: Scaffold(
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
        body: Center(
          child: StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notification').snapshots(), //build connection
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length, //number of rows
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;

                    return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                             ListTile(
                              leading: Icon(Icons.notifications,size: 34,),
                              title: Text(map['body'],style: TextStyle(
                                fontSize: 18
                              ),),
                              subtitle: Text(map['title'],style: TextStyle(
                                  fontSize: 18
                              ),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('DELETE',style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
