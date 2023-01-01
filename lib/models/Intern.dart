import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Intern{
  String uid ="";
  String companyName;
  String jobTitle;
  String location;
  String publishDay;
  String description;
  String responsibilties;

  Intern(this.companyName,this.jobTitle,this.location,this.publishDay,this.description,this.responsibilties);

  Intern.fromMap(Map<String,dynamic> m):
        this(
    m['companyName'], m['jobTitle'],m['location'],m['publishDay'],m['description'],m['responsibilties']
  );

  Map<String,dynamic> toMap(){
    return {
      'companyName':companyName,
      'jobTitle':jobTitle,
      'location':location,
      'publishDay':publishDay,
      'description':description,
      'responsibilties':responsibilties
    };
  }
  void setId(String id){
    this.uid = id;
  }
}