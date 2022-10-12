import 'dart:convert';

import 'package:Tigram/Form3Page2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Form3Page1 extends StatefulWidget {
  String Ids1;
  String sessionToken;
  Form3Page1({this.sessionToken,this.Ids1});
  @override
  _Form3Page1State createState() => _Form3Page1State(sessionToken,Ids1);
}

class _Form3Page1State extends State<Form3Page1> {
  _Form3Page1State(this.sessionToken,this.Ids1);
  String sessionToken;
  String Ids1;
  @override
  void initState() {
    super.initState();
    setState(() {
      getSpecies();
      getItems();
      ViewApplication();

      //ListDivision();
    });
  }
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Quantity = TextEditingController();
  String Name;
  String Address;
  List s=[];
  List Sname=[];
  List Slat=[];
  List Slong=[];
  final List Slen=[];
  final List Sbreath=[];
  final List Svol=[];

  Future<void> ViewApplication() async {

    String url = 'http://13.235.67.23:8000/api/auth/ViewApplication';
    Map data = {
      "app_id": Ids1
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
      name.text=Name;
      address.text=Address;
      print("------------------------------------Species--list----------------------------");
      Tree_species = responseJSON['data']['species_list'];
      print(responseJSON['data']['timber_log'].length);
     // treelog = responseJSON['data']['timber_log'];

      for(int i=0;i< responseJSON['data']['timber_log'].length;i++) {
        c.add(i);
        // n_list.add(i);
        species.add(responseJSON['data']['timber_log'][i]['species_of_tree'].toString());
        length.add(responseJSON['data']['timber_log'][i]['length'].toString());
        breadth.add(responseJSON['data']['timber_log'][i]['breadth'].toString());
        volume.add(responseJSON['data']['timber_log'][i]['volume'].toString());
        latit.add(responseJSON['data']['timber_log'][i]['latitude'].toString());
        longit.add(responseJSON['data']['timber_log'][i]['longitude'].toString());
        print(species);
        print(length);
        print(breadth);
        print(volume);
        print(latit);
        print(longit);
      }
      for(int i=0;i<responseJSON['data']['species_location'].length;i++){
        s.add(i);
        Sname.add(responseJSON['data']['species_location'][i]['species_tree__name']);
        Slat.add(responseJSON['data']['species_location'][i]['latitude']);
        Slong.add(responseJSON['data']['species_location'][i]['longitude']);
        Slen.add(responseJSON['data']['species_location'][i]['length']);
        Sbreath.add(responseJSON['data']['species_location'][i]['breadth']);
        Svol.add(responseJSON['data']['species_location'][i]['volume']);
      }

    });
  }


  Map<String,dynamic> ListOfSpecies={} ;
  Map <String,int> holder_1 = {};
  Map<String,String> rev_holder_1={};
  var holder_IDs = [];
  getSpecies()async{
    print("----------------ALL Species----------------");
    final String url = 'http://65.1.132.43:8080/api/auth/TreeSpeciesList';
    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    List LOC=responseJSON['data'];
    LOC = LOC.where((i)=> i['is_noc']==false).toList();
    print(LOC.length);
    setState(() {
      for(var i=0;i<LOC.length;i++){
        print('-----------------Madhuri---------');
        print(LOC[i]['name']);
        ListOfSpecies[LOC[i]['name']]=[LOC[i]['id'],false];
        rev_holder_1[LOC[i]['id'].toString()]=LOC[i]['name'].toString();
      }
    });
  }
  getItems() {
    ListOfSpecies.forEach((key, value) {
      if (value == true) {
        //holder_1.add(key);
        holder_1[key] = value[0];
        holder_IDs.add(value[0]);
      }
    });
  }

  bool Edit=false;
  bool userEdit=false;

  //----------------------------Add--Map-----------------------------------
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
                      values.add(latlang.latitude.toStringAsPrecision(8));
                      values.add(latlang.longitude.toStringAsPrecision(8));
                      print(values);
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(latlang, 15.0));//we will call this function when pressed on the map
                    },
                  ),
                ),
                title: Text('Trees Logs'),
                actions: <Widget>[
                  InkWell(
                    child: Text('OK    ',style: TextStyle(color: Colors.blue),),
                    onTap: () {
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


  //---------------------------End--Map------------------------------------


  //-----------------------------Log--Form-----------------------------------
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
  Map<String,String> logs={};
  final List<TextEditingController> _controllers = List();
  double v;
  double _getVolume(double girth,double length){
    v=(girth/4)*(girth/4)*length;
    return v;
  }
  List n_list =[];
  List c=[];
  List Tree_species=[];
  final List  species=[];
  final List length=[];
  final List breadth=[];
  final  List volume=[];
  final  List latit=[];
  final  List longit=[];
  //--------Add-log-Form-------------
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
                        items: Tree_species.map<DropdownMenuItem<dynamic>>((dynamic value) {
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
                      RichText(
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
                      ),
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK     ',
                    style: TextStyle(color: Colors.blue),),
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

    //-----------End-Add-log----------------------------

      //---------------Edit-log------------------------
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
                        items: Tree_species.map<DropdownMenuItem<dynamic>>((dynamic value) {
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
                      RichText(
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
                      ),
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   ',style: TextStyle(color: Colors.blue),),
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
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }
        //-----End-Edit-log--------------
  //----------------------------End-Log-Form---------------------------------
  List v_species;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  NewGradientAppBar(
        title: Text("FORM - III",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        elevation: 0,
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15,bottom: 0),
              child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide( width: 2),
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter  Name of the person to whom pass is granted'),
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide( width: 2),
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(14.0)),
                    ),

                    labelText: 'Residence',
                    hintText: 'Residence of the person to whom pass is granted'),
                //maxLines: ,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
            ),
            Padding(padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Species",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20,)),
                  TextSpan(
                      text: "*",
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                      )),
                ]),
              ),
            ),

            Visibility(
                visible: Tree_species==''?false:true,
                child:Container(
                  margin: const EdgeInsets.all(10),
                  //width:MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount:Tree_species.toSet().toList().length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          //color: Colors.amber[species[index]],

                          child: Card(child: ListTile(title: Text(Tree_species.toSet().toList()[index].toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          ),
                            elevation: 2,),
                        );
                      }
                  ),
                )

                    /**/

                  /*ListView(
                scrollDirection: Axis.vertical,
                children: ListOfSpecies.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: ListOfSpecies[key][1],
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        ListOfSpecies[key][1] = value;
                      });
                      if (value == true) {
                        // holder_1.add(key);
                        holder_1[key]=ListOfSpecies[key][0];
                        holder_IDs.add(ListOfSpecies[key][0]);

                      }else if(value == false){
                        //holder_1.remove(key);
                        holder_1.remove(key);
                        holder_IDs.remove(ListOfSpecies[key][0]);
                      }
                    },
                  );
                }).toList(),
              ),*/

            ),
            /*Container(
              margin: const EdgeInsets.only(top: 10,left:15,right: 15),
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                   // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child : Visibility(
                visible: species!=''?true:false,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount:species.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        //color: Colors.amber[species[index]],
                        child:  Text(species[index].toString()),
                      );
                    }
                ),
              )/**/

              /*ListView(
                scrollDirection: Axis.vertical,
                children: ListOfSpecies.keys.map((String key) {
                  return new CheckboxListTile(
                    title: new Text(key),
                    value: ListOfSpecies[key][1],
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        ListOfSpecies[key][1] = value;
                      });
                      if (value == true) {
                        // holder_1.add(key);
                        holder_1[key]=ListOfSpecies[key][0];
                        holder_IDs.add(ListOfSpecies[key][0]);

                      }else if(value == false){
                        //holder_1.remove(key);
                        holder_1.remove(key);
                        holder_IDs.remove(ListOfSpecies[key][0]);
                      }
                    },
                  );
                }).toList(),
              ),*/
            ),*/
            Padding(padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Tree Species Details",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20,)),
                  TextSpan(
                      text: "*",
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                      )),
                ]),
              ),
            ),
            Visibility(
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
            Padding(padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Log Details",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20,)),
                  TextSpan(
                      text: "*",
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                      )),
                ]),
              ),
            ),
            Row(
                children:[
                  Visibility(
                    visible: false,
                   // visible: (userGroup=='deputy range officer' && species.length!=0)?true:false,
                    child:IconButton(
                      icon: new Icon(Icons.edit_rounded),
                      color: Colors.blue,
                      onPressed: ()async{
                        setState(() {
                          Edit=true;
                        });
                      },
                    ),
                  ),

                  Visibility(
                    visible: (Edit==true)?true:false,
                    child:IconButton(
                      icon: new Icon(Icons.save_rounded),
                      color: Colors.blue,
                      onPressed: ()async{
                      },
                    ),
                  ),
                ]
            ),
            LayoutBuilder(
                builder: (context, constraints) {
                  if(Edit==true) {
                    return  Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            //offset: Offset(2.0, 2.0), // shadow direction: bottom right
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
          ],
        ) ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("#0499f2"),
        foregroundColor: Colors.black,
        isExtended: true,
        onPressed: () {
          Navigator.push(
              context,MaterialPageRoute(builder: (_) => Form3Page2(
            sessionToken:sessionToken,
            Ids1:Ids1,
            Name:Name,
            Address:Address,
            log_details:log_details,
          ))
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
