import 'dart:convert';

import 'package:Tigram/Images.dart';
import 'package:flutter/material.dart';
import 'package:Tigram/ViewApplication1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import 'dart:io' show File ;
import 'dart:io'as Io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ViewApplication2 extends StatefulWidget {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String img_signature;
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
  ViewApplication2({this.sessionToken,this.userId,this.Ids,this.Range,this.img_signature,this.userGroup,
    this.verify_officer,this.deputy_range_officer,this.verify_range_officer,this.is_form_two,this.assigned_deputy2_id,this.assigned_deputy1_id,this.verify_deputy2,this.division_officer,this.other_state,this.verify_forest1
  });
  @override
  _ViewApplication2State createState() => _ViewApplication2State(sessionToken,userId,Ids,Range,img_signature,userGroup,
      verify_officer,deputy_range_officer,verify_range_officer,is_form_two,assigned_deputy2_id,assigned_deputy1_id,verify_deputy2,division_officer,other_state,verify_forest1
  );
}

class _ViewApplication2State extends State<ViewApplication2> {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;

  String img_signature;
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
  _ViewApplication2State(this.sessionToken,this.userId,this.Ids,this.Range,this.img_signature,this.userGroup,
      this.verify_officer,this.deputy_range_officer,this.verify_range_officer,this.is_form_two,this.assigned_deputy2_id,this.assigned_deputy1_id,this.verify_deputy2,this.division_officer,this.other_state,this.verify_forest1
      );
  bool flag= true;
  TextEditingController officerRemark = TextEditingController();
  TextEditingController v_reg_no = TextEditingController();
  TextEditingController D_name = TextEditingController();
  TextEditingController D_phone= TextEditingController();
  TextEditingController Transport_mode = TextEditingController();

  //---vehical---------------
  String vehical_reg_no;
  String driver_name;
  String driver_phone;
  String mode_of_transport;
  String license_image;
  void initState()  {
    super.initState();
    setState(() {
      ViewVehical();
    });
  }
  //---end vehical-----------
   ViewVehical() async {
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
    print("------------------------------------Vehical-Details----------------------------");
    setState(() {
      if(responseJSON['data']['isvehicle']!="Not Applicable") {
        vehical_reg_no = responseJSON['data']['vehicle']['vehicle_reg_no'].toString();
        driver_name = responseJSON['data']['vehicle']['driver_name'].toString();
        driver_phone = responseJSON['data']['vehicle']['driver_phone'].toString();
        mode_of_transport = responseJSON['data']['vehicle']['mode_of_transport'].toString();
        license_image = responseJSON['data']['vehicle']['license_image'].toString();
      }
    });

  }

