import 'dart:convert';
import 'package:Tigram/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io'as Io;


class noc_Form2 extends StatefulWidget {
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

  String Purpose;
  List holder_1;
  bool flag1;
  noc_Form2({this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.Tree_Proposed_to_cut,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Purpose,this.holder_1,this.flag1});
  @override
  _noc_Form2State createState() => _noc_Form2State(sessionToken,dropdownValue,dropdownValue1,userName,userEmail,Name,Address,survey_no,Tree_Proposed_to_cut,village,Taluka,block,District,Pincode,Purpose,holder_1,flag1);
}

class _noc_Form2State extends State<noc_Form2> {
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
  String Purpose;
  List holder_1;
  bool flag1;
_noc_Form2State(this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.Tree_Proposed_to_cut,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Purpose,this.holder_1,this.flag1);


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
                clipBehavior: Clip.antiAliasWithSaveLayer,
                content: Container(
                  width:MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height,
                  child:GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  mapType: MapType.normal,
                  //padding: EdgeInsets.only(bottom: 75.0, top: 0, right: 0, left: 0),
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
                    child: Text('OK',style: TextStyle(color: Colors.black),),
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

  Widget getLong(BuildContext context,List values){
    return RichText(
      textAlign: TextAlign.start,
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
                          IconButton(icon:Icon(Icons.location_on,color: Colors.lightBlue), onPressed: (){
                            setState(() {
                              AddMap(context);
                            });
                          }),
                        ],
                      ),
                     /* Visibility(
                        visible: V,
                        child:getLag(context, values),
                      ),
                      Visibility(
                        visible: V,
                        child:getLong(context, values),
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
                        decoration: InputDecoration(hintText: "Please Enter Length"),
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

  bool isShow=false;
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
  //--------------Form2----

  File _Signature;
  final ImagePicker _picker1 = ImagePicker();
  void Signature(ImageSource source) async {
    //print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership+" "+Application+" "+Approval+" "+Declaration+" "+" "+Location+" "+TreeOwnership+" "+IdProof);
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Signature = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Signature.path);
    });
  }
  TextEditingController destination_add = TextEditingController();
  TextEditingController vehical_reg_no = TextEditingController();
  TextEditingController driver_name = TextEditingController();
  TextEditingController driver_phone = TextEditingController();
  TextEditingController mode_transport = TextEditingController();
  //--Code For radio button--
  int _radioValue = 0;
  String maintenance;
  int maintenance_cost;
  int estimatedMaintenanceCost;
  bool isEnabled;
  bool flag2= false;
  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'YES';
        setState(() {
          flag2=true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'NO';
        setState(() {
          flag2=false;
        });
      }
    });
  }
  File _Proof;
  final ImagePicker _picker5 = ImagePicker();
  void _IdProof(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Proof = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Proof.path);
    });
  }

  //-------------Form2-----
  String ImageAadhar(){
    final bytes6 = Io.File(_Proof.path).readAsBytesSync();
    String aadhar_base = IdProof != null ? 'data:image/png;base64,' + base64Encode(bytes6) : '';
    print('------------8--------------');
    print(aadhar_base);
    return aadhar_base;
  }
  String ImageSignature(){
    final bytes7 = Io.File(_Signature.path).readAsBytesSync();
    String sign_base = _Signature.path != null ? 'data:image/png;base64,' + base64Encode(bytes7) : '';
    print('------------8--------------');
    print(sign_base);
    return sign_base;
  }
  //-------------------------------Progress bar---------------------------------
  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 1));
    return false;
  }
  //------------------------------End-Progress-Bar------------------------------
  @override
  Widget build(BuildContext context) {
    //print(_controllers);
    return Scaffold(
      appBar: NewGradientAppBar(
        // backgroundColor: Colors.blueGrey,
        title: Text(" NOC Form"),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        elevation: 0,
        //automaticallyImplyLeading: false,
      ),
      body:Scrollbar(
        isAlwaysShown: true,
        thickness: 8,
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                                                      DataCell(Container(width:160,child:Text(log_details[index]['species_of_tree'].toString(),))),
                                                      DataCell(Container(width:60,child:Text(log_details[index]['length'].toString(),))),
                                                      DataCell(Container(width:60,child:Text(log_details[index]['breadth'].toString(),))),
                                                      DataCell(Container(width:60,child:Text(log_details[index]['volume'].toString(),))),
                                                      DataCell(Container(width:80,child:Text(log_details[index]['latitude'].toString(),))),
                                                      DataCell(Container(width:80,child:Text(log_details[index]['longitude'].toString(),))),
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
                      margin: const EdgeInsets.only(top: 5,left:15,right: 15),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
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
                      margin: const EdgeInsets.only(top: 15,left:15,right: 15,bottom: 15),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                      ),
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 15, top: 10,),
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
                        Container(
                         padding: const EdgeInsets.only(left: 15,
                              right: 15.0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: destination_add,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide( width: 2),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(14.0)),
                              ),
                              labelText: 'Destination',
                              hintText: 'Destination Details',
                            ),
                          ),
                        ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0,left: 15),
                      width: double.infinity,
                      child: Column(children: <Widget>[
                        Row(
                            children: <Widget>[
                              Expanded(
                                child: new Text(
                                  'Enter Vehicle Details',
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child:RadioListTile(
                                  title: Text(
                                    'Yes',
                                    style: TextStyle(fontFamily: 'Lato'),
                                  ), value: 1,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                              ),
                              Expanded(
                                child:RadioListTile(
                                  title: Text(
                                    'No',
                                    style: TextStyle(fontFamily: 'Lato'),
                                  ),
                                  value: 2,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                              ),
                            ]
                        ),
                        LayoutBuilder(
                            builder: (context, constraints) {
                              if(flag2 == true){
                                return Container(
                                    child: Column(children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(right: 15.0,top:10,bottom: 0),
                                          child: TextField(
                                            controller: vehical_reg_no,
                                            decoration: InputDecoration(border: OutlineInputBorder(
                                              borderSide: BorderSide( width: 2),
                                              borderRadius: const BorderRadius.all(
                                                  const Radius.circular(14.0)),
                                            ),
                                              labelText: "Vehicle Registration Number",

                                            ),
                                          )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, top: 15, bottom: 0),
                                        //padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: TextField(
                                          controller: driver_name,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide( width: 2),
                                              borderRadius: const BorderRadius.all(
                                                  const Radius.circular(14.0)),
                                            ),
                                            labelText: 'Name of the driver',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, top: 15, bottom: 0),
                                        //padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: TextField(
                                          controller: driver_phone,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide( width: 2),
                                              borderRadius: const BorderRadius.all(
                                                  const Radius.circular(14.0)),
                                            ),
                                            labelText: 'Phone Number of the Driver',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, top: 15, bottom: 0), //padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: TextField(
                                          controller:mode_transport,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide( width: 2),
                                              borderRadius: const BorderRadius.all(
                                                  const Radius.circular(14.0)),
                                            ),
                                            labelText: 'Vehicle Used',
                                          ),
                                        ),
                                      ),
                                    ])
                                );
                              }else if(flag2 == false){
                                return Container (
                                  color: Colors.white,
                                );
                              }
                            }),
                        Visibility(
                          visible: isShow,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                            strokeWidth: 8,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15,right: 15),
                          decoration: new BoxDecoration(
                              border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                          ),
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 10, bottom: 0),
                          child:Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                FlatButton.icon(
                                  icon: Icon(Icons.image),
                                  onPressed: () {
                                    Signature(ImageSource.gallery);
                                    print(_Signature.path);
                                  },
                                  label: Text("Signature"),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.check_circle,
                                  color: (_Signature?.path) == null ? Colors.red : Colors.green,
                                  size: 28.0,
                                ),
                              ]
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                          child:FlatButton(
                            onPressed: () async {
                              if((Name.length==0)||(Address.length==0)||(survey_no.length==0)||(Tree_Proposed_to_cut.length==0)||(village.length==0)
                                  ||(destination_add.text.length==0)){
                                Fluttertoast.showToast(
                                    msg:"Please select and fill all Field",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              }
                              else {
                                  setState(() {
                                    isShow=true;
                                  });
                                  final String url = 'http://13.235.67.23:8000/api/auth/Apply_for_noc/';
                                  Map data={
                                    "name":Name,
                                    "address":Address,
                                    "survey_no":survey_no,
                                    "age":25,
                                    "tree_proposed":Tree_Proposed_to_cut,
                                    "village":village,
                                    "district":District,
                                    "area_range":dropdownValue,
                                    "division":dropdownValue1,
                                    "destination_address":destination_add.text,
                                    "pincode":Pincode,
                                    "block":block,
                                    "taluka":Taluka,
                                    "tree_species":holder_1,
                                    "purpose_cut":Purpose,
                                    "trees_cutted":true,
                                    "vehicel_reg":vehical_reg_no.text,
                                    "driver_name":driver_name.text,
                                    "phone":driver_phone.text,
                                    "mode":mode_transport.text,
                                    "aadhar_card_img": {
                                      "type": ".png",
                                      "image":ImageAadhar(),
                                    },
                                    "signature_img": {
                                      "type": ".png",
                                      "image":ImageSignature(),
                                    },
                                    "log_details":log_details
                                    //[{"species_of_tree":"test","length":"25","breadth":"650","volume":"5252","latitude":"85.25","longitude":"8580.2"},{"species_of_tree":"test","length":"25","breadth":"650","volume":"5252","latitude":"85.25","longitude":"8580.2"}]
                                  };
                                  print(data);
                                  var body = json.encode(data);
                                  print(body);
                                  var response = await http.post(url,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': "token $sessionToken"
                                      },
                                      body: body);

                                  Map<String, dynamic> responseJson = json.decode(
                                      response.body);
                                  print("----------------From Submit-----------------------");
                                  print(responseJson);

                                  print(responseJson);
                                  Fluttertoast.showToast(msg: responseJson['message'].toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 8,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                  destination_add.clear();
                                  setState(() {
                                    isShow=false;
                                  });
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                        Duration(milliseconds: 250),
                                        transitionsBuilder: (context,
                                            animation,
                                            animationTime,
                                            child) {
                                          return ScaleTransition(
                                            alignment: Alignment.topCenter,
                                            scale: animation,
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return HomePage(
                                            sessionToken: sessionToken,
                                            userName: userName,
                                            userEmail: userEmail,
                                          );
                                        }));
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        )
                            ]
                            ),
                          )
                ]
                  )
               ),

      ]),

    ),
    )
    )
    );
  }
}

