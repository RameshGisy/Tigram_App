import 'dart:convert';
import 'package:Tigram/Form.dart';
import 'package:Tigram/noc_Form1.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
class NocForm extends StatefulWidget {
  String sessionToken ;
  String userName ;
  String userEmail;

  NocForm({this.sessionToken,this.userName,this.userEmail});
  @override
  _NocFormState createState() => _NocFormState(sessionToken,userName,userEmail);
}



class _NocFormState extends State<NocForm> {
  String sessionToken ;
  String userName ;
  String userEmail;
  _NocFormState(this.sessionToken,this.userName,this.userEmail);

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController Taluka = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController District = TextEditingController();
  TextEditingController Pincode = TextEditingController();



  String dropdownValue;
  String range_holder = '' ;
  List<String> range = [
    'Paruthippally',
    'Kulathupuzha',
    'Palode',
  ];
  void getDropDownItem(){
    setState(() {
      range_holder = dropdownValue ;
    });
    print(range_holder);
  }
  String dropdownValue1;
  String division_holder = '' ;
  List<String> Division = [
    'Trivandrum',
  ];
  void getDropDownItem1(){
    setState(() {
      division_holder = dropdownValue1 ;
    });
    print("------------"+division_holder);
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      ListRange();
      ListDivision();
      LoadDistric();
    });

  }
  //------------------------------Taluka & Distric------------------------------
  String selectedTaluka;
  String selectedDistrict;
  //----------------------------District----------------------------------
  List<String> district=[];
  LoadDistric() async {
    int RL=0;
    final String url = 'http://13.235.67.23:8000/api/auth/ListDistrict';
    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
      for(int i=0;i<RL;i++){
        district.add(responseJSON["data"][i]['district_name']);
      }
    });
  }

  //-----------------taluka----------------------
  List <String> taluka=[];
  LoadTaluka() async {
    // taluka.clear();
    int RL=0;
    final String url = 'http://13.235.67.23:8000/api/auth/LoadTaluka';
    Map data = {
      "district": selectedDistrict,
    };
    print(data);
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJson);
    setState(() {
      RL = responseJson["data"].length;
      for(int i=0;i<RL;i++){
        taluka.add(responseJson["data"][i]['taluka_name']);
      }
    });
  }

  //----------------------------------Village--------------------------------
  String SelectedVillage;
  List <String> Village=[];
  LoadVillage() async {
    int RL=0;
    final String url = 'http://13.235.67.23:8000/api/auth/LoadVillage';
    Map data = {
      "taluka":selectedTaluka
    };
    print(data);
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("----------------------------Village-----------------------");
    print(responseJson);
    setState(() {
      RL = responseJson["data"].length;
      for(int i=0;i<RL;i++){
        Village.add(responseJson["data"][i]['village_name']);
      }
    });
  }


  //---------------------------------End-Village-----------------------------

  //-----------------------------End-Taluka & Distric---------------------------
//---------------------------------DropDownList Api Connection------------------
  List<String> Rname=[];
  int RL=0;
  ListRange() async {
    final String url = 'http://13.235.67.23:8000/api/auth/ListRange';
    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;

    });
    for(int i=0;i<RL;i++){
      Rname.add(responseJSON["data"][i]['name']);
    }
    print(Rname);
  }

  String DD;
  List<String> Dname=[];

  int DL=0;
  ListDivision() async {
    final String url = 'http://13.235.67.23:8000/api/auth/LoadDivision';
    Map data = {
      "range_area":dropdownValue,
    };
    print(data);
    var body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJson);
    setState(() {
      Dname.insert(0,responseJson["data"][0]['division_id__name']);
      if(Dname.length>2){
        Dname.removeLast();
      }
    });
    print(Dname);
  }

//--------------------------------End DropDown Api Connection-------------------


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("NOC Form",
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
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15,left:15,right: 15),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
              ),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child:Row(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      hint: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select Range",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " * ",
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16,
                              )),
                        ]),
                      ),
                      onChanged: (String data) {
                        setState(() {
                          dropdownValue = data;
                          ListDivision();
                        });
                        print(dropdownValue);
                      },
                      items: Rname.toSet().toList().map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                    DropdownButton<String>(
                      value: dropdownValue1,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      hint:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select Division",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " * ",
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16,
                              )),
                        ]),
                      ),
                      onChanged: (String data) {
                        setState(() {
                          dropdownValue1 = data;
                        });
                        print(dropdownValue1);
                      },
                      items: Dname.toSet().toList().map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        );
                      }).toList(),
                    ),
                  ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15,bottom: 0),
              child: TextField(
                  controller: Name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide( width: 2),
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Name \*',
                      hintText: 'Enter Your Name'),
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide( width: 2),
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(14.0)),
                    ),
                    labelText: 'Address',
                    hintText: 'Enter Your Address'),
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: survey_no,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide( width: 2),
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(14.0)),
                    ),
                    labelText: 'Survey Number',
                    hintText: 'Enter Survey Number'),
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Tree_Proposed_to_cut,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide( width: 2),
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(14.0)),
                    ),
                    labelText: 'Trees Proposed to be cut',
                    hintText: 'Enter Number of Trees'),
                keyboardType: TextInputType.number,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15,left:15,right: 15),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(14)
              ),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child:Row(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: selectedDistrict,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      hint:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select District",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " * ",
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16,
                              )),
                        ]),
                      ),
                      onChanged: (String data) {
                        setState(() {
                          selectedDistrict = data;
                          LoadTaluka();
                        });
                        print(selectedDistrict);
                      },
                      items: district.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                    DropdownButton<String>(
                      value: selectedTaluka,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      hint:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select Taluka",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " * ",
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16,
                              )),
                        ]),
                      ),

                      onChanged: (String data) {
                        setState(() {
                          selectedTaluka = data;
                          LoadVillage();
                        });
                        print(selectedTaluka);
                      },
                      items: taluka.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        );
                      }).toList(),
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
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child:DropdownButton<String>(
                value: SelectedVillage,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black, fontSize: 18),
                hint:  RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Select Village",
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
                    SelectedVillage = data;
                  });
                  print(SelectedVillage);
                },
                items: Village.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  controller: block,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide( width: 2),
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(14.0)),
                      ),
                      labelText: 'Block',
                      hintText: 'Enter Your Block'),
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)
              ),

            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  controller: Pincode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide( width: 2),
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(14.0)),
                      ),
                      labelText: 'Pincode',
                      hintText: 'Enter Your Pincode'),
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        child: Icon(Icons.navigate_next),
        backgroundColor: HexColor("#0499f2"),
        onPressed: () async{
          if((dropdownValue==null)||(dropdownValue1==null)||(Name.text.length == 0) || (Address.text.length == 0)||(survey_no.text.length == 0) ||
              (Tree_Proposed_to_cut.text.length == 0)||(SelectedVillage == null)|| (selectedDistrict == null)||
              (selectedTaluka == null)){
            Fluttertoast.showToast(
                msg:
                "Please select and fill all Field",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          }else{
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
                      return noc_Form1(
                        sessionToken: sessionToken,
                        dropdownValue: dropdownValue,
                        dropdownValue1:dropdownValue1,
                        userName: userName,
                        userEmail: userEmail,
                        Name:Name.text,
                        Address:Address.text,
                        survey_no:survey_no.text,
                        Tree_Proposed_to_cut:Tree_Proposed_to_cut.text,
                        village:SelectedVillage,
                        Taluka:selectedTaluka,
                        block:block.text,
                        District:selectedDistrict,
                        Pincode:Pincode.text,
                      );
                    }));
            setState(() {
            });
          }
        },
      ),
    );
  }
}
