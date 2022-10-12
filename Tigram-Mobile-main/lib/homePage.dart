import 'package:Tigram/Form3Page1.dart';
import 'package:Tigram/Help.dart';
import 'package:Tigram/NocViewApplication.dart';
import 'package:Tigram/Profile.dart';
import 'package:Tigram/QueryPage.dart';
import 'package:Tigram/TransitForms.dart';
import 'package:Tigram/noc_Form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:Tigram/TransitPass.dart';
import 'package:Tigram/forgetPassword.dart';
import 'package:Tigram/homePage.dart';
import 'package:Tigram/CheckPassStatus.dart';
import 'package:Tigram/login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class  HomePage extends StatefulWidget {
  String sessionToken ;
  int userId;
  String userName ;
  String userMobile;
  String userEmail;
  String userAddress;
  String userProfile;
  String userGroup;
  HomePage({this.sessionToken,this.userId,this.userName,this.userEmail,this.userMobile,this.userAddress,this.userProfile,this.userGroup});

  @override
  _HomePageState createState() => _HomePageState(sessionToken,userId,userName,userEmail,userMobile,userAddress,userProfile,userGroup);
}

class _HomePageState extends State<HomePage> {
  String sessionToken ;
  int userId;
  String userName ;
  String userEmail;
  String userMobile;
  String userAddress;
  String userProfile;
  String userGroup;
  _HomePageState(this.sessionToken,this.userId,this.userName,this.userEmail,this.userMobile,this.userAddress,this.userProfile,this.userGroup);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Tigram"),
  //      gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body:SingleChildScrollView(
        child:Center(
          child: Column(children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) => TransitForms(
                  sessionToken:sessionToken,
                  userName:userName,
                  userEmail:userEmail,
                ))
                );
              },

              child:Container(
               // width: 310,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(top:25.0,left:20,right:20,bottom:20.0),
                decoration: BoxDecoration(color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: <Widget>[

                  Container(
                    child:new Image.asset(
                      'assets/images/apply_icon.png',
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:15.0),
                      child: Text(
                        'Apply for Transit Pass',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22),
                      ),

                  ),
                ]
                )
            ),
            ),
            InkWell(
              splashColor: Colors.white70,
              onTap: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) => CheckPassStatus(
                  sessionToken:sessionToken,
                  userName:userName,
                  userEmail:userEmail,
                  userGroup:userGroup,
                ))
                );
              },

              hoverColor: Colors.blueGrey,
             child:Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(top:8,left:20,right:20,bottom:20.0),
                decoration: BoxDecoration(color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
              child: Column(children: <Widget>[
                Container(
                  child:new Image.asset(
                    'assets/images/check_status.png',
                    height: MediaQuery.of(context).size.height * 0.12,

                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:15.0),
                    child: Text(
                      'Check Pass Status',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                )
              ]
              )
            ),
            ),
            InkWell(
              onTap: (){
                  Navigator.push(
                      context,MaterialPageRoute(builder: (_) => NocForm(
                          sessionToken:sessionToken,
                          userName:userName,
                          userEmail:userEmail
                     )
                   )
                  );
              },
              hoverColor: Colors.blueGrey,
                child:Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    margin: const EdgeInsets.only(top:8.0,left:20,right:20,bottom:20.0),
                    decoration: BoxDecoration(color: Colors.orange,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),

                    child: Column(children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.sticky_note_2,
                          size: MediaQuery.of(context).size.height * 0.12,
                          color: Colors.white,
                        ),
                        /*child:new Image.asset(
                          'assets/images/question_icon.png',
                          height: 125,
                        ),*/
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:15.0),
                          child: Text(
                            'NOC For Exempted Species',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                    ]
                    )
                )
          )
        ]
      ),
    )
      ),
      drawer: Container(
               child: Drawer(
                   child: Container(
                      color: Colors.white,
                      child: ListView(
                         padding: EdgeInsets.all(0),
                           children: [
                                UserAccountsDrawerHeader(
                             //     decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]), ),
                                   accountEmail: Text('$userEmail'),
                                   accountName: Text('$userName'),
                                  currentAccountPicture:  CircleAvatar(
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
                                 leading: Icon(Icons.dashboard, color: Colors.black,size: 25,),
                                 title: Text('Dashboard',style: TextStyle(color: Colors.black,fontSize: 20),),
                                 onTap: (){
                                   Navigator.push(
                                       context,MaterialPageRoute(builder: (_) => HomePage(
                                     sessionToken: sessionToken,
                                     userName: userName,
                                     userEmail: userEmail,
                                     userMobile: userMobile,
                                     userAddress: userAddress,
                                     userProfile: userProfile,
                                     userGroup: userGroup,
                                   ))
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
                                 leading: Icon(Icons.help,color: Colors.black,size: 25,),
                                 title: Text('Help',style: TextStyle(color: Colors.black,fontSize: 20),),
                                 onTap: (){
                                   Navigator.push(
                                       context,MaterialPageRoute(builder: (_) => Help())
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

