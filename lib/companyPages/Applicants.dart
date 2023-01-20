import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';
import 'package:internship/companyPages/ApplicantDetailPage.dart';
import 'package:internship/models/User.dart';
import '../models/Internship.dart';

class Applicants extends StatefulWidget {
  const Applicants({Key? key,required this.internship}) : super(key: key);
  final Internship internship;

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('internships').doc(widget.internship.uid).collection('applicants').snapshots(),//build connection
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length, //number of rows
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: ()async{
                        UserModel userModel = UserModel.fromMap(map);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ApplicantDetailPage(user: userModel,internship: widget.internship,))
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(right: new BorderSide(width: 1.0, color: Colors.green),
                              ),
                          ),
                          child: Icon(Icons.person, color: Colors.grey,size: 50,),
                        ),
                        title: Row(
                          children: [
                            Text(
                              map['userName'],
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.task_alt_rounded)
                          ],
                        ),

                        subtitle: Row(
                          children: <Widget>[
                            Icon(Icons.mail, color: Colors.black45),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(map['email'], style: TextStyle(color: Colors.black54)),
                            )
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
