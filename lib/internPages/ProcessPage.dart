import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'InternshipCard.dart';
import '../models/Internship.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "INTERNSHIP.NET",
              style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Applied',
                ),
                Tab(
                  text: 'Saved',
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              )
            ],
          ),
          body: TabBarView(
            children: [
              Center(
                child: StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('users').doc(uid).collection('appliedInternships').snapshots(), //build connection
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
                          Internship internship = Internship.fromMap(map);
                          internship.setId(documentSnapshot.id);
                          return InternshipCard(internship:  internship);
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Center(
                child:  StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('users').doc(uid).collection('savedInternships').snapshots(), //build connection
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
                          Internship internship = Internship.fromMap(map);
                          internship.setId(documentSnapshot.id);
                          return InternshipCard(internship: internship);
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
