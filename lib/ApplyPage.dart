import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/InternCard.dart';
import 'models/Intern.dart';
import 'models/User.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({Key? key,required this.intern}) : super(key: key);
  final Intern intern;
  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InternCard(intern: widget.intern),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.file_open),
                title: const Text("Upload Cover letter"),
                onTap: () async {

                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text("Upload CV"),
                onTap: () async {
                  /*final result = await FilePicker.platform
                      .pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
                  Navigator.of(context).pop(FilePickerNavigateModel(filePickerResults: result));*/
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: ()  {
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  FirebaseFirestore.instance.collection('users').doc(uid).collection('appliedInterns').doc(widget.intern.uid).set(widget.intern.toMap());
                },
                child: Text("Apply to Intern"),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}