import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage> {
  String jobTitle = "All";
  String city = "All";

   List<String> positionList = <String>['All',"mechanical","software developer", "project manager","desinger","mobile developer","tester"];
   List<String> locationList = <String>['All','izmir', 'istanbul', 'ankara'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).pop([jobTitle,city]);
              }, child: Text("Search",style: TextStyle(fontSize: 18),),),
            )
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Internship title"),
                        ),
                        AwesomeDropDown(
                          isBackPressedOrTouchedOutSide: false,
                          elevation: 5,
                          dropDownBorderRadius: 10,
                          dropDownTopBorderRadius: 50,
                          dropDownBottomBorderRadius: 50,
                          dropDownIconBGColor: Colors.transparent,
                          dropDownOverlayBGColor: Colors.transparent,
                          dropDownBGColor: Colors.white,
                          numOfListItemToShow: 4,
                          selectedItemTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          dropDownListTextStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                              backgroundColor: Colors.transparent),
                          isPanDown: false,
                          selectedItem: jobTitle,
                          dropDownList: positionList,
                          dropDownIcon: Icon(Icons.work_outline_outlined),
                          onDropDownItemClick: (item) {
                            setState(() {
                              jobTitle = item;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("city"),
                        ),
                        AwesomeDropDown(
                          isBackPressedOrTouchedOutSide: false,
                          elevation: 5,
                          dropDownBorderRadius: 10,
                          dropDownTopBorderRadius: 50,
                          dropDownBottomBorderRadius: 50,
                          dropDownIconBGColor: Colors.transparent,
                          dropDownOverlayBGColor: Colors.transparent,
                          dropDownBGColor: Colors.white,
                          numOfListItemToShow: 4,
                          selectedItemTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          dropDownListTextStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                              backgroundColor: Colors.transparent),
                          isPanDown: false,
                          selectedItem: city,
                          dropDownList: locationList,
                          dropDownIcon: Icon(Icons.map),
                          onDropDownItemClick: (item) {
                            setState(() {
                              city = item;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

