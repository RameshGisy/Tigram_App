import 'dart:convert';
import 'dart:io';
import 'package:Tigram/ViewApplication1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:Tigram/CheckPassStatus.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import  'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ViewApplication extends StatefulWidget {
  String userGroup;
  String sessionToken;
  int userId;
  final String Ids;
  List Range;

  ViewApplication({this.sessionToken,this.userId,this.userGroup,this.Ids,this.Range});
  @override
  _ViewApplicationState createState() => _ViewApplicationState(sessionToken,userId,userGroup,Ids,this.Range);
}

class _ViewApplicationState extends State<ViewApplication> {
  String sessionToken;
  String userGroup;
  int userId;
  final String Ids;
  List Range;


  _ViewApplicationState(this.sessionToken,this.userId,this.userGroup,this.Ids,this.Range);
 String url = 'http://13.235.67.23:8000/api/auth/ViewApplication';


  @override
  void initState()  {
    super.initState();
    setState(() {
      View_Record();
      print("----------------------------------View--Out put---------");
      print(Name.toString());
    });
  }
   List n_list =[];
   List Tree_species=[];
  final List species_nm=[];
   List treelog=[];
    List c=[];
  final List  species=[];
  final List length=[];
  final List breadth=[];
  final  List volume=[];
  final  List latit=[];
  final  List longit=[];

  final List s=[];
  final List Sname=[];
  final List Slat=[];
  final List Slong=[];
  final List Slen=[];
  final List Sbreath=[];
  final List Svol=[];

  String Name='';
  String Address='';
  String SurveyNo='';
  String VillageName='';
  String OwnershipProof='';
  String treeSpecies='';
  String purpose='';
  String proposed='';
  int All_Record=0;

  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;

