import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final  userNameController =  TextEditingController();
  final  userDescriptionController =  TextEditingController();
  final  userEmailController =  TextEditingController();

  Future getUserData() async{
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).get()
        .then((value) async{
          setState(() {
            userNameController.text = value.data()!['userName'];
            userEmailController.text = value.data()!['userEmail'];
            userDescriptionController.text =  value.data()!['userDescription'];
          });
    });
  }
  @override
  void initState() {
    getUserData();
    super.initState();
  }
  @override
  void dispose() {
    userNameController.dispose();
    userEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "INTERNSHIP.NET",
            style: TextStyle(fontSize: 21, color: Colors.white,fontWeight: FontWeight.w800),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SettingsPage()));
              },
            )
          ],
        ),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/logo.png"),
                  minRadius: 100.0,
                ),
              ),
              Text(
                userNameController.text,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Email",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Description",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: userDescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      var collection = FirebaseFirestore.instance.collection('users');
                      collection
                          .doc(FirebaseAuth.instance.currentUser!.uid) // <-- Doc ID where data should be updated.
                          .update({
                        'userEmail': userEmailController.text,
                        'userDescription': userDescriptionController.text
                      });

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
                            child: Center(child: Text("Your profile is updated.",style: TextStyle(fontSize: 14),
                            ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Update profile",
                        style: TextStyle(
                          fontSize: 20
                      ),),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade600,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  ElevatedButton(
                    onPressed: (){FirebaseAuth.instance.signOut();},
                    child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Log out"
                    ,style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade600
                  ),),
                ],
              ),
          ],
        ),
            )),
      ),
    );
  }
}
