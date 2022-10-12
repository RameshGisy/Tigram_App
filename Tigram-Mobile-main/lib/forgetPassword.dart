import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Tigram/newPassword.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart'as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class forgetPassword extends StatefulWidget {
  @override
  _forgetPasswordState createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  int userId;
  bool flag=false;
  bool NewPage=false;
  TextEditingController f_Email = TextEditingController();
  TextEditingController f_Mobile = TextEditingController();
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: NewGradientAppBar(
          title: Text("Forget Password" ,
            textAlign: TextAlign.left,
          ),
        //  gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          // backgroundColor: Colors.blueGrey,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(top: 20,bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image:DecorationImage(
                      image:AssetImage('assets/images/Logo.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                border: Border.all(
                    color: Colors.lightGreenAccent,
                    width: 2
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
              margin: const EdgeInsets.only(top: 10,bottom: 15,left: 15,right: 15),
              padding: const EdgeInsets.only(left: 15,right: 15,top:25,bottom: 10),
              child: Column(
                children: <Widget>[
                  /*Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
               child: TextField(
                 controller: f_Email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide( width: 2),
                      borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0)),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    hintText: 'Enter E-mail'),
              ),
            ),
               Padding(
                 padding: const EdgeInsets.only(
                     left: 15.0, right: 15.0, top: 15, bottom: 0),
                 //padding: EdgeInsets.symmetric(horizontal: 15),
                 child: Text(
                   '-----OR------',
                   textAlign: TextAlign.center,
                   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                 ),
               ),*/

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: f_Mobile,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide( width: 2),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0)),
                          ),
                          prefixIcon: Icon(Icons.mobile_friendly_outlined),
                          labelText: 'Mobile',
                          hintText: 'Enter Mobile'),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                    child:FlatButton(
                      // color: Colors.amber,
                        child: Text(
                          'Send OTP',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed:() async {
                          if (f_Mobile.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: 'Please fill feild',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          } else {
                            NewPage=true;
                            final String url = 'http://13.235.67.23:8000/api/auth/forgotpassword';
                            Map data = {
                              "phone": f_Mobile.text,
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
                            Map<String, dynamic> responseJson = json.decode(
                                response.body);
                            print(
                                "----------------------Register----------------");
                            print(responseJson);
                            if (responseJson['status'] == 'Success') {
                              setState(() {
                                userId = responseJson['data']['id'];
                              });
                              print(userId);
                              Fluttertoast.showToast(
                                  msg: responseJson['message'].toString(),
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            }else{
                              Fluttertoast.showToast(
                                  msg: responseJson['message'].toString(),
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (_) => forgetPassword())
                              );
                            }
                          }
                        }),
                  ),
                  LayoutBuilder(
                      builder: (context, constraints) {
                        if(NewPage == true) {
                          return Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                                    //padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      '------Verify OtP-------',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreenAccent),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                                    //padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'OTP Send on Email OR Mobile Number: '+f_Mobile.text,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                                    //padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: TextField(
                                      controller: otp,
                                      decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {

                                              });
                                            },
                                            child: Icon(Icons.check_circle,
                                                color: (flag) == false ? Colors.red : Colors.green),),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide( width: 2),
                                            borderRadius: const BorderRadius.all(
                                                const Radius.circular(20.0)),
                                          ),
                                          prefixIcon: Icon(Icons.mobile_friendly_outlined),
                                          labelText: 'OTP',
                                          hintText: 'Enter OTP'),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                                    child:FlatButton(
                                      // color: Colors.amber,
                                        child: Text(
                                          'Verify',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed:() async {
                                          if(otp.text.length==0){
                                            Fluttertoast.showToast(
                                                msg: 'Please Enter OTP',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 4,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 18.0);
                                          }else{
                                            final String url = 'http://13.235.67.23:8000/api/auth/forgotverifyotp';
                                            Map data = {
                                              "user_id":userId,
                                              "otp":otp.text,
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
                                            Map<String, dynamic> responseJson = json.decode(
                                                response.body);
                                            print(
                                                "----------------------Register----------------");
                                            print(responseJson);
                                            if (responseJson['status'] == 'Success') {
                                              flag=true;
                                              setState(() {
                                                userId = responseJson['data']['id'];
                                              });
                                              print(userId);
                                              Fluttertoast.showToast(
                                                  msg: responseJson['message'].toString(),
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.blue,
                                                  textColor: Colors.white,
                                                  fontSize: 18.0);
                                              Navigator.push(
                                                  context, MaterialPageRoute(
                                                  builder: (_) => newPassword(
                                                    userId:userId,
                                                  ))
                                              );
                                            }else{
                                              Fluttertoast.showToast(
                                                  msg: responseJson['message'].toString(),
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 18.0);
                                            }

                                          }

                                        }
                                    ),
                                  ),
                                ],
                              )
                          );
                        }else if(NewPage == false){
                          return Container(
                            width: 0,
                            height: 0,
                            color: Colors.white,
                          );
                        }
                      }
                  ),

                          ],
                      )
                  )
                ],
              ),
            )
    );
  }
}
