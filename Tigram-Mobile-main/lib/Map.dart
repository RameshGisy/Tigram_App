import 'dart:async';


import 'package:Tigram/Form1.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class TigramMap extends StatefulWidget {
  String sessionToken ;
  String dropdownValue;
  String dropdownValue1;
  String userName ;
  String userEmail;
  String Name;
  String Address;
  String survey_no;
  String Tree_Proposed_to_cut;
  String  village;
  String  Taluka;
  String  block;
  String District;
  String Pincode;
  String Ownership;
  String Purpose;
  List holder_1;
  bool flag1;
  TigramMap({this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.Tree_Proposed_to_cut,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.flag1});
  @override
  _TigramMapState createState() => _TigramMapState(sessionToken,dropdownValue,dropdownValue1,userName,userEmail,Name,Address,survey_no,Tree_Proposed_to_cut,village,Taluka,block,District,Pincode,Ownership,Purpose,holder_1,flag1);
}

class _TigramMapState extends State<TigramMap> {
  String sessionToken ;
  String dropdownValue;
  String dropdownValue1;
  String userName ;
  String userEmail;
  String Name;
  String Address;
  String survey_no;
  String Tree_Proposed_to_cut;
  String  village;
  String  Taluka;
  String  block;
  String District;
  String Pincode;
  String Ownership;
  String Purpose;
  List holder_1;
  bool flag1;

  _TigramMapState(this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.Tree_Proposed_to_cut,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.flag1);
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List values = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Tree Location",
          style: TextStyle(color: Colors.white,
          fontSize: 20,
         ) ,
        ),
     //     gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          elevation: 0,
          automaticallyImplyLeading: false,),
      body:GoogleMap(
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        padding: EdgeInsets.only(bottom: 75.0, top: 0, right: 0, left: 0),
        initialCameraPosition: CameraPosition(target: LatLng(10.8505, 76.2711), zoom: 14),
        //polygons: myPolygon(),
        onMapCreated: onMapCreated,
        markers:Set<Marker>.of(markers.values)==null?LatLng(10.8505, 76.2711):Set<Marker>.of(markers.values),
        onTap : (latlang) {
          setState(() {
            _addMarkerLongPressed(latlang);
          });
          //we will call this function when pressed on the map
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
           /* Navigator.pop(
                context,MaterialPageRoute(builder: (_) => FormPage1(
                sessionToken:sessionToken,
                dropdownValue:dropdownValue,
                dropdownValue1:dropdownValue1,
                userName:userName,
                Name:Name,
                Address:Address,
                survey_no:survey_no,
                Tree_Proposed_to_cut:Tree_Proposed_to_cut,
                village:village,
                Taluka:Taluka,
                block:block,
                District:District,
                Pincode:Pincode,
                Ownership :Ownership,
                Purpose:Purpose,
                holder_1:holder_1,
                flag1:flag1,

            ))
            );*/
            Navigator.of(context).pop(values);
          },
          tooltip: 'My Location',
          child: Icon(Icons.navigate_next),
        ),
    );
  }

  Future _addMarkerLongPressed(LatLng latlang) async {
    setState(() {
      values.clear();
      final MarkerId markerId = MarkerId('101');
      Marker marker = Marker(
        markerId: markerId,
        draggable: true,
        position: latlang, //With this parameter you automatically obtain latitude and longitude
        infoWindow: InfoWindow(
          title: "Tree Location"+(values.length +1).toString(),
          snippet: "("+latlang.latitude.toStringAsPrecision(8)+" , "+ latlang.longitude.toStringAsPrecision(8) +")",
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
      //values.add(latlang.latitude.toStringAsPrecision(8)+" , "+ latlang.longitude.toStringAsPrecision(9));
      setState(() {
        markers[markerId] = marker;
      });
    print("---------------------Latitude/longitude----------------------");
    });
    values.add(latlang.latitude);
    values.add(latlang.longitude);
    print(values);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latlang, 15.0));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
