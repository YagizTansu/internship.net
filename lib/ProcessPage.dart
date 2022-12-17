import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';
import 'package:internship/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  final CollectionReference saved =
  FirebaseFirestore.instance.collection('saved');

  final CollectionReference applied =
  FirebaseFirestore.instance.collection('Applied');
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
                  stream: applied.snapshots(), //build connection
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                          return InternCard(intern: documentSnapshot);
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
                  stream: saved.snapshots(), //build connection
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                          return InternCard(intern: documentSnapshot);
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
