import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Settings.dart';
import '../models/Internship.dart';

class PublishInternshipPage extends StatefulWidget {
  const PublishInternshipPage({Key? key}) : super(key: key);

  @override
  State<PublishInternshipPage> createState() => _PublishInternshipPageState();
}

class _PublishInternshipPageState extends State<PublishInternshipPage> {
  final companyName = TextEditingController();
  final jobTitle = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final description = TextEditingController();
  final responsibilities = TextEditingController();
  final address = TextEditingController();

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
    return SafeArea(
      child: Scaffold(
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                    ),
                    margin: EdgeInsets.only(top:15,left: 30,right: 30,bottom: 0),
                    padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                    child: TextFormField(
                      maxLines: 4,
                      controller: address,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.location_on_outlined),
                          hintText: "Enter internship address"
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
                          child: Text('Publish Internship',style: TextStyle(
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
      ),
    );
  }
  void AddToDB(){
    if(companyName.text != "" && jobTitle.text != "" && city.text != "" &&country.text != "" &&responsibilities.text != "" && description.text != ""){

      Internship internship = new Internship(companyName.text,jobTitle.text,city.text,country.text,DateTime.now().toString(),description.text,responsibilities.text,address.text);
      FirebaseFirestore.instance.collection('internships').add(internship.toMap());

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
            child: Center(child: Text("Intern is published successfully",style: TextStyle(fontSize: 20),)),
          ),
        ),
      );
      companyName.text = "";
      jobTitle.text = "";
      city.text = "";
      country.text = "";
      responsibilities.text = "";
      description.text = "";
      address.text = "";

    }else{
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
