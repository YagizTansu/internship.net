import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:internship/internPages/InternshipCard.dart';
import 'package:file_picker/file_picker.dart';
import '../models/Internship.dart';
import '../models/User.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({Key? key,required this.internship}) : super(key: key);
  final Internship internship;
  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  bool coverLetterIsUploaded = false;
  bool cvIsUploaded = false;
  PlatformFile? coverLetterFile ;
  PlatformFile? cvFile ;
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
              InternshipCard(internship: widget.internship),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.file_open),
                title: const Text("Upload Cover letter"),
                subtitle: coverLetterIsUploaded? Text(coverLetterFile!.name ) : Text(""),
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    withData: true
                  );
                  if (result != null) {
                    coverLetterFile = result.files.first;

                    setState(() {
                      coverLetterIsUploaded = true;
                    });
                  } else {
                    print("No file selected");
                  }

                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text("Upload CV"),
                subtitle: cvIsUploaded? Text(cvFile!.name ) : Text(""),
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                      withData: true
                  );
                  if (result != null) {
                    cvFile = result.files.first;
                    setState(() {
                      cvIsUploaded = true;
                    });
                  } else {
                    print("No file selected");
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: ()  async{
                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  //File Upload
                  if(cvIsUploaded && coverLetterIsUploaded){
                    var coverLetterFileBytes = coverLetterFile!.bytes;
                    var coverLetterFileName = coverLetterFile!.name;
                    var cvFileBytes = cvFile!.bytes;
                    var cvFileName = cvFile!.name;
                    await FirebaseStorage.instance.ref('$uid/coverLetter/$coverLetterFileName').putData(coverLetterFileBytes!);
                    await FirebaseStorage.instance.ref('$uid/cv/$cvFileName').putData(cvFileBytes!);

                    //internship add to user appliedIntern collection
                    FirebaseFirestore.instance.collection('users').doc(uid).collection('appliedInternships').doc(widget.internship.uid).set(widget.internship.toMap());

                    //user add to internships applicant collection
                    var user = await FirebaseFirestore.instance.collection('users').doc(uid).get();
                    UserModel userModel = UserModel(user.data()!['userName'],user.data()!['userEmail']);
                    FirebaseFirestore.instance.collection('internships').doc(widget.internship.uid).collection('applicants').doc(uid).set(userModel.toMap());

                    Navigator.of(context).pop();

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
                          child: Center(child: Text("Applied is successfully",style: TextStyle(fontSize: 14),)),
                        ),
                      ),
                    );
                  }else{
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
                          child: Center(child: Text("Your file is missing",style: TextStyle(fontSize: 14),
                          ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Text("Apply to Internship"),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}