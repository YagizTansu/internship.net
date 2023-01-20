import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship/internPages/FilterPage.dart';
import 'package:internship/Settings.dart';
import 'InternshipCard.dart';
import '../models/Internship.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = new TextEditingController();
  var stream;

  List<String> filter = ['all'];
  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance.collection('internships').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "INTERNSHIP.NET",
            style: TextStyle(
                fontSize: 21, color: Colors.white, fontWeight: FontWeight.w800),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: GestureDetector(
                  onTap: () async{
                      final filterList = await Navigator.of(context).push<List<String>>(
                      MaterialPageRoute(
                        builder: (context) => FilterPage()
                      ),
                    );
                      setState(() {
                        print(filterList![0]);
                        filter = filterList!;
                        if(filterList![0] != "All" && filterList![1] != "All"){
                          stream = FirebaseFirestore.instance.collection('internships')
                              .where('internshipTitle',isEqualTo: filterList![0])
                          //.where('country',isEqualTo: filter[1])
                              .where('city',isEqualTo: filterList![1])
                              .snapshots();
                        }
                      });
                  },
                  child: Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Search Internship...', border: InputBorder.none),
                        onChanged: (val) {},
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: StreamBuilder(
                  stream: stream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        //number of rows
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

