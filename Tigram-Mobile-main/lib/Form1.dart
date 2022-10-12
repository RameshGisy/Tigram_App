import 'package:Tigram/Map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' show File;
import 'package:Tigram/Form2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';


class FormPage1 extends StatefulWidget {
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
  List values;
  FormPage1({this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.Tree_Proposed_to_cut,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.flag1,this.values});
  @override
  _FormPage1State createState() => _FormPage1State(sessionToken,dropdownValue,dropdownValue1,userName,userEmail,Name,Address,survey_no,Tree_Proposed_to_cut,village,Taluka,block,District,Pincode,Ownership,Purpose,holder_1,flag1);
}
class Item {
  const Item(this.name);
  final String name;
}

class _FormPage1State extends State<FormPage1> {
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
  _FormPage1State(this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.Tree_Proposed_to_cut,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.flag1);


  //----------------------
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List values = [];
  Future<Widget> AddMap(BuildContext context)async{
    return await showDialog(
        context: this.context,
        builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            insetPadding: EdgeInsets.only(bottom: 30,top: 30,left: 10,right: 10),
            contentPadding: EdgeInsets.all(5),
            clipBehavior: Clip.antiAlias,
          content:Container(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
           child:GoogleMap(
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            //padding: EdgeInsets.only(top: 75,bottom: 75),
            initialCameraPosition: CameraPosition(target: LatLng(10.8505, 76.2711), zoom: 14),
            //polygons: myPolygon(),
            onMapCreated: onMapCreated,
            markers:Set<Marker>.of(markers.values)==null?LatLng(10.8505, 76.2711):Set<Marker>.of(markers.values),
            onTap : (latlang) {
              setState(() {
                values.clear();
                final MarkerId markerId = MarkerId('101');
                Marker marker = Marker(
                  markerId: markerId,
                  draggable: true,
                  position: latlang, //With this parameter you automatically obtain latitude and longitude
                  infoWindow: InfoWindow(
                    title: "Tree Location",//+(values.length +1).toString(),
                    snippet: "( Latitude : "+latlang.latitude.toStringAsPrecision(8)+" , Longitude : "+ latlang.longitude.toStringAsPrecision(8) +")",
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                );
                //values.add(latlang.latitude.toStringAsPrecision(8)+" , "+ latlang.longitude.toStringAsPrecision(9));
                setState(() {
                  markers[markerId] = marker;
                });
                print("---------------------Latitude/longitude----------------------");
              });
              values.add(latlang.latitude.toStringAsPrecision(8));
              values.add(latlang.longitude.toStringAsPrecision(8));
              print(values);
              mapController.animateCamera(CameraUpdate.newLatLngZoom(latlang, 15.0));//we will call this function when pressed on the map
            },
          ),
          ),
            title: Text('Map'),
            actions: <Widget>[
            RaisedButton(
              color: Colors.yellow,
              child: Text('OK ',style: TextStyle(color: Colors.black),),
              onPressed: () {
                setState(() {
                  V=true;
                });
                Navigator.of(context).pop(); 
              },
            ),
          ]
        );

      });
    });
  }

  String GetLatLong(){
    return values.toString();
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
  //----------------------


  //-------------image-Picker-----------//
  File _Application;
  // final ImagePicker _picker = ImagePicker();
  // void _RevenueApplication(ImageSource source) async {
  //   print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Application = pickedFile;
  //     print("------------------------------Profile Image--------------");
  //     print(_Application.path);
  //   });
  // }
  // File _Approval;
  // final ImagePicker _picker1 = ImagePicker();
  // void _RevenueApproval(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Approval = pickedFile;
  //     print("------------------------------Profile Image--------------");
  //     print(_Approval.path);
  //   });
  // }
  // File _Declaration;
  // final ImagePicker _picker2 = ImagePicker();
  // void Declaration(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Declaration = pickedFile;
  //     print("------------------------------Profile Image--------------");
  //     print(_Declaration.path);
  //   });
  // }
  // File _Location;
  // final ImagePicker _picker3 = ImagePicker();
  // void _LocationSketch(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Location = pickedFile;
  //     print("------------------------------Profile Image--------------");
  //     print(_Location.path);
  //   });
  // }
  // File _Ownership;
  // final ImagePicker _picker4 = ImagePicker();
  // void _TreeOwnership(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Ownership = pickedFile;
  //     print("------------------------------Profile Image--------------");
  //     print(_Ownership.path);
  //   });
  // }
  // File _Proof;
  // final ImagePicker _picker5 = ImagePicker();
  // void _IdProof(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Proof = pickedFile;
  //     print("------------------------------Profile Image--------------");
  //     print(_Proof.path);
  //   });
  // }
  //------------end-image-picker------------//


  //-----------------------------------Geo-Locator------------------------------

  Widget getLag(BuildContext context,List values){
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "Latitude : ",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        TextSpan(
            text: values.length==0?'':values[0].toString(),
            style: TextStyle(
              color: Colors.blueAccent[700],
              fontSize: 14,
            )),
      ]),
    );
  }
  /*Widget getTextV(BuildContext context,double girth,double length){
    return  Text((_getVolume(girth, length).toString()).toString());
  }*/
  //-----------------------------------End-GeoLocator---------------------------
  String dropdownValue2;
  String holder = '' ;
  List<String> IdProof = [
    'Aadhar Card',
    'Driving License',
    'Passport',
    'Government ID',
    'Voter ID',
  ];

  void getDropDownItem(){
    setState(() {
      holder = dropdownValue ;
    });
    print("-----------------------"+holder);
  }
  String dropdownValue3;
  String spacies_holder = '' ;

  void getDropDownItem1(){
    setState(() {
      spacies_holder = dropdownValue1 ;
    });
    print("-----------------------"+holder);
  }
  bool flag =true;
  var b=1;
  int a=0;
  List log_details=[];
  List d=[];
  List  Species=[];
  List  Length=[];
  List  Girth=[];
  List  Volume=[];
  List  Latitude=[];
  List  Longitude=[];
  List n_list =[];
  Map<String,String> logs={};
