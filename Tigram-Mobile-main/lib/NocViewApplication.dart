import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import  'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class NocViewApplication extends StatefulWidget {
  String userGroup;
  String sessionToken;
  String Ids;
  NocViewApplication({this.userGroup,this.sessionToken,this.Ids});

  @override
  _NocViewApplicationState createState() => _NocViewApplicationState(userGroup,sessionToken,Ids);
}

class _NocViewApplicationState extends State<NocViewApplication> {
  String userGroup;
  String sessionToken;
  String Ids;

  _NocViewApplicationState(this.userGroup,this.sessionToken,this.Ids);

  @override
  void initState()  {
    super.initState();
    setState(() {
      NocView();
      print("-----------------------Noc-View-Application----------------------");
    });
  }

  //---------------------------
  List Tree_species=[];
  List species_nm=[];
  List treelog=[];
  List c=[];
  List  species=[];
  final List length=[];
  final List breadth=[];
  final  List volume=[];
  final  List latit=[];
  final  List longit=[];
  String Name='';
  String Address='';
  String SurveyNo='';
  String VillageName='';
  String OwnershipProof='';
  String treeSpecies='';
  String purpose='';
  String proposed='';
  int All_Record=0;
  //--------------------------

  void  NocView() async {
    String url = 'http://13.235.67.23:8000/api/auth/NocViewApplication';
    Map data = {
      "app_id": Ids,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------Noc View Application------------");
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
    });
    treelog = responseJSON['data']['timber_log'];
    for(int i=0;i< treelog.length;i++) {
      c.add(i);
      // n_list.add(i);
      species.add(responseJSON['data']['timber_log'][i]['species_of_tree'].toString());
      length.add(responseJSON['data']['timber_log'][i]['length'].toString());
      breadth.add(responseJSON['data']['timber_log'][i]['breadth'].toString());
      volume.add(responseJSON['data']['timber_log'][i]['volume'].toString());
      latit.add(responseJSON['data']['timber_log'][i]['latitude'].toString());
      longit.add(responseJSON['data']['timber_log'][i]['longitude'].toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Noc View Application"),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                      /*Card(child: ListTile(title: Text('Details of generation proposed', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                        elevation: 2,),
                      Card(child: ListTile(title: Text(proposed.toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),), elevation: 2,),*/
                      Text('----------VOLUME DESCRIPTIONS-----------', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                      Container(
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
                                            DataColumn(label: Text('Breadth',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
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

                      ),
                    ])
            ),
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.navigate_next),
        backgroundColor: HexColor("#0499f2"),
        onPressed: () {
          Navigator.push(
              context,MaterialPageRoute(builder: (_) =>
              NocViewApplication(
                sessionToken:sessionToken,
                userGroup:userGroup,
                Ids:Ids,
                //sessionToken:sessionToken,
              ))
          );
        },
      ),*/
    );
  }
}
