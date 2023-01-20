import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship/models/Internship.dart';
import 'ApplyPage.dart';

class InternshipDetailPage extends StatefulWidget {
  const InternshipDetailPage({Key? key, required this.internship}) : super(key: key);
  final Internship internship;

  @override
  State<InternshipDetailPage> createState() => _InternshipDetailPageState();
}

class _InternshipDetailPageState extends State<InternshipDetailPage> {
  bool buttonState = false ;
  late Duration duration = new Duration();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.4237, 27.1428),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dt1 = DateTime.parse(widget.internship.publishDay);
    DateTime dt2 = DateTime.now();
    duration = dt2.difference(dt1);
    controlChecked(widget.internship.uid);
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 2,
              child: Container(
                child: Image.asset("images/logo.png"),
              )),
          Flexible(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.internship.companyName + " - " + widget.internship.internshipTitle,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              IconButton(
                                icon: buttonState ? Icon(Icons.add_box) : Icon(Icons.add_box_outlined),
                                onPressed: () {
                                  setState(() {
                                    String uid = FirebaseAuth.instance.currentUser!.uid;
                                    if(!buttonState){
                                      FirebaseFirestore.instance.collection('users').doc(uid).collection('savedInternships').doc(widget.internship.uid).set(widget.internship.toMap());
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          behavior: SnackBarBehavior.floating,
                                          content: Container(
                                            padding: EdgeInsets.all(16),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade600,
                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                            ),
                                            child: Center(child: Text("Internship added to the Saved",style: TextStyle(fontSize: 14),
                                            ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }else{
                                      FirebaseFirestore.instance.collection('users').doc(uid).collection('savedInternships').doc(widget.internship.uid).delete();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          behavior: SnackBarBehavior.floating,
                                          content: Container(
                                            padding: EdgeInsets.all(16),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade600,
                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                            ),
                                            child: Center(child: Text("Internship removed to the Saved",style: TextStyle(fontSize: 14),
                                            ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    buttonState=!buttonState;
                                  });
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ApplyPage(internship: widget.internship),
                                    ),
                                  );
                                },
                                child: Text("Apply"),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                duration.inDays.toString() + " days ago",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(
                                width: 200,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(
                            "Description",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: Text(widget.internship.description)),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(
                            "Responsibilities",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.internship.responsibilities),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(
                            "Location",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                          padding: const  EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Container(
                            width: 400,
                            height: 300,
                            child: GoogleMap(
                              mapType: MapType.hybrid,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
    });
  }
}


