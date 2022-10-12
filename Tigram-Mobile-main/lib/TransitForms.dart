import 'package:Tigram/Form2Page1.dart';
import 'package:Tigram/TransitPass.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';


class TransitForms extends StatefulWidget {
  String sessionToken;
  String userName;
  String userEmail;

  TransitForms({this.sessionToken,this.userName,this.userEmail});

  @override
  _TransitFormsState createState() => _TransitFormsState(sessionToken,userName,userEmail);
}

class _TransitFormsState extends State<TransitForms> {
  String sessionToken;
  String userName;
  String userEmail;
  _TransitFormsState(this.sessionToken,this.userName,this.userEmail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          'Forms'
        ),
     //   gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        elevation: 0,
       // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) => TransitPass(
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
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#36d1dc"),HexColor("#5b86e5")]),
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
                        'FORM - I',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:15.0),
                      child: Text(
                        '( Transit Pass For  Non-Notified Villages )',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ]
                  )
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (_) =>Form2Page1(
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
                  margin: const EdgeInsets.only(top:5,left:20,right:20,bottom:20.0),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#4568dc"),HexColor("b06ab3")]),
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
                        'FORM - II',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:15.0),
                      child: Text(
                        '( Transit Pass For Notified Villages )',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ]
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
