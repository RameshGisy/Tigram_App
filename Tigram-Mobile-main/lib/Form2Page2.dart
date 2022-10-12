
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Tigram/Form2Page3.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Form2Page2 extends StatefulWidget {
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
  Form2Page2({this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership});
  @override
  _Form2Page2State createState() => _Form2Page2State(sessionToken,dropdownValue,dropdownValue1,userName,userEmail,Name,Address,survey_no,village,Taluka,block,District,Pincode,Ownership);
}

class _Form2Page2State extends State<Form2Page2> {
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
  _Form2Page2State(this.sessionToken,this.dropdownValue,this.dropdownValue1,this.userName,this.userEmail,this.Name,this.Address,this.survey_no,this.village,this.Taluka,this.block,this.District,this.Pincode,this.Ownership);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSpecies();
  }
  Map<String,dynamic> ListOfSpecies={} ;
  void getSpecies()async{
    print("----------------ALL Species----------------");
    final String url = 'http://13.235.67.23:8000/api/auth/TreeSpeciesList';
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
        print('-----------------Sayli---------');
        print(LOC[i]['name']);
        ListOfSpecies[LOC[i]['name']]=[LOC[i]['id'],false];
        rev_holder_1[LOC[i]['id'].toString()]=LOC[i]['name'].toString();
      }
    });
  }
  // Map<String, List> ListOfSpecies = {
  //   'Rosewood(Dalbergia latifolia)': [0,false],
  //   'Teak(Tectona grandis) ': [0,false],
  //   'Thempavu(Terminalia tomantosa)': [0,false],
  //   'Chadachi(Grewia tiliaefolia)': [0,false],
  //   'Chandana vempu(Cedrela toona)': [0,false],
  //   'Vellakil(Dysoxylum malabaricum)': [0,false],
  //   'Irul(Xylia xylocarpa)':[0,false],
  //   'Ebony(Diospyrus sp.)': [0,false],
  //   'Kampakam(Hopea Parviflora)':[0,false],
  // };
  Map <String,int> holder_1 = {};
  Map<String,String> rev_holder_1={};
  var holder_IDs = [];


  getItems() {
    ListOfSpecies.forEach((key, value) {
      if (value == true) {
        //holder_1.add(key);
        holder_1[key]=value[0];
        holder_IDs.add(value[0]);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    // holder_1.clear();
  }

  int _radioValue = 0;
  int _radioValue1 = 0;
  String maintenance;
  String maintenance1;
  int maintenance_cost;
  int estimatedMaintenanceCost;

  bool flag= false;
  bool flag1= false;
  TextEditingController Purpose = TextEditingController();

  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'Yes';
        setState(() {
          flag=true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'No';
        setState(() {
          flag=false;
        });
      }
    });
  }
  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      if (_radioValue1 == 1) {
        setState(() {
          flag1=true;
        });
      } else if (_radioValue1 == 2) {
        setState(() {
          flag1=false;
        });
      }
    });
  }
  //-- File- Picker



  /* File _storedImage;
  File result;
  Future<void> _takePicture() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
  }*/

  //---file-picker
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
        //automaticallyImplyLeading: false,
      ),
      body:  SingleChildScrollView(
          child: Column(children: <Widget>[
            Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left:13,top: 15),
                    child: Text(
                      'Species of tree or trees proposed to be cut:',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  )
                ]),
            Container(
              margin: const EdgeInsets.only(top: 10,left:15,right: 15),
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child : ListView(
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Purpose,
                //  obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide( width: 2),
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(14.0)),
                    ),
                    labelText: 'Purpose',
                    hintText: ' Enter Purpose for which trees or trees proposed to be cut'),
              ),
            ),
            /*Container(
                margin:const EdgeInsets.only(top:15,left: 8,right: 8),
                child: Column(children: <Widget>[
                  Container(
                    margin:const EdgeInsets.only(top:10,left: 0,right: 0),
                    child: new Text(
                      'Trees have been cut or yet to be cut?',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child:RadioListTile(
                            title: Text(
                              'Yes',
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            value: 1,
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
                ]
                )
            ),*/
          ]
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
          child: Icon(Icons.navigate_next),
          backgroundColor: HexColor("#0499f2"),
          onPressed: () {
            print(holder_1);
            if ((Purpose.text == 0) || (holder_1.length == 0) || (Purpose.text == 0)
                ) {
              Fluttertoast.showToast(
                  msg:
                  "Please fill all required fields",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else {
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
                        return Form2Page3(
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
                          Purpose: Purpose.text,
                          holder_1: holder_1,
                          rev_holder_1:rev_holder_1,
                        );
                      }));
              setState(() {});
            }
          }
      ),
    );
  }
}