  File vehical_License_img;
  final ImagePicker _picker = ImagePicker();
  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    //final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      vehical_License_img = pickedFile ;
      print("------------------------------Profile Image--------------");
      print(vehical_License_img.path);
    });
  }

  //-------------------------------Assign-Officer--------------------------
  List <String>holder_1=["Deputy range Officer"];
 var dropdownValue3;
  Future<void> AssignOfficerDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Select Officer",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " * ",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 16,
                                )),
                          ]),
                        ),
                        /*underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),*/
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                            print(dropdownValue3);
                          });

                        },
                        items:Range.map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value[0],
                            child: Text(value[1].toString()),
                          );
                        }).toList(),
                      ),
                    ],
              ),
              title: Text('Assign Deputy Range Officer'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK ',style: TextStyle(color: Colors.blue),),
                  onTap: () async {
                    final String url = 'http://13.235.67.23:8000/api/auth/FormTwoAssignDeputy';
                    Map data = {
                      "app_id":Ids,
                      "deputy_id":dropdownValue3
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
                    print("----------------------login----------------");
                    Fluttertoast.showToast(msg: responseJson['message'].toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 8,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 18.0);
                    print(responseJson);
                      Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  //------------------------------End-Assign-Officer-----------------------

  //----------------------------Button Disable------------------------------
Map DisableButton(String  userGroup, bool verify_officer,bool deputy_range_officer,bool verify_range_officer,bool is_form_two, int userId,int assigned_deputy2_id,int assigned_deputy1_id,bool verify_deputy2,division_officer,bool other_state,bool verify_forest1){
    bool can_assign_officer=false;
    bool transit_pass_exist=true;
    if(userGroup=='revenue officer' && verify_officer==false){
      transit_pass_exist=false;
    }
    else if(userGroup=='deputy range officer'){
        if(deputy_range_officer==false){
          transit_pass_exist=false;
        }
        else if(verify_officer==true && is_form_two == true){
          print(userId);
          print(Ids);
           if(assigned_deputy2_id==userId){
             transit_pass_exist=false;
           }
          else if(assigned_deputy1_id==userId && verify_deputy2 == false){
             transit_pass_exist=false;
           }
        }
    }
    else if(userGroup=='forest range officer') {
      if (verify_range_officer == false) {
        transit_pass_exist = false;
      }
      if (is_form_two == true && verify_officer == true && deputy_range_officer== false) {
        if (!(assigned_deputy1_id != null && assigned_deputy2_id != null)) {
          can_assign_officer = true;
        }
        if (assigned_deputy1_id != null&& verify_forest1==false){
          can_assign_officer=false;
        }
      }
    }else if(userGroup=='division officer' && division_officer==false){
      print("----------Gsrdrtd---------");
      if(other_state==true ){
        transit_pass_exist=false;
      }

    } else{
      print("----Testing----");
    }
    if (can_assign_officer==true){
      transit_pass_exist=true;
    }
      return {'can_assign_officer':can_assign_officer,'transit_pass_exist':transit_pass_exist};
   }

  //----------------------------End Button ---------------------------------

  @override
  Widget build(BuildContext context) {
    print("---Yash----");
    print(division_officer);
    print(userGroup);
    print(DisableButton(userGroup, verify_officer, deputy_range_officer, verify_range_officer, is_form_two,userId, assigned_deputy2_id, assigned_deputy1_id, verify_deputy2,division_officer,other_state,verify_forest1)['can_assign_officer'].toString());
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("View Application"),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        elevation: 0,
        actions: [Container(
          padding: EdgeInsets.only(right:15),
          child:LayoutBuilder(
              builder: (context, constraints) {
                if(flag == true) {
                  return  Visibility(
                      visible: (userGroup=='user')?true:false,
                    child:IconButton(
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        setState(() {
                          flag=false;
                        });
                      }
                    )
                  );
                }else if(flag == false){
                  return  IconButton(
                      icon: Icon(
                        Icons.save_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () async{
                        final bytes = Io.File(vehical_License_img.path).readAsBytesSync();
                        String license_Img_base= vehical_License_img.path != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
                        print(license_Img_base);
                        final String url = 'http://13.235.67.23:8000/api/auth/UpdateVehicle';
                        print (license_Img_base);
                        Map data = {
                          "app_id": Ids,
                          "veh_reg": v_reg_no.text,
                          "driver_name": D_name.text,
                          "phn": D_phone.text,
                          "mode": Transport_mode.text,
                          "lic_img": {
                          "type": ".png",
                          "image": license_Img_base,
                          },
                         // "lic_img":license_Img_base
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
                        print("----------------------login----------------");
                        print(responseJson);
                        setState(() {
                          flag=true;
                        });
                      }
                  );
                }
              }
          ),
        )
        ],
       // backgroundColor: Colors.blueGrey,

        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                    color: Colors.blueGrey,
                    width: 2
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(
                        2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              margin: const EdgeInsets.only(left:10,right:10,top: 10,bottom: 10),
              padding: const EdgeInsets.all(8),
              child:LayoutBuilder(
                  builder: (context, constraints) {
                    if(flag == true) {
                      return Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 15.0,top:10,bottom: 0,left: 15),
                              child: Text('------VEHICLE DETAILS--------',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              )
                          ),
                          Card(child: ListTile(leading: Icon(Icons.car_rental),title: Text(vehical_reg_no==null?"N/A":vehical_reg_no==''?"N/A":vehical_reg_no, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Card(child: ListTile(leading: Icon(Icons.perm_identity_rounded),title: Text(driver_name==null?"N/A":driver_name==''?"N/A":driver_name, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Card(child: ListTile(leading: Icon(Icons.phone),title: Text(driver_phone==null?"N/A":driver_phone==''?"N/A":driver_phone, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Card(child: ListTile(leading: Icon(Icons.emoji_transportation),title: Text(mode_of_transport==null?"N/A":mode_of_transport==''?"N/A":mode_of_transport, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Visibility(visible: license_image==null?false:true,child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,MaterialPageRoute(builder: (_) =>
                                  ImageView(
                                    Images:license_image.toString(),
                                  ))
                              );
                            },
                            child: Image.network(license_image.toString(),
                              fit:BoxFit.fill,
                              width: 120,
                              height: 120,
                            ),
                          ),
                          )
                          //Container(width: 120, height: 120,child: Image.network(license_image==null?Text("Licence Image ").toString():license_image),)
                        ],
                      );
                    }else if(flag == false){
                      v_reg_no.text=vehical_reg_no;
                      D_name.text=driver_name;
                      D_phone.text=driver_phone;
                      Transport_mode.text=mode_of_transport;
                      return Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 15.0,top:10,bottom: 0,left: 15),
                              child: Text('------VEHICLE DETAILS--------',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              )
                          ),
                          Card(child: ListTile(leading: Icon(Icons.car_rental),title: TextField(controller: v_reg_no, decoration: InputDecoration(border: InputBorder.none,hintText: vehical_reg_no),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Card(child: ListTile(leading: Icon(Icons.perm_identity_rounded),title: TextField(controller: D_name, decoration: InputDecoration(border: InputBorder.none,hintText: driver_name.toString()), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Card(child: ListTile(leading: Icon(Icons.phone),title: TextField(controller: D_phone,   keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none,hintText:driver_phone), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Card(child: ListTile(leading: Icon(Icons.emoji_transportation),title: TextField(controller: Transport_mode, decoration: InputDecoration(border: InputBorder.none,hintText: mode_of_transport.toString()), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                            decoration: new BoxDecoration(
                                border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                            ),
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 0, top: 10, bottom: 0),
                            child:Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  FlatButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: () {
                                      setState(() {
                                        takePhoto(ImageSource.gallery);
                                      });
                                    },
                                    label: Text("Upload License Image"),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: (vehical_License_img?.path) == null ? Colors.red : Colors.green,
                                    size: 28.0,
                                  ),
                                ]
                            ),
                          ),
                        ],
                      );
                    }
                  }
              ),
            ),
            Visibility(
              visible: DisableButton(userGroup, verify_officer, deputy_range_officer, verify_range_officer, is_form_two, userId, assigned_deputy2_id, assigned_deputy1_id, verify_deputy2,division_officer,other_state,verify_forest1)['can_assign_officer']==false?false:true,
                child: RaisedButton(
                  color: Colors.orange,
                  onPressed:(){
                    print(Range);
                    AssignOfficerDialog(context);
                  },
                  child: Text('Assign Officer',style: TextStyle(color: Colors.white),),)
            ),
           Container(
               padding: const EdgeInsets.only(
                   right: 15.0, top: 15,left: 15, bottom: 0),
             child: Column(
                 children: <Widget>[
                   InkWell(
                      onTap: (){
                        Navigator.push(
                            context,MaterialPageRoute(builder: (_) =>
                            ImageView(
                              Images:img_signature.toString(),
                            ))
                        );
                      },
                     child: Image.network(img_signature.toString(),
                       fit:BoxFit.fill,
                       width: 120,
                       height: 120,
                     ),
                   ),
                   Text('Signature')
                 ])
           ),

            LayoutBuilder(
                builder: (context, constraints) {
                  if(userGroup == 'user') {
                    return Container(
                      width: 0,
                      height: 0,
                      color: Colors.white,
                    );
                  }else if(userGroup == 'state officer') {
                    return Container(
                      width: 0,
                      height: 0,
                      color: Colors.white,
                    );
                  }
                  else {
                    return Visibility(
                      visible: DisableButton(userGroup, verify_officer, deputy_range_officer, verify_range_officer, is_form_two, userId, assigned_deputy2_id, assigned_deputy1_id, verify_deputy2,division_officer,other_state,verify_forest1)['transit_pass_exist']==false?true:false,
                      child:Container(
                        child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0, top: 15,left: 15, bottom: 0),
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: officerRemark,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide( width: 2),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(14.0)),
                                ),
                                labelText:'Add Remark',
                                hintText:'Enter Remark',
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                              RaisedButton(
                                child:Text('Approve',style: TextStyle(fontSize: 20),),
                                onPressed: () async{
                                  if((officerRemark.text.length==0)){
                                    Fluttertoast.showToast(
                                        msg:
                                        "Please fill Remark feild",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  }
                                  else {
                                    final String url = 'http://13.235.67.23:8000/api/auth/new_approve_transit_pass';
                                    Map data = {
                                      "app_id": Ids,
                                      "type": "Approve",
                                      "reason": officerRemark.text,
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
                                    Map<String, dynamic> responseJson = json.decode(response.body);
                                    print("----------------Officer Remark-----------------------");
                                    print(responseJson);
                                    Fluttertoast.showToast(
                                        msg:
                                        responseJson['message'].toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 8,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  }
                                },
                                color: Colors.blueAccent,
                                textColor: Colors.white,
                              ),
                                SizedBox(width: 10,),
                                RaisedButton(
                                    child:Text('Reject',style: TextStyle(fontSize: 20),),
                                    onPressed: () async{
                                      if((officerRemark.text.length==0)){
                                        Fluttertoast.showToast(
                                            msg:
                                            "Please fill Remark feild",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 4,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 18.0);
                                      }
                                      else {
                                        final String url = 'http://13.235.67.23:8000/api/auth/approve_transit_pass';
                                        Map data = {
                                          "app_id": Ids,
                                          "type": "REJECT",
                                          "reason": officerRemark.text,
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
                                        Map<String, dynamic> responseJson = json.decode(response.body);
                                        print("----------------Officer Remark-----------------------");
                                        print(responseJson);
                                        Fluttertoast.showToast(
                                            msg:
                                            responseJson['message'].toString(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 8,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 18.0);
                                    }
                                    },
                                  color: Colors.red,
                                  textColor: Colors.white,
                                ),
                                Spacer(),
                          ])
                          )
                        ])
                    )
                  );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
