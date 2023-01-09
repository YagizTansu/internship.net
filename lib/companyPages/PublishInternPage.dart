import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Settings.dart';
import '../models/Intern.dart';

class PublishInternPage extends StatefulWidget {
  const PublishInternPage({Key? key}) : super(key: key);

  @override
  State<PublishInternPage> createState() => _PublishInternPageState();
}

class _PublishInternPageState extends State<PublishInternPage> {
  final companyName = TextEditingController();
  final jobTitle = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final description = TextEditingController();
  final responsibilities = TextEditingController();

  @override
  void dispose() {
    companyName.dispose();
    jobTitle.dispose();
    city.dispose();
    country.dispose();
    description.dispose();
    responsibilities.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(top:30,left: 30,right: 30,bottom: 0),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  child: TextFormField(
                    controller: companyName,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.apartment),
                        hintText: "Enter company name"
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(top:15,left: 30,right: 30,bottom: 0),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  child: TextFormField(
                    controller: jobTitle,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.work_outline_outlined),
                        hintText: "Enter intern title"
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(top:15,left: 30,right: 30,bottom: 0),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  child: TextFormField(
                    controller: city,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.location_city),
                        hintText: "Enter city"
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(top:15,left: 30,right: 30,bottom: 0),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  child: TextFormField(
                    controller: country,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.landscape_outlined),
                        hintText: "Enter country"
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(top:15,left: 30,right: 30,bottom: 0),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  child: TextFormField(
                    controller: responsibilities,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.toc),
                        hintText: "Enter intern responsibilities"
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(top:15,left: 30,right: 30,bottom: 0),
                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  child: TextFormField(
                    maxLines: 4,
                    controller: description,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.description),
                        hintText: "Enter intern description"
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          AddToDB();
                        },
                        child: Text('Publish Intern',style: TextStyle(
                            fontSize: 20
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade500,
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void AddToDB(){
    if(companyName.text != "" && jobTitle.text != "" && city.text != "" &&country.text != "" &&responsibilities.text != "" && description.text != ""){

      Intern intern = new Intern(companyName.text,jobTitle.text,city.text,country.text,"",description.text,responsibilities.text);
      FirebaseFirestore.instance.collection('interns').add(intern.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 3,
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          content: Container(
            padding: EdgeInsets.all(16),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(child: Text("Intern is published succesfully",style: TextStyle(fontSize: 20),)),
          ),
        ),
      );
      companyName.text = "";
      jobTitle.text = "";
      city.text = "";
      country.text = "";
      responsibilities.text = "";
      description.text = "";

    }else{
      print("boş");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 3,
            backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              content: Container(
                padding: EdgeInsets.all(16),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Center(child: Text("Some part is missing!",style: TextStyle(fontSize: 20),)),
              ),
          ),
      );
    }
  }
}
