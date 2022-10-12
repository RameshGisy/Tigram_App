import 'package:Tigram/Profile.dart';
import 'package:Tigram/QueryPage.dart';
import 'package:Tigram/login.dart';
import 'package:flutter/material.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class FieldOfficerDashboard extends StatefulWidget {
  int userId;
  String userName;
  String userEmail;
  String sessionToken;
  String userGroup;
  String dropdownValue;
  String userMobile;
  String userAddress;
  String userProfile;
  FieldOfficerDashboard({this.userId,this.userName,this.userEmail,this.sessionToken,this.userGroup,this.dropdownValue,this.userMobile,this.userProfile,this.userAddress});

  @override
  _FieldOfficerDashboardState createState() => _FieldOfficerDashboardState(userId,userName,userEmail,sessionToken,userGroup,dropdownValue,userMobile,userProfile,userProfile);
}

class _FieldOfficerDashboardState extends State<FieldOfficerDashboard> {
  int userId;
  String userName;
  String userEmail;
  String sessionToken;
  String userGroup;
  String dropdownValue;
  String userMobile;
  String userAddress;
  String userProfile;
  _FieldOfficerDashboardState(this.userId,this.userName,this.userEmail,this.sessionToken,this.userGroup,this.dropdownValue,this.userMobile,this.userProfile,this.userAddress);

  TextEditingController Ids = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Dashboard"),
      //  gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.85,
                margin: EdgeInsets.only(top: 15,bottom: 10),
                child:TextField(
                   controller: Ids,
                    textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide( width: 1),
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0)),
                      ),
                      hintText: 'Enter Application ID'),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                ),
              ),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    InkWell(
                      onTap: ()async{
                        if(Ids.text.isNotEmpty){
                          await launch("http://13.235.67.23:8000/api/auth/qr_code_pdf/"+Ids.text+"/");
                        }else{
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.40,
                        height: MediaQuery.of(context).size.height*0.20,
                        margin: EdgeInsets.all(10),
                     //   decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#4e54c8"),HexColor("#8f94fb")])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.qr_code_scanner,
                              size: 60,
                            ),
                            Text("QR Code",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        await launch("http://13.235.67.23:8000/api/auth/new_transit_pass_pdf/"+Ids.text+"/");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.40,
                        height: MediaQuery.of(context).size.height*0.20,
                        margin: EdgeInsets.all(10) ,
                     //   decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#ffb75e"),HexColor("#ed8f03")])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.file_copy_outlined,
                              size: 60,
                            ),
                            Text("Transit Pass",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 InkWell(
                   onTap: ()async{
                     await launch("http://13.235.67.23:8000/api/auth/new_user_report/"+Ids.text+"/");
                   },
                   child: Container(
                     width: MediaQuery.of(context).size.width*0.40,
                     height: MediaQuery.of(context).size.height*0.20,
                     margin: EdgeInsets.all(10) ,
             //        decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#f85032"),HexColor("#e73827")])),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Icon(
                           Icons.receipt,
                           size: 60,
                         ),
                         Text("Reports",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                       ],
                     ),
                   ),
                 ),
                  InkWell(
                    onTap: ()async{
                      await launch("http://13.235.67.23:8000/api/auth/qr_code_pdf/"+Ids.text+"/");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.40,
                      height: MediaQuery.of(context).size.height*0.20,
                      margin: EdgeInsets.all(10) ,
                //      decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#2EB62C"),HexColor("#57C84D")])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.insert_drive_file_outlined,
                            size:60,
                          ),
                          Text("Log Details",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
      drawer: Container(
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
               //  decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),),
                  accountEmail: Text('$userEmail'),
                  accountName: Text("$userName"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:Colors.white,
                    child: Text(userName[0].toUpperCase(),
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.perm_identity, color: Colors.black,size: 25,),
                    title: Text('Profile',style: TextStyle(color: Colors.black,fontSize: 20),),
                    onTap: (){
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => Profile(sessionToken:sessionToken,userName:userName,userEmail:userEmail,userMobile:userMobile,userAddress:userAddress,userProfile:userProfile))
                      );
                    }
                ),
                ListTile(
                    leading: Icon(Icons.qr_code_scanner, color: Colors.black,size: 25,),
                    title: Text('QR-Scanner',style: TextStyle(color: Colors.black,fontSize: 20),),
                    onTap: (){
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => QueryPage())
                      );
                    }
                ),
                ListTile(
                    leading: Icon(Icons.logout, color: Colors.black,size: 25,),
                    title: Text('Logout',style: TextStyle(color: Colors.black,fontSize: 20),),
                    onTap: () async{
                      final String url =
                          'http://13.235.67.23:8000/api/auth/logout/';
                      await http.post(
                        url,
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': "token $sessionToken"
                        },
                      );
                      SharedPreferences prefs= await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      Navigator.pushReplacement(
                          context,MaterialPageRoute(builder: (_) => login())
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
