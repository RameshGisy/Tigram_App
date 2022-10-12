import 'dart:convert';
import 'dart:developer';
import 'package:Tigram/DivisionDashboard.dart';
import 'package:Tigram/FieldOfficerDashboard.dart';
import 'package:Tigram/OfficerDashboard.dart';
import 'package:Tigram/SFDashboard.dart';
import 'package:flutter/material.dart';
import 'package:Tigram/forgetPassword.dart';
import 'package:Tigram/homePage.dart';
import 'package:Tigram/signup.dart';
import "package:flutter/cupertino.dart";
import 'package:Tigram/OfficerLogin.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

void main() {
  runApp(login());
}

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}


class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  bool isHiddenPassword = true;


  TextEditingController loginMobile = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  int _radioValue = 0;
  String maintenance;
  int maintenance_cost;
  int estimatedMaintenanceCost;

  bool flag= true;

  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 0) {
        maintenance = 'Yes';
        setState(() {
          flag=true;
        });
      } else if (_radioValue == 1) {
        maintenance = 'No';
        setState(() {
          flag=false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.green[100],
        backgroundColor: Colors.white,

        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(right: 15,top:8),
                width: double.infinity,
                height: 80,
                child:Row(
                  children: <Widget>[
                    Image.asset("assets/images/usaid_logo.png",
                      width: 130,
                      height: 75,
                    ),
                    Spacer(),
                    Image.asset("assets/images/kerala_logo.jpg",
                      alignment:Alignment.center,
                      width:80,height: 80,),
                    Spacer(),
                    Container(
                        child:Row(
                            children: <Widget>[
                              Image.asset("assets/images/ministry_logo.jpg",
                              ),
                            ])
                    )
                  ],
                )
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  width: double.infinity,
                  height: 65,
             //     color: HexColor("#02075D"),
                  child:Row(
                    children: <Widget>[
                      Text("Login",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal ,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Spacer(),
                      Image.asset("assets/images/tigram01.png",
                        width: 120,
                        height: 90,

                      ),
                    ],
                  )
              ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.5),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.blue[700],
                              width: 1
                          ),
                        ),
                        margin: const EdgeInsets.only(top:50,bottom: 15),
                        child: ToggleSwitch(
                        minWidth:double.infinity,
                        minHeight: 50,
                        initialLabelIndex: _radioValue,
                        cornerRadius: 12.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.white,
                        inactiveFgColor: Colors.blue,
                        labels: ['User', 'Officer'],
                        fontSize: 18,
                        activeBgColors: [Colors.blue,Colors.blue],
                        onToggle: _handleRadioValueChange,
                        ),
                        ),
                       LayoutBuilder(
                         builder: (context, constraints) {
                           if(flag == true) {
                             return UserLogin();
                           }else if(flag == false){
                             return OfficerLogin();
                           }
                         }
                       ),
                      Container(
                        width: double.infinity,
                        height: 25,
             //           color: HexColor("#8b0000"),
                        alignment: Alignment.center,
                        margin:  const EdgeInsets.only(bottom: 10),
                        child: Marquee(text:"    Developed By Bhugol GIS Pvt. Ltd.   "+"    Kerala Forest Research Institute (KFRI)   "+"    Insight Development Consulting Group (IDCG)    ",
                         // textAlign: Align.center,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontStyle: FontStyle.normal ,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                   ),
                 )
    );
  }
}

//-------------------------------User-Login-------------------------------------


class UserLogin extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserLogin> {
  bool isHiddenPassword = true;
  String sessionToken = '';
   int userId;
  String userName = '';
  String userEmail = '';
  String userMobile='';
  String userAddress='';
  String userProfile='';
  String userGroup='';

  TextEditingController loginMobile = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  bool validateMobile(String value){
    if (value.length != 10)
      return false;
    else
      return true;
  }
  //-------------------------------------Shared-Preferences---------------------
 SharedPreferences prefs;
  bool newuser;

