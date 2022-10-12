import 'package:Tigram/Form2.dart';
import 'package:Tigram/Form2Page4.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show File;
import 'package:image_picker/image_picker.dart';
class Form2Page3 extends StatefulWidget {
  String sessionToken ;
  String dropdownValue;
  String dropdownValue1;
  String userName ;
  String userEmail;
  String Name;
  String Address;
  String survey_no;
  String  village;
  String  Taluka;
  String  block;
  String District;
  String Pincode;
  String Ownership;
  String Purpose;
  Map<String,int> holder_1;
  Map<String,String> rev_holder_1;
  List values;
  @override
  Form2Page3({this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.rev_holder_1});
  _Form2Page3State createState() => _Form2Page3State(sessionToken,dropdownValue,dropdownValue1,userName,userEmail,Name,Address,survey_no,village,Taluka,block,District,Pincode,Ownership,Purpose,holder_1,rev_holder_1);
}

class _Form2Page3State extends State<Form2Page3> {
  String sessionToken ;
  String dropdownValue;
  String dropdownValue1;
  String userName ;
  String userEmail;
  String Name;
  String Address;
  String survey_no;
  String  village;
  String  Taluka;
  String  block;
  String District;
  String Pincode;
  String Ownership;
  String Purpose;
  Map<String,int> holder_1;
  Map<String,String> rev_holder_1;
  _Form2Page3State(this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.rev_holder_1);

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
  final ImagePicker _picker = ImagePicker();
  void _RevenueApplication(ImageSource source) async {
    print(Name+" "+Address+" "+survey_no+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Application = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Application.path);
    });
  }
  File _Approval;
  final ImagePicker _picker1 = ImagePicker();
  void _RevenueApproval(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Approval = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Approval.path);
    });
  }
  File _Declaration;
  final ImagePicker _picker2 = ImagePicker();
  void Declaration(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Declaration = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Declaration.path);
    });
  }
  File _Location;
  final ImagePicker _picker3 = ImagePicker();
  void _LocationSketch(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Location = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Location.path);
    });
  }
  File _Ownership;
  final ImagePicker _picker4 = ImagePicker();
  void _TreeOwnership(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _Ownership = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_Ownership.path);
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
  //{'name':'id'}

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
                      DropdownButton<String>(
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
                        onChanged: (String data) {
                          setState(() {
                            dropdownValue3=data ;
                          });
                        },
                        items: holder_1.map((String value,int Id) {
                          return MapEntry(
                            value,
                            DropdownMenuItem<String>(
                            value:Id.toString(),
                            child: Text(value,style: TextStyle(fontSize: 13),),
                            ));
                        }).values
                            .toList(),
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
                        autofocus: false,
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
                      /*Visibility(
                        visible: values.length==0?false:true,
                        child:  RichText(
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
                    String Spcies_name=rev_holder_1[dropdownValue3].toString();
                    Map<String,dynamic> logs={"species_of_tree":Spcies_name,"length":length.text,"breadth":girth.text,"volume":_getVolume((double.parse(girth.text==""?'0':girth.text)),(double.parse(length.text==""?'0':length.text))).toString(),"latitude":values[0].toString(),"longitude":values[1].toString(),"Id":dropdownValue3};
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
          dropdownValue3=log_details[index]['Id'];
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
                        items:holder_1.map((String value,int Id) {
                          return MapEntry(
                              value,
                              DropdownMenuItem<String>(
                                value:Id.toString(),
                                child: Text(value,style: TextStyle(fontSize: 13),),
                              ));
                        }).values
                            .toList(),
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
                        autofocus: false,
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
                      /*RichText(
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
                    String Spcies_name=rev_holder_1[dropdownValue3].toString();//holder_1.singleWhere((i)=>i.containsKey(dropdownValue3[i])).toString();
                    Map<String,dynamic> logs={"species_of_tree":Spcies_name,"length":length.text,"breadth":girth.text,"volume":_getVolume((double.parse(girth.text==""?'0':girth.text)),(double.parse(length.text==""?'0':length.text))).toString(),"latitude":values.length==0?latitude.text:values[0].toString(),"longitude":values.length==0?longitude.text:values[1].toString(),"Id":dropdownValue3};
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
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("FORM - II",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        //backgroundColor: ColorLinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        elevation: 0,
       // automaticallyImplyLeading: false,
      ),
      body:SingleChildScrollView(
          child: Center(
              child: Column(children: <Widget>[
                Container(
                  child: Column(children: <Widget>[
                     Container(
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
                                _RevenueApplication(ImageSource.gallery);
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
                                _RevenueApproval(ImageSource.gallery);
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
                      return Form2Page4(
                        sessionToken: sessionToken,
                        dropdownValue: dropdownValue,
                        dropdownValue1: dropdownValue1,
                        userName: userName,
                        userEmail: userEmail,
                        Name: Name,
                        Address: Address,
                        survey_no: survey_no,
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