final List<TextEditingController> _controllers = List();
double v;
double _getVolume(double girth,double length){
    v=(girth/4)*(girth/4)*length;
    return v;
}
Widget getTextV(BuildContext context,double girth,double length){
  return  Text((_getVolume(girth, length).toString()).toString());
}

  bool V=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint:  Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3=data ;
                          });
                        },
                        items: holder_1.map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value:value,
                            child: Text(value,style: TextStyle(fontSize: 13),),
                          );
                        }).toList(),
                      ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: length,
                          validator: (value) {
                            return value.isNotEmpty ? null : "Enter Length";
                          },
                          decoration: InputDecoration(hintText: "Please Enter Length"),
                        ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: girth,
                            validator: (value) {
                              return value.isNotEmpty ? null : "Enter girth";
                            },
                            decoration: InputDecoration(hintText: "Please Enter girth"),
                          ),
                      Row(
                        children: [
                          Text('Select Tree Location',),
                          Spacer(),
                          IconButton(icon:Icon(Icons.location_on,color: Colors.lightBlue), onPressed: () async {
                             final status = await Permission.locationWhenInUse.request();
                             final serviceEnabled = await Geolocator.getCurrentPosition() ;
                            if(status==PermissionStatus.granted ){
                              setState(() {
                                AddMap(context);
                              });
                            }
                            else{
                              status;
                            }
                          }),
                        ],
                      ),
                     /*RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Latitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?'':values[0].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Longitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?'':values[1].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),*/
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK ',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                  onTap: () {
                    Map<String,dynamic> logs={"species_of_tree":dropdownValue3,"length":length.text,"breadth":girth.text,"volume":_getVolume((double.parse(girth.text==""?'0':girth.text)),(double.parse(length.text==""?'0':length.text))).toString(),"latitude":values[0].toString(),"longitude":values[1].toString()};
                    log_details.add(logs);
                    int n=log_details.length;
                    n_list=[];
                   //
                   //  List n_list =[];
                    print(n);
                      for(int i=0;i<n;i++){
                        n_list.add(i);
                      }
                      print("----n_list--");
                      print(n_list);
                      print(Species);
                      print(d);
                      length.clear();
                      girth.clear();
                    Navigator.of(context).pop();
                   /* if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                    }*/
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> EditInformationDialog(BuildContext context,int index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          dropdownValue3=log_details[index]['species_of_tree'];
          length.text=log_details[index]['length'];
          girth.text=log_details[index]['breadth'];
          volume.text=log_details[index]['volume'];
          latitude.text=log_details[index]['latitude'];
          longitude.text=log_details[index]['longitude'];
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint:  Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3=data ;
                          });
                        },
                        items: holder_1.map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value:value,
                            child: Text(value,style: TextStyle(fontSize: 13),),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        //initialValue: log_details[index]['length'],
                        controller:length,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Length";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter Length"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter girth";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter girth"),
                      ),
                      /*TextFormField(
                        keyboardType: TextInputType.number,
                        controller: volume,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Volume";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter Volume"),
                      ),*/
                      /*TextFormField(
                        keyboardType: TextInputType.number,
                        controller: latitude,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Latitude";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter  Latitude"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: longitude,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter  Longitude";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter Longitude"),
                      ),*/
                      Row(
                        children: [
                          Text('Update Tree Location',),
                          Spacer(),
                          IconButton(icon:Icon(Icons.location_on,color: Colors.lightBlue), onPressed: (){
                            values.clear();
                            AddMap(context);
                          }),
                        ],
                      ),
                     /* RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Latitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?latitude.text:values[0].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Longitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?longitude.text:values[1].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),*/
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK ',style: TextStyle(color: Colors.blue),),
                  onTap: () {
                    Map<String,dynamic> logs={"species_of_tree":dropdownValue3,"length":length.text,"breadth":girth.text,"volume":_getVolume((double.parse(girth.text==""?'0':girth.text)),(double.parse(length.text==""?'0':length.text))).toString(),"latitude":values.length==0?latitude.text:values[0].toString(),"longitude":values.length==0?longitude.text:values[1].toString()};
                   // log_details.elementAt(int.parse(source));
                    log_details[index]=logs;
                    int n=log_details.length;
                    n_list=[];
                    //
                    //  List n_list =[];
                    print(n);
                    for(int i=0;i<n;i++){
                      n_list.add(i);
                    }
                    print("----n_list--");
                    print(n_list);
                    print(Species);
                    print(d);
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      length.clear();
                      girth.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

//[{},{}]





  //TextEditingController length = TextEditingController();
 /*List<TextEditingController> length1 = [];
  List<TextEditingController>girth2 = [];
  List<TextEditingController> volume3 = [];
  List<TextEditingController> latitude4 = [];
  List<TextEditingController> longitude5 = [];*/

String A='';
Map<String,TextEditingController> textEditingControllers = {};
  TextEditingController length = TextEditingController();
  TextEditingController girth = TextEditingController();
  TextEditingController volume = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  /*
  class example {
  String length;
  String girth;
  String volume;
  Strung lat;
  String long;
  }
  single datatable entry field
  List<Object>

  Row()
   */



  @override
  Widget build(BuildContext context) {
    //print(_controllers);
    return Scaffold(
        appBar: NewGradientAppBar(
         // backgroundColor: Colors.blueGrey,
          title: Text("FORM - I"),
        //  gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          elevation: 0,
         // automaticallyImplyLeading: false,
        ),
        body:SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
             Container(
                 child: Column(children: <Widget>[
                   LayoutBuilder(
                       builder: (context, constraints) {
                         if(flag1 == true) {
                           return Container(
                               margin: const EdgeInsets.all(10),
                               height: MediaQuery.of(context).size.height * 0.39,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(12),
                                 color: Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black,
                                     blurRadius: 2.0,
                                     spreadRadius: 0.0,
                                     offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                   )
                                 ],
                               ),
                              child:Scrollbar(
                                  isAlwaysShown: true,
                                  thickness: 15,
                                child:SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                     scrollDirection: Axis.vertical,
                                   child: Column(
                                    children: <Widget>[
                                          DataTable(
                                              columns:[
                                                DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Text('Species  ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Text(' Length   ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Text('  Girth  ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Text(' Volume   ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Text('Latitude ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Text('longitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                                DataColumn(label: Row(
                                                  children: <Widget>[
                                                    IconButton(icon:Icon(Icons.add_circle, color: Colors.blue,),
                                                      onPressed: () async{
                                                          await showInformationDialog(context);
                                                        print("-------------Total-log------------");
                                                        print(log_details);
                                                          setState(() {
                                                            DataRow;
                                                          });
                                                      },),
                                                  ],
                                                ),),
                                              ],
                                              rows:
                                             n_list.map(
                                                  ((index) =>
                                                      DataRow(cells: [
                                                       DataCell(Text((index+1).toString())),
                                                        DataCell(Container(width:180,child:Text(log_details[index]['species_of_tree'].toString(),))),
                                                        DataCell(Container(width:100,child:Text(log_details[index]['length'].toString(),))),
                                                        DataCell(Container(width:100,child:Text(log_details[index]['breadth'].toString(),))),
                                                        DataCell(Container(width:100,child:Text(log_details[index]['volume'].toString(),))),
                                                        DataCell(Container(width:100,child:Text(log_details[index]['latitude'].toString(),))),
                                                        DataCell(Container(width:100,child:Text(log_details[index]['longitude'].toString(),))),
                                                        DataCell( Row(
                                                          children: <Widget>[
                                                            IconButton(icon:Icon(Icons.remove_circle, color: Colors.red,),
                                                              onPressed: (){
                                                                print("-------------Remove--Total-log------------");
                                                                print(index);
                                                                print(log_details);
                                                                log_details.removeAt(index);
                                                                n_list.removeLast();
                                                                print(log_details);
                                                                setState(() {
                                                                  DataRow;
                                                                });
                                                              },),//--------------Remove Button
                                                            IconButton(icon:Icon(Icons.edit_rounded, color: Colors.blue,),
                                                              onPressed: () async{
                                                                print("-------------Edit--Total-log------------");
                                                                print(index);
                                                                print(log_details);
                                                                await EditInformationDialog(context,index);
                                                                setState(() {
                                                                  DataRow;
                                                                });
                                                              },)
                                                          ],
                                                        )),
                                                      ])
                                                  )).toList(),),
                                    ],
                                  ),
                                )
                              )
                           )
                           // ignore: missing_return
                           );
                         }else if(flag1 == false){
                           return Container(
                             color: Colors.white,
                           );
                         }
                       }
                   ),
                   Container(
                     width: double.infinity,
                     margin: const EdgeInsets.only(top: 5,left:15,right: 15),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 20, top: 10, bottom: 0),
                     child:Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           FlatButton.icon(
                             icon: Icon(Icons.image),
                             onPressed: () {
          //                     _RevenueApplication(ImageSource.gallery);
                             },
                             label: Text("Revenue Application "),

                           ),
                           Spacer(),
                           Icon(
                             Icons.check_circle,
                             color: (_Application?.path) == null ? Colors.red : Colors.green,
                             size: 28.0,
                           ),
                         ]
                     ),
                   ),
                   Container(
                     width: double.infinity,
                     margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 20, top: 10, bottom: 0),
                     child:Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           FlatButton.icon(
                             icon: Icon(Icons.image),
                             onPressed: () {
                        //       _RevenueApproval(ImageSource.gallery);
                             },
                             label: Text("Revenue Approval"),
                           ),
                           Spacer(),
                           Icon(
                             Icons.check_circle,
                             color: (_Approval?.path) == null ? Colors.red : Colors.green,
                             size: 28.0,
                           ),
                         ]
                     ),
                   ),
                   Container(
                     width: double.infinity,
                     margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 20, top: 10, bottom: 0),
                     child:Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           FlatButton.icon(
                             icon: Icon(Icons.image),
                             onPressed: () {
                               Declaration(ImageSource.gallery);
                             },
                             label: Text("Declaration"),
                           ),
                           Spacer(),
                           Icon(
                             Icons.check_circle,
                             color: (_Declaration?.path) == null ? Colors.red : Colors.green,
                             size: 28.0,
                           ),
                         ]
                     ),
                   ),
                   Container(
                     width: double.infinity,
                     margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 20, top: 10, bottom: 0),
                     child:Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           FlatButton.icon(
                             icon: Icon(Icons.image),
                             onPressed: () {
                               _LocationSketch(ImageSource.gallery);
                             },
                             label: Text("Location Sketch"),
                           ),
                           Spacer(),
                           Icon(
                             Icons.check_circle,
                             color: (_Location?.path) == null ? Colors.red : Colors.green,
                             size: 28.0,
                           ),
                         ]
                     ),
                   ),
                   Container(
                     width: double.infinity,
                     margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 20, top: 10, bottom: 0),
                     child:Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           FlatButton.icon(
                             icon: Icon(Icons.image),
                             onPressed: () {
                               _TreeOwnership(ImageSource.gallery);
                             },
                             label: Text("Tree Ownership Details"),
                           ),
                           Spacer(),
                           Icon(
                             Icons.check_circle,
                             color: (_Ownership?.path) == null ? Colors.red : Colors.green,
                             size: 28.0,
                           ),
                         ]
                     ),
                   ),
                   Container(
                     margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(20)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 10.0, top: 10, bottom: 0),
                     child:  DropdownButton<String>(
                       value: dropdownValue2,
                       isExpanded: true,
                       icon: Icon(Icons.arrow_drop_down),
                       iconSize: 24,
                       elevation: 16,
                       style: TextStyle(color: Colors.black, fontSize: 18),
                       hint:  Text("Select Photo Identity Proof"),
                       /*underline: Container(
                         height: 2,
                         color: Colors.grey,
                       ),*/
                       onChanged: (String data) {
                         setState(() {
                           dropdownValue2 = data;
                         });
                         print(dropdownValue2);
                       },
                       items: IdProof.map<DropdownMenuItem<String>>((String value) {
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),
                         );
                       }).toList(),
                     ),

                   ),
                   Container(
                     width: double.infinity,
                     margin: const EdgeInsets.only(top: 15,left:15,right: 15,bottom: 20),
                     decoration: new BoxDecoration(
                         border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                     ),
                     padding: const EdgeInsets.only(
                         left: 10.0, right: 15, top: 10, bottom: 5),
                     child:Row(
                         mainAxisSize: MainAxisSize.max,
                         children: <Widget>[
                           FlatButton.icon(
                             icon: Icon(Icons.image),
                             onPressed: () {
                               _IdProof(ImageSource.gallery);
                             },
                             label: Text("Upload Photo ID Proof"),
                           ),
                           Spacer(),
                           Icon(
                             Icons.check_circle,
                             color: (_Proof?.path) == null ? Colors.red : Colors.green,
                             size: 28.0,
                           ),
                         ]
                     ),
                   ),
                    ]
                 ),
             )
            ]
          )
         )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.navigate_next),
        backgroundColor: HexColor("#0499f2"),
        onPressed: () {
          if((_Application==null)||(_Approval==null)||(_Declaration==null)||(_Location==null)||(_Ownership==null)||(_Proof==null||(dropdownValue2==null))){
            Fluttertoast.showToast(
                msg:
                "Please Upload Images",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          }else {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 400),
                    transitionsBuilder:
                        (context, animation, animationTime, child) {
                      return ScaleTransition(
                        alignment: Alignment.topCenter,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, animationTime) {
                      return Form2(
                        sessionToken: sessionToken,
                        dropdownValue: dropdownValue,
                        dropdownValue1: dropdownValue1,
                        userName: userName,
                        userEmail: userEmail,
                        Name: Name,
                        Address: Address,
                        survey_no: survey_no,
                        Tree_Proposed_to_cut: Tree_Proposed_to_cut,
                        village: village,
                        Taluka: Taluka,
                        block: block,
                        District: District,
                        Pincode:Pincode,
                        Ownership: Ownership,
                        Purpose: Purpose,
                        holder_1: holder_1,
                        Application: _Application.path,
                        Approval: _Approval.path,
                        Declaration: _Declaration.path,
                        Location: _Location.path,
                        TreeOwnership: _Ownership.path,
                        IdProof: _Proof.path,
                        log_details:log_details,
                      );
                    }));
            setState(() {});
          }
        },
      ),
    );
  }
}