  //----images----
    String img_signature;
    String img_revenue_approval;
    String img_declaration;
    String img_revenue_application;
    String img_location_sktech;
    String img_tree_ownership_detail;
    String img_aadhar_detail;
  //----end images----
  //---vehical---------------
    String vehical_reg_no;
    String driver_name;
    String driver_phone;
    String mode_of_transport;
    String license_image;
  //---end vehical-----------
  View_Record() async {
    String url = 'http://13.235.67.23:8000/api/auth/ViewApplication';
    Map data = {
      "app_id": Ids
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    // List list = responseJSON["data"];
    // print(list);
    print("-----------------View -Application------------");
    print(responseJSON);
    setState(() {
      Name = responseJSON['data']['applications'][0]['name'].toString();
      Address = responseJSON['data']['applications'][0]['address'].toString();
      SurveyNo = responseJSON['data']['applications'][0]['survey_no'].toString();
      VillageName = responseJSON['data']['applications'][0]['village'].toString();
      OwnershipProof = responseJSON['data']['applications'][0]['name'].toString();
      treeSpecies = responseJSON['data']['applications'][0]['species_of_trees'].toString();
      purpose = responseJSON['data']['applications'][0]['purpose'].toString();
      proposed = responseJSON['data']['applications'][0]['trees_proposed_to_cut'].toString();
      verify_officer=responseJSON['data']['applications'][0]['verify_office'];

      deputy_range_officer=responseJSON['data']['applications'][0]['depty_range_officer'];
      verify_range_officer=responseJSON['data']['applications'][0]['verify_range_officer'];
      is_form_two=responseJSON['data']['applications'][0]['is_form_two'];
      assigned_deputy2_id=responseJSON['data']['applications'][0]['assigned_deputy2_id'];
      assigned_deputy1_id=responseJSON['data']['applications'][0]['assigned_deputy1_id'];
      verify_deputy2=responseJSON['data']['applications'][0]['verify_deputy2'];
      division_officer=responseJSON['data']['applications'][0]['division_officer'];
      other_state=responseJSON['data']['applications'][0]['other_state'];
      verify_forest1=responseJSON['data']['applications'][0]['verify_forest1'];

      for(int i=0;i<responseJSON['data']['species_location'].length;i++){
        s.add(i);
        Sname.add(responseJSON['data']['species_location'][i]['species_tree__name'].toString());
        Slat.add(responseJSON['data']['species_location'][i]['latitude']);
        Slong.add(responseJSON['data']['species_location'][i]['longitude']);
        Slen.add(responseJSON['data']['species_location'][i]['length']);
        Sbreath.add(responseJSON['data']['species_location'][i]['breadth']);
        Svol.add(responseJSON['data']['species_location'][i]['volume']);
      }

    });
    print("------------------------------------Image-Document---------------------------");
    setState(() {
      img_signature=responseJSON['data']['image_documents'][0]['signature_img'];
      img_revenue_approval=responseJSON['data']['image_documents'][0]['revenue_approval'];
      img_declaration=responseJSON['data']['image_documents'][0]['declaration'].toString();
      img_revenue_application=responseJSON['data']['image_documents'][0]['revenue_application'];
      img_location_sktech=responseJSON['data']['image_documents'][0]['location_sktech'];
      img_tree_ownership_detail=responseJSON['data']['image_documents'][0]['tree_ownership_detail'];
      img_aadhar_detail=responseJSON['data']['image_documents'][0]['aadhar_detail'];
    });


    //---------------------Species--list----------------------------------------
    print("------------------------------------Species--list----------------------------");
    Tree_species = responseJSON['data']['species_list'];
    print(responseJSON['data']['timber_log'].length);
    for(int i=0;i< responseJSON['data']['timber_log'].length;i++) {
      c.add(i);
      // n_list.add(i);
      species.add(responseJSON['data']['timber_log'][i]['species_of_tree']);
      length.add(responseJSON['data']['timber_log'][i]['length']);
      breadth.add(responseJSON['data']['timber_log'][i]['breadth']);
      volume.add(responseJSON['data']['timber_log'][i]['volume']);
      latit.add(responseJSON['data']['timber_log'][i]['latitude']);
      longit.add(responseJSON['data']['timber_log'][i]['longitude']);
      print(species.toString());
      /*print(length);
      print(breadth);
      print(volume);
      print(latit);
      print(longit);*/
    }
    print('-------log Details------');

    //------------------End-Species-List----------------------------------------
    //for(int i=0;i<Tree_species.length;i++){
    //  species_nm.add(Tree_species[i]['name']);
   // }
    n_list=c;
    treelog = responseJSON['data']['timber_log'];
    log_details=treelog;
    //-----------------------Vehical-Details------------------------------------
    print("------------------------------------Vehical-Details----------------------------");
    if(responseJSON['data']['isvehicle']!="Not Applicable") {
      vehical_reg_no = responseJSON['data']['vehicle']['vehicle_reg_no'].toString();
      driver_name = responseJSON['data']['vehicle']['driver_name'].toString();
      driver_phone = responseJSON['data']['vehicle']['driver_phone'].toString();
      mode_of_transport = responseJSON['data']['vehicle']['mode_of_transport'].toString();
      license_image = responseJSON['data']['vehicle']['license_image'].toString();
    }
    //----------------------------------End-Vehical-Details---------------------

  }


//------------Update Log Details----------------------------------------------
  /*Updatelogs() async{
    final String url = 'http://65.1.132.43:8080/api/auth/UpdateTimberlog';
    Map data = {
      "app_id":Ids,
      "log_details":log_details//[{"species":"test","length":"25","breadth":"650","volume":750,"latitude":"85.25","longitude":"8580.2"},{"species":"test","length":"25","breadth":"650","volume":750,"latitude":"85.25","longitude":"8580.2"}]
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
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("----------------------Update Logs----------------");
    print(responseJson);
  }*/
//------------------End Update log Details--------------------------------------


  //----------------------
  bool X=false;
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
                  child: GoogleMap(
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
                    child: Text('OK ',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                    onPressed: () {
                      setState(() {
                        X=true;
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



//---------------- Get-log-Details----------------------------------------------

  String dropdownValue3;
  Map<String,TextEditingController> textEditingControllers = {};
  TextEditingController leng = TextEditingController();
  TextEditingController Girth = TextEditingController();
   // TextEditingController volume = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  var b=1;
  int a=0;
  List log_details=[];
  List d=[];

  /* List  Length=[];
  List  Girth=[];
  List  Volume=[];
  List  Latitude=[];
  List  Longitude=[];*/

  Map<String,String> logs={};
  final List<TextEditingController> _controllers = List();
  double v;
  double _getVolume(double girth,double length){
    v=(girth/4)*(girth/4)*length;
    return v;
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            //dropdownValue3='Rosewood (Dalbergia latifolia)';
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
                        items: Tree_species.toSet().map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value:value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: leng,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Length";
                        },
                        decoration: InputDecoration(hintText: "Please Enter Length"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Girth,
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
                     /* RichText(
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
                    Map<String,dynamic> logs={"species_of_tree":dropdownValue3,"length":leng.text,"volume":_getVolume((double.parse(Girth.text==""?'0':Girth.text)),(double.parse(leng.text==""?'0':leng.text))).toString(),"breadth":Girth.text,"latitude":values.length==0?latitude.text:values[0].toString(),"longitude":values.length==0?latitude.text:values[1].toString()};
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
                    print(species);
                    print(d);
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
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
          dropdownValue3=log_details[index]['species_of_tree'].toString();
          leng.text=log_details[index]['length'].toString();
          Girth.text=log_details[index]['breadth'].toString();
         // Volume=log_details[index]['volume'].toString();
          latitude.text=log_details[index]['latitude'].toString();
          longitude.text=log_details[index]['longitude'].toString();
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
                        items: Tree_species.toSet().map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value:value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        //initialValue: log_details[index]['length'],
                        controller:leng,
                        validator: (value) {

                          return value.isNotEmpty ? null : "Enter Length";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter Length"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Girth,
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
                  child: Text('OK ',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                  onTap: () {
                    Map<String,dynamic> logs={"species_of_tree":dropdownValue3,"length":leng.text,"volume":_getVolume((double.parse(Girth.text==""?'0':Girth.text)),(double.parse(leng.text==""?'0':leng.text))).toString(),"breadth":Girth.text,"latitude":values.length==0?latitude.text:values[0].toString(),"longitude":values.length==0?latitude.text:values[1].toString()};
                    // log_details.elementAt(int.parse(source));
                    log_details[index]=logs;
                    int n=log_details.length;
                    n_list=[];
                    print(n);
                    for(int i=0;i<n;i++){
                      n_list.add(i);
                    }
                    print("----n_list--");
                    print(n_list);
                    print(species);
                    print(d);
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      leng.clear();
                      Girth.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }


//---------------End- Log- Details----------------------------------------------
//---------------------------Assign--Log-details--------------------------------

//---------------------------End-Assign-log-Details-----------------------------


  /*final List<Map<String, String>> TreeLogs = [
    {"Sr.No": "1", "Length": "35", "Breadth": "16", "Volume":"1239"},
    {"Sr.No": "2", "Length": "60", "Breadth": "20", "Volume":"1291"},
    {"Sr.No": "3", "Length": "142", "Breadth": "35", "Volume":"2230"},
  ];*/

bool Edit=false;
bool userEdit=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: NewGradientAppBar(
        title: Text("Application View"),
       gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.blueGrey,
                      width: 1
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Card(child: ListTile(title: Text('Name', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      trailing: Text(Name.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text('Address', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(Address.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text('List showing the species of tree or trees proposed to be cut,etc', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(treeSpecies.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text('Survey No. and extent of the field or fields on which the tree or treesproposed to be cut,uprooted or burnt stand', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(SurveyNo.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text('Name of the Village/Taluka/Block and District where the land on which the tree or trees stand/lie', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(VillageName.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text('Proof of ownership of the trees', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(OwnershipProof.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text('Purpose for which trees are proposed to be cut,etc', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(purpose.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),

                    /*Card(child: ListTile(title: Text('Details of Regeneration Proposed', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                      elevation: 2,),
                    Card(child: ListTile(title: Text(proposed.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                    ),
                      elevation: 2,),*/
                    Visibility(
                      visible: is_form_two==true?true:false,
                      child: Text('----------TREES DESCRIPTIONS-----------', textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),),

                  Visibility(visible: is_form_two==true?true:false,
                    child:Container(
                        margin: const EdgeInsets.only(top: 10,left:8,right:8,bottom: 10),
                        child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child:DataTable(
                                sortColumnIndex: 0,
                                sortAscending: true,
                                dividerThickness: 2,
                                columnSpacing: 25,
                                showBottomBorder: true,
                                headingRowColor:
                                MaterialStateColor.resolveWith((states) => Colors.green),
                                columns: [
                                  DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  DataColumn(label: Text('Species',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  DataColumn(label: Text('Length',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  DataColumn(label: Text('Girth',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  DataColumn(label: Text('Volume',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  DataColumn(label: Text('Latitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  DataColumn(label: Text('Longitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                ],
                                rows:
                                // Loops through dataColumnText, each iteration assigning the value to element
                                s  .map(
                                  ((value) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text((value+1).toString())),
                                      DataCell(Text(Sname[value].toString())),//Extracting from Map element the value
                                      DataCell(Text(Slen[value]==null?"":Slen[value].toString())),
                                      DataCell(Text(Slong[value]==null?"":Slong[value].toString())),
                                      DataCell(Text(Svol[value]==null?"":Svol[value].toString())),
                                      DataCell(Text(Slat[value]==null?"":Slat[value].toString())),
                                      DataCell(Text(Slong[value]==null?"":Slong[value].toString())),
                                    ],
                                  )),
                                ).toList(),
                              ),
                            )
                        )
                    ),
                ),
                    Text('----------VOLUME DESCRIPTIONS-----------', textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),

                    Row(
                        children:[
                          Spacer(),
                        Visibility(
                          visible: (userGroup=='deputy range officer' && species.length!=0)?true:false,
                          child:ElevatedButton.icon(
                            onPressed: () async{
                              setState(() {
                                Edit=true;
                              });
                            },
                            icon: Icon(Icons.edit_rounded, size: 18),
                            label: Text("Edit"),
                          )/*IconButton(
                            icon: new Icon(Icons.edit_rounded),
                            color: Colors.blue,
                            onPressed: ()async{
                              setState(() {
                                Edit=true;
                              });
                            },
                          ),*/
                        ),
                          Visibility(
                            visible: (userGroup=='user')?true:false,
                            child:ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                  userEdit=true;
                                  });// Respond to button press
                                },
                                icon: Icon(Icons.edit_rounded, size: 18),
                                label: Text("Edit"),

                                )
                            /*IconButton(
                              icon: new Icon(Icons.edit_rounded),
                              color: Colors.blue,
                              onPressed: ()async{
                                setState(() {
                                  userEdit=true;
                                });
                              },
                            ),*/
                          ),
                          Spacer(),
                          Visibility(
                            visible: (Edit==true)?true:false,
                            child:ElevatedButton.icon(
                              onPressed: ()async{
                                if(log_details.length==0){
                                  Fluttertoast.showToast(
                                      msg:"Log Details is Empty",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }else{
                                  final String url = 'http://13.235.67.23:8000/api/auth/UpdateTimberlog';
                                  Map data = {
                                    "app_id":Ids,
                                    "log_details":log_details//[{"species":"test","length":"25","breadth":"650","volume":750,"latitude":"85.25","longitude":"8580.2"},{"species":"test","length":"25","breadth":"650","volume":750,"latitude":"85.25","longitude":"8580.2"}]
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
                                  print(response);
                                  Map<String, dynamic> responseJson = json.decode(response.body);
                                  print("----------------------Update Logs----------------");
                                  print(responseJson);
                                  Fluttertoast.showToast(
                                      msg:responseJson['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }
                              },
                              icon: new Icon(Icons.save_rounded),
                              label: Text("SAVE"),
                            ),
                          ),
                          Visibility(
                            visible: (userEdit==true)?true:false,
                              child:ElevatedButton.icon(
                                onPressed: () async{
                                  if(log_details.length==0){
                                    Fluttertoast.showToast(
                                        msg:"Log Details is Empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  }else{
                                    final String url = 'http://13.235.67.23:8000/api/auth/UpdateTimberlog';
                                    Map data = {
                                      "app_id":Ids,
                                      "log_details":log_details
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
                                    print(response);
                                    Map<String, dynamic> responseJson = json.decode(response.body);
                                    print("----------------------Update Logs----------------");
                                    print(responseJson);
                                    Fluttertoast.showToast(
                                        msg:responseJson['message'],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  }
                                  // Respond to button press
                                },
                                icon: Icon(Icons.save_rounded, size: 18),
                                label: Text("SAVE"),
                              )
                            /*child:IconButton(
                              icon: new Icon(Icons.save_rounded),
                              color: Colors.blue,
                              onPressed: ()async{
                                if(log_details.length==0){
                                  Fluttertoast.showToast(
                                      msg:"Log Details is Empty",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }else{
                                  final String url = 'http://65.1.132.43:8080/api/auth/UpdateTimberlog';
                                  Map data = {
                                    "app_id":Ids,
                                    "log_details":log_details
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
                                  print(response);
                                  Map<String, dynamic> responseJson = json.decode(response.body);
                                  print("----------------------Update Logs----------------");
                                  print(responseJson);
                                  Fluttertoast.showToast(
                                      msg:responseJson['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }
                              },
                            ),*/
                          ),
                          Spacer(),
                      ]
                    ),
                    LayoutBuilder(
                        builder: (context, constraints) {
                          if(Edit==true) {
                            return  Container(
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
                                child:SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
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
                                          )).toList(),)
                                )
                              ),
                            );
                          }else if(userEdit==true){
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
                                  child:SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
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
                                            )).toList(),)
                                  )
                              ),
                            );
                          } else {
                            return  Container(
                              margin: const EdgeInsets.only(top: 10,left:8,right:8,bottom: 10),
                              child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                                child:SingleChildScrollView(
                                   scrollDirection: Axis.vertical,
                                  child:DataTable(
                                    sortColumnIndex: 0,
                                    sortAscending: true,
                                    dividerThickness: 2,
                                    columnSpacing: 25,
                                    showBottomBorder: true,
                                    headingRowColor:
                                    MaterialStateColor.resolveWith((states) => Colors.orange),
                                    columns: [
                                      DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      DataColumn(label: Text('Species',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      DataColumn(label: Text('Length',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      DataColumn(label: Text('Girth',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      DataColumn(label: Text('Volume',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      DataColumn(label: Text('Latitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      DataColumn(label: Text('Longitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                    ],
                                    rows:
                                    // Loops through dataColumnText, each iteration assigning the value to element
                                    c  .map(
                                      ((value) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text((value+1).toString())),
                                          DataCell(Text(species[value].toString())),//Extracting from Map element the value
                                          DataCell(Text(length[value].toString())),
                                          DataCell(Text(breadth[value].toString())),
                                          DataCell(Text(volume[value].toString())),
                                          DataCell(Text(latit[value].toString())),
                                          DataCell(Text(longit[value].toString())),
                                        ],
                                      )),
                                    ).toList(),
                                  ),
                          )
                              )
                            );
                          }
                        }
                    ),
                        ])
                     ),
                  ],
             ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.navigate_next),
          backgroundColor: HexColor("#0499f2"),
        onPressed: () {
          Navigator.push(
              context,MaterialPageRoute(builder: (_) =>
              ViewApplication1(
                sessionToken:sessionToken,
                userGroup:userGroup,
                userId:userId,
                Ids:Ids,
                Range:Range,
                img_signature:img_signature,
                img_revenue_approval:img_revenue_approval,
                img_declaration:img_declaration,
                img_revenue_application:img_revenue_application,
                img_location_sktech:img_location_sktech,
                img_tree_ownership_detail:img_tree_ownership_detail,
                img_aadhar_detail:img_aadhar_detail,
                verify_officer:verify_officer,
                deputy_range_officer:deputy_range_officer,
                verify_range_officer:verify_range_officer,
                is_form_two:is_form_two,
                assigned_deputy2_id:assigned_deputy2_id,
                assigned_deputy1_id:assigned_deputy1_id,
                verify_deputy2:verify_deputy2,
                division_officer:division_officer,
                other_state:other_state,
                verify_forest1:verify_forest1,
                //sessionToken:sessionToken,
              ))
          );
        },
      ),
       );
    }
}
