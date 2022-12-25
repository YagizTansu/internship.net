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
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(38.4237, 27.1428),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

   List<String> positionList = <String>['Senior', 'Junior', 'arge', 'Four'];
   List<String> internTypeList = <String>['Remote', 'Part time', 'Three'];
   List<String> locationList = <String>['izmir', 'istanbul', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
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
                    child: DropdownButtonExample(icon: Icon(Icons.work_outline_outlined),list: positionList,selectedItem: "Choose position",),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  DropdownButtonExample(icon: Icon(Icons.timelapse_outlined,),list: internTypeList,selectedItem: "Choose intern type",),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  DropdownButtonExample(icon: Icon(Icons.location_on_outlined),list: locationList,selectedItem: "Choose location",),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key,required this.icon,required this.list,required this.selectedItem});
  final Icon icon;
  final  List<String> list;
  final String selectedItem ;
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {

  @override
  Widget build(BuildContext context) {
    return AwesomeDropDown(
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
      selectedItem: widget.selectedItem,
      dropDownList: widget.list,
      dropDownIcon: widget.icon,
      onDropDownItemClick: (selectedItem) {

      },
    );
  }
}

