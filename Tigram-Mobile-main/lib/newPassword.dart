import 'package:Tigram/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class newPassword extends StatefulWidget {
  int userId;
  newPassword({this.userId});
  @override
  _newPasswordState createState() => _newPasswordState(userId);
}

class _newPasswordState extends State<newPassword> {
  int userId;
  TextEditingController Password = TextEditingController();
  TextEditingController Re_Password = TextEditingController();
  _newPasswordState(this.userId);
  bool isHiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        title: Text("Set New Password"),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        elevation: 0,
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
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: Password,
                          obscureText: isHiddenPassword,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isHiddenPassword = !isHiddenPassword;
                                    });
                                  },
                                  child: Icon(Icons.visibility,
                                      color: Colors.black54)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide( width: 2),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0)),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter Password'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: Re_Password,
                          obscureText:isHiddenPassword,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      print("hi...");
                                      isHiddenPassword = !isHiddenPassword;
                                    });
                                  },
                                  child: Icon(Icons.visibility,
                                      color: Colors.black54)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide( width: 2),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0)),
                              ),
                              labelText: 'Re-Password',
                              hintText: 'Repeat Password'),
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
                              'Confirm',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            onPressed:()async{
                              if((Password.text.length==0)||(Re_Password.text.length==0)){
                                Fluttertoast.showToast(
                                    msg: 'Password Feild is Empty',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              }
                              else if((Password.text)!=(Re_Password.text)){
                                Fluttertoast.showToast(
                                    msg: 'Please Enter Password & Re-password Same',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              }else{
                                final String url = 'http://13.235.67.23:8000/api/auth/changepassword';
                                Map data = {
                                  "user_id":userId,
                                  "new_password":Password.text,
                                  "confirm_password":Re_Password.text,
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
                                print("----------------------New Password----------------");
                                print(responseJson);
                                if (responseJson['status'] == 'Success') {
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
                                }
                              }
                              Navigator.pushReplacement(
                                  context,MaterialPageRoute(builder: (_) => login())
                              );
                            }),
                      ),
                    ],
                  ),
                )
              ])
      ),
    );

  }
}
