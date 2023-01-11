import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/models/Intern.dart';
import 'InternDetailPage.dart';

class InternCard extends StatefulWidget {
  const InternCard({Key? key, required this.intern}) : super(key: key);
  final Intern intern;

  @override
  State<InternCard> createState() => _InternCardState();
}

class _InternCardState extends State<InternCard> {
  bool buttonState = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controlChecked(widget.intern.uid);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InternDetailPage(
                    intern: widget.intern,
                  )));
            },
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      "images/logo.png",
                      height: 80,
                    ),
                    title: Text(
                      widget.intern.companyName.toUpperCase()+ " - " + widget.intern.jobTitle,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.intern.city+", "+widget.intern.country ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.double_arrow_outlined,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(child: Text('Actively recruiting')),
                            ],
                          ),
                        ),
                        Text(
                          widget.intern.publishDay + " ago",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    trailing: buttonState ? Icon(Icons.add_box_rounded) : Icon(Icons.add_box_outlined),
                    isThreeLine: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   controlChecked(String id) async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var ds = await FirebaseFirestore.instance.collection("users").doc(uid).collection('savedInterns').doc(id).get();

    setState(() {
      if (!ds.exists) {
        buttonState = false;
      } else {
        buttonState = true;
      }
      print(buttonState);
    });
  }
}