  void  getLogin() async {
    List userRange;
    List <String> URange=[];
    List Dist_Range;
    List <String> Dist=[];
    List  Range=[];
    prefs = await SharedPreferences.getInstance();
    setState(() {
      newuser = (prefs.getBool('isLoggedIn') ?? true);
      print(newuser);
    });
    if (newuser == false) {
      final String url = 'http://13.235.67.23:8000/api/auth/NewLogin';
      Map data = {
        "email_or_phone": prefs.getString('LoginUser'),
        "password": prefs.getString('LoginPass'),
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
      if (responseJson['status'] == "success") {
        setState(() {
          userId = responseJson['data']['id'];
          print(userId);
          userName = responseJson['data']['name'];
          userEmail = responseJson["data"]["email"];
          sessionToken = responseJson['token'];
          userGroup = responseJson['data']['user_group'][0];
          userMobile = responseJson["data"]["phone"];
          userAddress = responseJson["data"]["address"];
          userProfile = responseJson["data"]["photo_proof_img"];
        });
        if (responseJson['data']['user_group'][0] == 'user') {
          Fluttertoast.showToast(
              msg: 'Welcome '+ userName.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
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
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      userMobile: userMobile,
                      userAddress: userAddress,
                      userProfile: userProfile,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                    );
                  }));
        }
        else
        if (responseJson['data']['user_group'][0].toString().toLowerCase() ==
            'division officer') {
          setState(() {
            userRange = responseJson['data']['range'];
            URange = List<String>.from(userRange);
          });
          Fluttertoast.showToast(
              msg: 'Welcome '+userName.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return DivisonDashBoard(
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      // dropdownValue: dropdownValue,
                      userRange: URange,
                    );
                  }));
        } else
        if (responseJson['data']['user_group'][0].toString().toLowerCase() ==
            'state officer') {
          setState(() {
            Dist_Range = responseJson['data']['division_range_list'];
            print("----------------------------#%%%------");
            print(Dist_Range[52]['division']);
            print(Dist_Range.length.toString());
            for (int i = 0; i < Dist_Range.length; i++) {
              print(Dist);
              Dist.add(responseJson['data']['division_range_list'][i]['division']);
              Range.add(responseJson['data']['division_range_list'][i]['ranges']);
              // URange=List<String>.from(Range);
              for (int j = 0; j < Range[i].length; j++) {
                URange.add(Range[i][j].toString());
              }

              print(Dist);
              //print(Range);
            }
            //D_Range=List<String>.from(Dist_Range);
          });
          Fluttertoast.showToast(
              msg: 'Welcome '+ userName.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return SFDashboard(
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      //dropdownValue: dropdownValue,
                      userMobile: userMobile,
                      userProfile: userProfile,
                      userAddress: userAddress,
                      Dist: Dist,
                      Range: URange,
                    );
                  }));
        }
        else
        if (responseJson['data']['user_group'][0].toString().toLowerCase() ==
            'field officer') {
          Fluttertoast.showToast(
              msg: 'Welcome '+ userName.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return FieldOfficerDashboard(
                        userId:userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        //dropdownValue: dropdownValue,
                        userMobile: userMobile,
                        userProfile: userProfile,
                        userAddress: userAddress
                    );
                  }));
        } else {
          if(userGroup=='forest range officer'){
            Range=responseJson['data']['range'];
            print(Range);
          }
          Fluttertoast.showToast(
              msg: 'Welcome '+userName.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return OfficerDashboard(
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      Range: Range,
                      //dropdownValue: dropdownValue,
                      //  userMobile:userMobile,
                      //  userImage:userImage,
                    );
                  }));
        }
      } else {
        Navigator.push(
          context, MaterialPageRoute(builder: (_) => login()),
        );
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
  }

  //-----------------------------------End-Shared-Preferences-------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.red[600],
            width: 1.2
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
        margin: const EdgeInsets.only(left: 15,right: 15,top:15,bottom: 30),
        padding: const EdgeInsets.only(left: 15,right: 15,top:50,bottom: 30),
        child:Column(children: <Widget>[
          TextField(
            controller:loginEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide( width: 2),
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0)),
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter E-mail/Mobile',
                  labelText: "E-mail/Mobile",
                  hintStyle: new TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal ,
                  )
              )
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: loginPassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide( width: 2),
                  borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.vpn_key_outlined),
                suffixIcon: InkWell(
                  onTap: (){
                    setState(() {
                      isHiddenPassword = !isHiddenPassword;
                    });
                  },
                  child:Icon(Icons.visibility,
                  ),
                ),
                hintText: 'Enter Password',
                labelText: "Password",
                hintStyle: new TextStyle(
                  fontFamily: 'Cairo',
                  fontStyle: FontStyle.normal ,
                )
            ),
            obscureText: isHiddenPassword,
           // obscuringCharacter: '*',
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              onPressed:(){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) => forgetPassword())
                );
              } ,
              child: Text(
                'Forget Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontStyle: FontStyle.normal ,
                  color: Colors.blue[700],
                  fontSize: 16,
                ),
              )
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.yellow[700], borderRadius: BorderRadius.circular(12)),
            child:FlatButton(
              // color: Colors.amber,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed:() async {
                  if ((loginEmail.text.length == 0) ||
                      (loginPassword.text.length == 0)){
                    Fluttertoast.showToast(
                        msg:
                        "Either User Name or password field is empty",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  }else{
                    print("----login--");
                   final String url = 'http://13.235.67.23:8000/api/auth/NewLogin';
                    Map data = {
                      "email_or_phone": loginEmail.text,
                      "password": loginPassword.text
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
                    print("----------------------login----------------");
                    print(responseJson);
                    if (responseJson['status'] == "success") {
                      setState(() {
                        userId = responseJson['data']['id'];
                        userName = responseJson['data']['name'];
                        userEmail = responseJson["data"]["email"];
                        userMobile = responseJson["data"]["phone"];
                        userAddress = responseJson["data"]["address"];
                        userProfile=responseJson["data"]["photo_proof_img"];
                        userGroup=responseJson['data']['user_group'][0];
                        sessionToken = responseJson['token'];
                      });
                      if(responseJson['data']['user_group'][0]== 'user') {
                        prefs.setString('LoginUser', loginEmail.text);
                        prefs.setString('LoginPass', loginPassword.text);
                        prefs.setBool('isLoggedIn', false);
                        Fluttertoast.showToast(
                            msg: 'Login Sucessfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 18.0);
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
                                    userId:userId,
                                    userName: userName,
                                    userEmail: userEmail,
                                    userMobile:userMobile,
                                    userAddress:userAddress,
                                    userProfile:userProfile,
                                    sessionToken: sessionToken,
                                    userGroup:userGroup,
                                  );
                                }));
                      }else{
                        Navigator.pushReplacement(
                            context,MaterialPageRoute(builder: (_) => login())
                        );
                        Fluttertoast.showToast(
                            msg: 'Go to Officer Login',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                        loginEmail.clear();
                        loginPassword.clear();
                      }
                    }else {
                      Navigator.pushReplacement(
                          context,MaterialPageRoute(builder: (_) => login())
                      );
                      Fluttertoast.showToast(
                          msg: 'Invalid credentials',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    }
                  }

                }),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              onPressed:(){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) => signup())
                );
              } ,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "New User ? ",
                      style: TextStyle(color: Colors.black,fontFamily: 'Cairo',)),
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ]),
              )
          ),
        ])
    );;
  }
}
//-------------------------------End--UserLogin---------------------------------


