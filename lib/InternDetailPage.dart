import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship/models/Intern.dart';
import 'ApplyPage.dart';

class InternDetailPage extends StatefulWidget {
  const InternDetailPage({Key? key, required this.intern}) : super(key: key);
  final Intern intern;


  @override
  State<InternDetailPage> createState() => _InternDetailPageState();
}

class _InternDetailPageState extends State<InternDetailPage> {
  bool buttonState = false ;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.4237, 27.1428),
    zoom: 14.4746,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfLikedOrNot(widget.intern.uid);
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
                                  widget.intern.companyName + " - " + widget.intern.jobTitle,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              IconButton(
                                icon: buttonState ? Icon(Icons.add_box) : Icon(Icons.add_box_outlined),
                                onPressed: () {
                                  setState(() {
                                    String uid = FirebaseAuth.instance.currentUser!.uid;
                                    if(!buttonState){
                                      FirebaseFirestore.instance.collection('users').doc(uid).collection('savedInterns').doc(widget.intern.uid).set(widget.intern.toMap());
                                    }else{
                                      showAlertDialog(context);
                                      FirebaseFirestore.instance.collection('users').doc(uid).collection('savedInterns').doc(widget.intern.uid).delete();
                                    }
                                    buttonState=!buttonState;
                                  });
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ApplyPage(intern: widget.intern,)),
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
                                widget.intern.publishDay + " ago",
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
                            child: Text(widget.intern.description)),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(
                            "Responsiblities",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.intern.responsibilties),
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
  checkIfLikedOrNot(String id) async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var ds = await FirebaseFirestore.instance.collection("users").doc(uid).collection('savedInterns').doc(id).get();

    this.setState(() {
      if (!ds.exists) {
        buttonState = false;
      } else {
        buttonState = true;
      }
    });
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("delete from saved"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = ElevatedButton(
    child: Text("cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete"),
    content: Text("This intern will remove from saved interns"),
    actions: [
      okButton,
      cancelButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


