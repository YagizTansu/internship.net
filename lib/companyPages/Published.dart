import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/companyPages/Applicants.dart';
import '../internPages/InternshipCard.dart';
import '../models/Internship.dart';

class Published extends StatefulWidget {
  const Published({Key? key}) : super(key: key);

  @override
  State<Published> createState() => _PublishedState();
}

class _PublishedState extends State<Published> {
  String companyName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findName();
  }

  void findName() async{
    await FirebaseFirestore.instance.collection('users')
        .where('userEmail',isEqualTo:FirebaseAuth.instance.currentUser!.email).get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          companyName = doc['userName'];
        });
        print(companyName);
      })
    });
  }
  String? email = FirebaseAuth.instance.currentUser!.email;
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
               // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: Center(
          child: StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('internships').where('companyName',isEqualTo: companyName).snapshots(),//build connection
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length, //number of rows
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
                    Internship internship = Internship.fromMap(map);
                    internship.setId(documentSnapshot.id);
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0,0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InternshipCard(internship:  internship),
                              ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=> Applicants(internship: internship,),
                                  ),
                                );
                              }, child: Text("Applicants"),
                              ),
                            ],
                          ),
                        ),
                        ],
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

/**/