//-----------------------Officer--Login-----------------------------------------

class OfficerLogin extends StatefulWidget  {
  @override
  _OfficerState createState() => _OfficerState();
}

class _OfficerState extends State<OfficerLogin> {
  //-------------------------------------Shared-Preferences---------------------
  SharedPreferences prefs;
  bool newuser;

  void  getLogin() async {
    List userRange;
    List <String> URange=[];
    List Dist_Range;
    List <String> Dist=[];
    List  Range=[];
    prefs = await SharedPreferences.getInstance();
    setState(() {
      newuser = (prefs.getBool('isLoggedIn') ?? true);
      print(newuser);
    });
    if (newuser == false) {
      final String url = 'http://13.235.67.23:8000/api/auth/NewLogin';
      Map data = {
        "email_or_phone": prefs.getString('LoginUser'),
        "password": prefs.getString('LoginPass'),
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
      if (responseJson['status'] == "success") {
        setState(() {
          userId = responseJson['data']['id'];
          userName = responseJson['data']['name'];
          userEmail = responseJson["data"]["email"];
          sessionToken = responseJson['token'];
          userGroup = responseJson['data']['user_group'][0];
          userMobile = responseJson["data"]["phone"];
          userAddress = responseJson["data"]["address"];
          userProfile = responseJson["data"]["photo_proof_img"];
        });
        if (responseJson['data']['user_group'][0] == 'user') {
          Fluttertoast.showToast(
              msg: 'Login Sucessfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
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
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      userMobile: userMobile,
                      userAddress: userAddress,
                      userProfile: userProfile,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                    );
                  }));
        }
        else
        if (responseJson['data']['user_group'][0].toString().toLowerCase() ==
            'division officer') {
          setState(() {
            userRange = responseJson['data']['range'];
            URange = List<String>.from(userRange);
          });
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return DivisonDashBoard(
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      userRange: URange,
                    );
                  }));
        } else
        if (responseJson['data']['user_group'][0].toString().toLowerCase() ==
            'state officer') {
          setState(() {
            Dist_Range = responseJson['data']['division_range_list'];
            print("----------------------------#%%%------");
            print(Dist_Range[52]['division']);
            print(Dist_Range.length.toString());
            for (int i = 0; i < Dist_Range.length; i++) {
              print(Dist);
              Dist.add(responseJson['data']['division_range_list'][i]['division']);
              Range.add(responseJson['data']['division_range_list'][i]['ranges']);
              // URange=List<String>.from(Range);
              for (int j = 0; j < Range[i].length; j++) {
                URange.add(Range[i][j].toString());
              }

              print(Dist);
              //print(Range);
            }
            //D_Range=List<String>.from(Dist_Range);
          });
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return SFDashboard(
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      //dropdownValue: dropdownValue,
                      userMobile: userMobile,
                      userProfile: userProfile,
                      userAddress: userAddress,
                      Dist: Dist,
                      Range: URange,
                    );
                  }));
        }
        else
        if (responseJson['data']['user_group'][0].toString().toLowerCase() ==
            'field officer') {
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return FieldOfficerDashboard(
                       userId:userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        userMobile: userMobile,
                        userProfile: userProfile,
                        userAddress: userAddress
                    );
                  }));
        } else {
          if(userGroup=='forest range officer'){
            Range=responseJson['data']['range'];
            print(Range);
          }
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
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
                    return OfficerDashboard(
                      userId:userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      Range: Range,
                      //dropdownValue: dropdownValue,
                      //  userMobile:userMobile,
                      //  userImage:userImage,
                    );
                  }));
        }
      } else {
        Navigator.push(
          context, MaterialPageRoute(builder: (_) => login()),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
   // check_if_already_login();
  }
  //-----------------------------------End-Shared-Preferences-------------------

    bool isHiddenPassword = true;

    String sessionToken = '';
    int userId ;
    String userName = '';
    String userEmail = '';
    String userGroup ='';
    String userMobile='';
    String userAddress='';
    String userProfile='';
    List userRange;
    List <String> URange=[];
    List Dist_Range;
    List <String> Dist=[];
    List  Range=[];
    TextEditingController loginMobile = TextEditingController();
    TextEditingController loginEmail = TextEditingController();
    TextEditingController loginPassword = TextEditingController();

    bool validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      return (!regex.hasMatch(value)) ? false : true;
    }



    String dropdownValue;
    String login_holder = '' ;
    List<String>Officer_login = [
      'Revenue Officer',
      'Deputy Range Officer',
      'Forest Range Officer',
      'Division Officer',
      'State Officer',
      'Field Officer',
    ];
    bool check=false;
    void getDropDownItem(){

      setState(() {
        login_holder = dropdownValue ;
        if(login_holder!=null){
          check=true;
        }
        else{
          check=false;
        }
      });
      print(login_holder);
    }

    //------------------Assign Officer--------------------------------


    //------------------End-Assign-Officer----------------------------

    @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
              color: Colors.red[700],
              width: 1.2,
          ),//<---- Insert Gradient Here
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        margin: const EdgeInsets.only(left: 15,right: 15,top:15,bottom: 30),
        padding: const EdgeInsets.only(left: 15,right: 15,top: 45),
        child:Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10,bottom: 10),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10, bottom: 0),
            child:DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down_circle_outlined),
              iconSize: 24,
              elevation: 0,
              style: TextStyle(color: Colors.black, fontSize: 18),
              hint:  Text("Officer Login"),
              /*underline: Container(
                height: 2,
                color: Colors.grey,
              ),*/
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                  if(dropdownValue==data){
                    check=true;
                  }else{
                    check=false;
                  }
                });
                print(dropdownValue);
              },
              items: Officer_login.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          TextField(
            controller: loginEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide( width: 2),
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0)),
                  ),
                  prefixIcon: Icon(Icons.perm_identity_rounded),
                  hintText: 'Enter Email/Mobile',
                  labelText: "E-mail/Mobile",
                  hintStyle: new TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal ,
                  )
              )
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: loginPassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide( width: 2),
                  borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.vpn_key_outlined),
                suffixIcon: InkWell(
                  onTap: (){
                    setState(() {
                      isHiddenPassword = ! isHiddenPassword;
                    });
                  },
                  child: Icon(Icons.visibility),
                ),
                hintText: 'Enter Password',
                labelText: "Password",
                hintStyle: new TextStyle(
                  fontFamily: 'Cairo',
                  fontStyle: FontStyle.normal ,
                )
            ),
            obscureText: isHiddenPassword,
           // obscuringCharacter: '',
          ),

          Container(
            margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.yellow[700], borderRadius: BorderRadius.circular(12)),
            child:FlatButton(
              // color: Colors.amber,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed:() async {
                  if ((loginEmail.text.length == 0) ||
                      (loginPassword.text.length == 0)){
                    Fluttertoast.showToast(
                        msg:
                        "Either User Name or password field is empty",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  }else if((dropdownValue==null)) {
                    Fluttertoast.showToast(
                        msg: "Please Select Officer Login",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  }else{
                    print("----login--");
                    final String url = 'http://13.235.67.23:8000/api/auth/NewLogin';
                    Map data = {
                      "email_or_phone": loginEmail.text,
                      "password": loginPassword.text
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
                    print("----------------------login----------------");
                    print(responseJson);
                    if (responseJson['status'] == "success") {
                      setState(() {
                        userId=responseJson['data']['id'];
                        userName = responseJson['data']['name'];
                        userEmail = responseJson["data"]["email"];
                        sessionToken = responseJson['token'];
                        userGroup=responseJson['data']['user_group'][0];
                        userMobile = responseJson["data"]["phone"];
                        userAddress = responseJson["data"]["address"];
                        userProfile=responseJson["data"]["photo_proof_img"];
                      });
                      print(login_holder);
                      if(responseJson['data']['user_group'][0].toString().toLowerCase()== dropdownValue.toLowerCase()){
                        if(responseJson['data']['user_group'][0].toString().toLowerCase()=='division officer'){
                          prefs.setBool('isLoggedIn', false);
                          prefs.setString('LoginUser', loginEmail.text);
                          prefs.setString('LoginPass', loginPassword.text);
                          setState(() {
                            userRange=responseJson['data']['range'];
                            URange=List<String>.from(userRange);
                          });
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
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
                                    return DivisonDashBoard(
                                      userId:userId,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue,
                                      userRange:URange,
                                    );
                                  }));
                        }else if(responseJson['data']['user_group'][0].toString().toLowerCase()=='state officer'){
                          prefs.setBool('isLoggedIn', false);
                          prefs.setString('LoginUser', loginEmail.text);
                          prefs.setString('LoginPass', loginPassword.text);
                          setState(() {
                            Dist_Range=responseJson['data']['division_range_list'];
                            print("----------------------------#%%%------");
                            print(Dist_Range[52]['division']);
                            print(Dist_Range.length.toString());
                            for(int i=0;i<Dist_Range.length;i++){
                              print(Dist);
                              Dist.add(responseJson['data']['division_range_list'][i]['division']);
                             Range.add(responseJson['data']['division_range_list'][i]['ranges']);
                                for(int j=0;j<Range[i].length;j++){
                                  URange.add(Range[i][j].toString());
                                }

                            }
                          });
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
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
                                    return SFDashboard(
                                      userId:userId,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue,
                                        userMobile:userMobile,
                                        userProfile:userProfile,
                                        userAddress:userAddress,
                                      Dist:Dist,
                                      Range:URange,
                                    );
                                  }));
                        }
                        else if(responseJson['data']['user_group'][0].toString().toLowerCase()=='field officer'){
                            prefs.setBool('isLoggedIn', false);
                            prefs.setString('LoginUser', loginEmail.text);
                            prefs.setString('LoginPass', loginPassword.text);
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
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
                                    return FieldOfficerDashboard(
                                        userId:userId,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue,
                                      userMobile:userMobile,
                                      userProfile:userProfile,
                                      userAddress:userAddress
                                    );
                                  }));

                        } else {
                          if(userGroup=='forest range officer'){
                            Range=responseJson['data']['range'];
                            print(Range);
                          }
                          prefs.setBool('isLoggedIn', false);
                          prefs.setString('LoginUser', loginEmail.text);
                          prefs.setString('LoginPass', loginPassword.text);
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
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
                                    return OfficerDashboard(
                                      userId:userId,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue,
                                      Range:Range,
                                      //  userMobile:userMobile,
                                      //  userImage:userImage,
                                    );
                                  }));
                        }
                        }

                    }else {
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => login()),
                      );
                      Fluttertoast.showToast(
                          msg: 'Invalid credentials',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 4,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    }
                  }

                }),
          ),
          SizedBox(
            height: 10,
          ),

          FlatButton(
              onPressed:(){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) => forgetPassword())
                );
              } ,
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontStyle: FontStyle.normal ,
                  color: Colors.blue[700],
                  fontSize: 16,
                ),
              )
          ),
          SizedBox(
            height: 10,
          ),
        ])
    );
  }
}

//-------------------------------End---OfficerLogin-----------------------------
