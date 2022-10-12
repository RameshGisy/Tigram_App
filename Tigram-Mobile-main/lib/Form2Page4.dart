import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:Tigram/Form1.dart';
import 'package:Tigram/homePage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io'as Io;

class Form2Page4 extends StatefulWidget {
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
  String Application;
  String Approval;
  String Declaration;
  String Location;
  String TreeOwnership;
  String IdProof;
  List log_details;
  Form2Page4({this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.Application,this.Approval,this.Declaration,this.Location,this.TreeOwnership,this.IdProof,this.log_details});
  @override
  _Form2Page4State createState() => _Form2Page4State(sessionToken,dropdownValue,dropdownValue1,userName,userEmail,Name,Address,survey_no,village,Taluka,block,District,Pincode,Ownership,Purpose,holder_1,Application,Approval,Declaration,Location,TreeOwnership,IdProof,log_details);
}

class _Form2Page4State extends State<Form2Page4> {
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
  String Application;
  String Approval;
  String Declaration;
  String Location;
  String TreeOwnership;
  String IdProof;
  List log_details;

  _Form2Page4State(this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership,this.Purpose,this.holder_1,this.Application,this.Approval,this.Declaration,this.Location,this.TreeOwnership,this.IdProof,this.log_details);

  File _License;
  final ImagePicker _picker = ImagePicker();
  void License(ImageSource source) async {
    print(Name+" "+Address+" "+survey_no+"  "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership+" "+Application+" "+Approval+" "+Declaration+" "+" "+Location+" "+TreeOwnership+" "+IdProof);
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    // final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _License = pickedFile;
      print("------------------------------Profile Image--------------");
      print(_License.path);
    });
  }
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
  bool flag= false;
  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'YES';
        setState(() {
          flag=true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'NO';
        setState(() {
          flag=false;
        });
      }
    });
  }
  //--end radio button--
  //--------------------------------Image-Base64--------------------------------
  String ImageLicence(){
    if(_License==null){
      return '';
    }else {
      final bytes = Io.File(_License.path).readAsBytesSync();
      String license_base = _License != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
      print('------------1--------------');
      print(license_base);
      return license_base;
    }
  }
  String ImageOwnership(){
    final bytes = Io.File(Ownership).readAsBytesSync();
    String ownership_base = Ownership != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
    print('------------2--------------');
    print(ownership_base);
    return ownership_base;
  }
  String ImageRevenueApp(){
    final bytes1 = Io.File(Application).readAsBytesSync();
    String application_base = Application != null ? 'data:image/png;base64,' + base64Encode(bytes1) : '';
    print('------------3--------------');
    print(application_base);
    return application_base;
  }
  String ImageRevenueApproval(){
    final bytes2 = Io.File(Approval).readAsBytesSync();
    String approval_base = Approval != null ? 'data:image/png;base64,' + base64Encode(bytes2) : '';
    print('------------4--------------');
    print(approval_base);
    return approval_base;
  }
  String ImageDecleration(){
    final bytes5 = Io.File(Declaration).readAsBytesSync();
    String declaration_base = Declaration != null ? 'data:image/png;base64,' + base64Encode(bytes5) : '';
    print('------------5--------------');
    print(declaration_base);
    return declaration_base;
  }
  String ImageLocation(){
    final bytes4 = Io.File(Location).readAsBytesSync();
    String Location_base = Location != null ? 'data:image/png;base64,' + base64Encode(bytes4) : '';
    print('------------6--------------');
    print(Location_base);
    return Location_base;
  }
  String ImageTreeOwnership(){
    final bytes3 = Io.File(TreeOwnership).readAsBytesSync();
    String TreeOwnership_base = TreeOwnership != null ? 'data:image/png;base64,' + base64Encode(bytes3) : '';
    print('------------7--------------');
    print(TreeOwnership_base);
    return TreeOwnership_base;
  }
  String ImageAadhar(){
    final bytes6 = Io.File(IdProof).readAsBytesSync();
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
  //--------------------------------End-Image-Base64----------------------------

  //-------------------------------Progress bar---------------------------------
  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }
  //------------------------------End-Progress-Bar------------------------------
  //----------------------------------Other-State-------------------------------
  String selectedState;
  List <String> State=[
    "Andhra Pradesh",
    "Andaman and Nicobar Islands",
    "Arunachal Pradesh",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadar and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu & Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttar Pradesh",
    "West Bengal"
  ];

  bool isShow=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("FORM - II"),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
       // automaticallyImplyLeading: false,
      ),
      body:SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[

                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15,left:15,right: 15),
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
                    ),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 10, bottom: 0),
                    child:DropdownButton<String>(
                      value: selectedState,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      hint: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select State",
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
                      onChanged: (String data) {
                        setState(() {
                          selectedState = data;
                        });

                        print(selectedState);
                      },
                      items: State.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15,
                        right: 15.0, top: 15, bottom: 0),
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
                  Container(
                    margin: const EdgeInsets.only(top: 10.0,left: 15),
                    child: Column(children: <Widget>[
                      Row(
                          children: <Widget>[
                            Expanded(
                              child: new Text(
                                'Enter Vehicle Details',
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
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
                            if(flag == true){
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
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(top: 15,right: 15),
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
                                                License(ImageSource.gallery);
                                              },
                                              label: Text("License Image"),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.check_circle,
                                              color: (_License?.path) == null ? Colors.red : Colors.green,
                                              size: 28.0,
                                            ),
                                          ]
                                      ),
                                    ),
                                  ])
                              );
                            }else if(flag== false){
                              return Container (
                                color: Colors.white,
                              );
                            }
                          }),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15,right: 15),
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
                      Visibility(
                        visible: isShow,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 8,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.yellow[700], borderRadius: BorderRadius.circular(8)),
                        child: FlatButton(
                          onPressed: () async {
                            if((Name.length==0)||(Address.length==0)||(survey_no.length==0)||(village.length==0)
                                ||(destination_add.text.length==0)||(Ownership==null)||(Application==null)||(TreeOwnership==null)){
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
                              final String url = 'http://13.235.67.23:8000/api/auth/Formtwophaseone';
                              Map data = {
                                "name": Name,
                                "address": Address,
                                "survey_no": survey_no,
                                "age":25,
                                "tree_proposed":log_details.length,
                                "village": village,
                                "district": District,
                                "area_range": dropdownValue,
                                "division": dropdownValue1,
                                "destination_address": destination_add.text,
                                "destination_state":selectedState,
                                "pincode": Pincode,
                                "block": block,
                                "taluka": Taluka,
                                "licence_img":ImageLicence()==""?"":{"type": ".png", "image": ImageLicence()},
                                "ownership_proof_img": {
                                  "type": ".png",
                                  "image": ImageOwnership()
                                },
                                "revenue_application_img": {
                                  "type": ".png",
                                  "image": ImageRevenueApp()
                                },
                                "revenue_approval_img": {
                                  "type": ".png",
                                  "image": ImageRevenueApproval()
                                },
                                "declaration_img": {
                                  "type": ".png",
                                  "image": ImageDecleration()
                                },
                                "location_sketch_img": {
                                  "type": ".png",
                                  "image": ImageLocation()
                                },
                                "tree_ownership_img":{
                                  "type": ".png",
                                  "image": ImageTreeOwnership()
                                },
                                "aadhar_card_img": {
                                  "type": ".png",
                                  "image": ImageAadhar()
                                },
                                "signature_img": {
                                  "type": ".png",
                                  "image": ImageSignature()
                                },
                                "lic_img":{
                                  "type":".png",
                                  "image": ImageSignature()
                                },
                                "tree_species": holder_1.keys.toString(),
                                "purpose_cut": Purpose,
                                "vehicle_detail": flag,
                                "vehicel_reg": vehical_reg_no.text,
                                "driver_name": driver_name.text,
                                "phone": driver_phone.text,
                                "mode": mode_transport.text,
                                "trees_cutted": false,
                                "spec_details":log_details//[{"species_of_tree":"5","latitude":"10.846685","longitude":"76.271049"}]
                                //[{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"},{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"}]
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
                            style: TextStyle(color: Colors.black, fontSize: 22,fontFamily: 'Cairo',
                              fontStyle: FontStyle.normal,),
                          ),
                        ),
                      ),
                    ],
                    ),
                  ),
                ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}
