import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/models/Internship.dart';
import 'InternshipDetailPage.dart';

class InternshipCard extends StatefulWidget {
  const InternshipCard({Key? key, required this.internship}) : super(key: key);
  final Internship internship;


  @override
  State<InternshipCard> createState() => _InternshipCardState();
}

class _InternshipCardState extends State<InternshipCard> {
  bool buttonState = true;
  late Duration duration = new Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controlChecked(widget.internship.uid);
    DateTime dt1 = DateTime.parse(widget.internship.publishDay);
    DateTime dt2 = DateTime.now();
    duration = dt2.difference(dt1);
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
                  builder: (context) => InternshipDetailPage(
                    internship: widget.internship,
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
                      widget.internship.companyName.toUpperCase()+ " - " + widget.internship.internshipTitle,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.internship.city+", "+widget.internship.country ),
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
                          duration.inDays.toString() + " days ago",
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
    var ds = await FirebaseFirestore.instance.collection("users").doc(uid).collection('savedInternships').doc(id).get();

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
