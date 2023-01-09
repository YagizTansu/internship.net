import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Intern{
  String uid ="";
  String companyName;
  String jobTitle;
  String city;
  String country;
  String publishDay;
  String description;
  String responsibilties;

  Intern(this.companyName,this.jobTitle,this.city,this.country,this.publishDay,this.description,this.responsibilties);

  Intern.fromMap(Map<String,dynamic> m):
        this(
    m['companyName'], m['jobTitle'],m['city'],m['country'],m['publishDay'],m['description'],m['responsibilties']
  );

  Map<String,dynamic> toMap(){
    return {
      'companyName':companyName,
      'jobTitle':jobTitle,
      'city':city,
      'country':country,
      'publishDay':publishDay,
      'description':description,
      'responsibilties':responsibilties
    };
  }
  void setId(String id){
    this.uid = id;
  }
}