class table extends StatefulWidget {
  @override
  _tableState createState() => _tableState();
}
class _tableState extends State<table> {
  bool flag =true;
  List tcount=[1];
  List b;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
      child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,

            child:DataTable(

            columns: [
              DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text('Species  ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text(' Length   ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text('  Girth  ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text(' Volume   ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text('Latitude ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text('longitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              DataColumn(label: Text('',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),

            ],
            rows:
               tcount// Loops through dataColumnText, each iteration assigning the value to element
             .map(
             ((index) =>
              DataRow(cells: [
                DataCell((Text(tcount.length.toString()))),
                DataCell(TextField(decoration: InputDecoration(border: OutlineInputBorder(), hintText: ''),)),
                DataCell(TextField(decoration: InputDecoration(border: OutlineInputBorder(), hintText: ''),)),
                DataCell(TextField(decoration: InputDecoration(border: OutlineInputBorder(), hintText: ''),)),
                DataCell(TextField(decoration: InputDecoration(border: OutlineInputBorder(), hintText: ''),)),
                DataCell(TextField(decoration: InputDecoration(border: OutlineInputBorder(), hintText: ''),)),
                DataCell(TextField(decoration: InputDecoration(border: OutlineInputBorder(), hintText: ''),)),
                DataCell( Row(
                    children: <Widget>[
                      IconButton(icon:Icon(Icons.add_circle, color: Colors.blue,),
                      onPressed: (){
                       int a=1;
                        setState(() {
                          a=a++;
                        });
                       tcount.add(a);
                      print("-------------Total-log------------");
                      print(tcount);
                  },),
                      IconButton(icon:Icon(Icons.remove_circle, color: Colors.red,),
                        onPressed: (){
                          print("-------------Total-log------------");
                          print(tcount);
                          setState(() {
                            if(tcount.length>1) {
                              tcount.removeLast();
                            }
                          });
                        },)],
                )),
              ])
    )).toList(),
            ),
          ),
      )
    );
  }
}


