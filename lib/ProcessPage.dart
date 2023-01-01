import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'InternCard.dart';
import 'models/Intern.dart';

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
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
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
                  stream:  FirebaseFirestore.instance.collection('users').doc(uid).collection('appliedInterns').snapshots(), //build connection
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
                          Intern intern = Intern.fromMap(map);
                          intern.setId(documentSnapshot.id);
                          return InternCard(intern:  intern);
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
                  stream:  FirebaseFirestore.instance.collection('users').doc(uid).collection('savedInterns').snapshots(), //build connection
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
                          Intern intern = Intern.fromMap(map);
                          intern.setId(documentSnapshot.id);
                          return InternCard(intern: intern);
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
