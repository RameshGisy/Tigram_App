//import 'dart:html';
import 'dart:convert';
import 'dart:io' show File ;
import 'dart:io'as Io;
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:Tigram/homePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  String sessionToken;
  String userName;
  String userProfile;
  String userEmail;
  String userMobile;
  String userAddress;
  Profile({this.sessionToken,this.userName,this.userEmail,this.userMobile,this.userAddress,this.userProfile,});
  @override
  _ProfileState createState() => _ProfileState(sessionToken,userName,userEmail,userMobile,userAddress,userProfile);
}

class _ProfileState extends State<Profile> {
  String sessionToken;
  String userName;
  String userProfile;
  String userEmail;
  String userMobile;
  String userAddress;
  _ProfileState(this.sessionToken,this.userName,this.userEmail,this.userMobile,this.userAddress,this.userProfile);
  bool flag= true;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  void initState()  {
    super.initState();
    viewProfile();
  }

  String Vphone='';
  String Vemail='';
  String Vname='';
  String Vaddress='';
  String pic_url='';


  File _imgProfile;
  final ImagePicker _picker = ImagePicker();
  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    //final bytes = Io.File(_imageFile.path).readAsBytesSync();
    setState(() {
      _imgProfile = pickedFile ;
      print("------------------------------Profile Image--------------");
      print(_imgProfile.path);
    });
  }
  viewProfile()async{
    final String url = 'http://13.235.67.23:8000/api/auth/ViewProfile';

    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    setState(() {
      Vphone=responseJSON['user']['phone'];
      Vemail=responseJSON['user']['email'];
      Vname=responseJSON['user']['name'];
      Vaddress=responseJSON['user']['address'];
      pic_url=responseJSON['user']['pic_url'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Profile "),
      //  gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        actions: [Container(
          padding: EdgeInsets.only(right:15),
          child:LayoutBuilder(
              builder: (context, constraints) {
                if(flag == true) {
                  return  IconButton(
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        setState(() {
                          flag=false;
                        });
                      }
                  );
                }else if(flag == false){
                  return  IconButton(
                      icon: Icon(
                        Icons.save_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () async{
                        final bytes = Io.File(_imgProfile.path).readAsBytesSync();
                        String profile_base= _imgProfile.path != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
                        print(profile_base);
                        final String url = 'http://13.235.67.23:8000/api/auth/EditProfile';
                        print (profile_base);
                        Map data = {
                          "name":name.text,
                          "contact":phone.text,
                          "address":address.text,
                          "profile_photo" :{
                            "type":".png",
                            "image":profile_base,
                          },
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
                        print(response);
                        Map<String, dynamic> responseJson = json.decode(response.body);
                        print("----------------------Update Profile----------------");
                        print(responseJson);
                        Fluttertoast.showToast(
                            msg:responseJson['message'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                        setState(() {
                          flag=true;
                        });
                      }
                  );
                }
              }
          ),
        )
        ],
       // backgroundColor: Colors.blueGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                      offset: Offset(
                          2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                margin: const EdgeInsets.only(left:10,right:10,top: 10,bottom: 10),
                padding: const EdgeInsets.all(8),
                child:LayoutBuilder(
                    builder: (context, constraints) {
                      if(flag == true) {
                        return Column(
                            children: <Widget>[
                              Stack(
                                alignment:Alignment.center,
                                  children: <Widget>[
                                    Image(
                                      height: MediaQuery.of(context).size.height/3,
                                      width: double.infinity,
                                      fit:BoxFit.cover,
                                      image: NetworkImage("https://images.pexels.com/photos/311458/pexels-photo-311458.jpeg?cs=srgb&dl=pexels-scott-webb-311458.jpg&fm=jpg"),
                                    ),
                                    Positioned(child:CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        pic_url,
                                      ),
                                      radius: 50.0,
                                    ),
                                    ),

                                  ]
                              ),

                              Card(child: ListTile(leading: Icon(Icons.perm_identity_rounded),title: Text(Vname, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                              Card(child: ListTile(leading: Icon(Icons.email_outlined),title: Text(Vemail, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                              Card(child: ListTile(leading: Icon(Icons.phone),title: Text(Vphone, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                              Card(child: ListTile(leading: Icon(Icons.home_outlined),title: Text(Vaddress, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),

                            ],
                          );

                      }else if(flag == false){
                        name.text=Vname;
                        phone.text=Vphone;
                        address.text=Vaddress;
                        return Column(
                            children: <Widget>[
                              Stack(
                                  alignment:Alignment.center,
                                  children: <Widget>[
                                    Image(
                                      height: MediaQuery.of(context).size.height/3,
                                      width: double.infinity,
                                      fit:BoxFit.cover,
                                      image: NetworkImage("https://images.pexels.com/photos/311458/pexels-photo-311458.jpeg?cs=srgb&dl=pexels-scott-webb-311458.jpg&fm=jpg"),
                                    ),
                                    Positioned(child:CircleAvatar(
                                      backgroundImage:  _imgProfile== null
                                          ?  NetworkImage('$pic_url')
                                          : FileImage(File(_imgProfile.path)),
                                      radius: 50.0,
                                    ),
                                    ),
                                    Positioned(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              takePhoto(ImageSource.gallery);
                                            });
                                          },
                                          child: Icon(Icons.camera_alt,
                                              color: (_imgProfile?.path) == null ? Colors.red : Colors.green, size: 25.0),
                                        )),
                                  ]
                              ),
                              Card(child: ListTile(leading: Icon(Icons.perm_identity_rounded),title: TextField(controller: name, decoration: InputDecoration(border: InputBorder.none,hintText: userName),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                              Card(child: ListTile(leading: Icon(Icons.email_outlined),title: Text(userEmail, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                              Card(child: ListTile(leading: Icon(Icons.phone),title: TextField(controller: phone,   keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none,hintText: userMobile), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                              Card(child: ListTile(leading: Icon(Icons.home_outlined),title: TextField(controller: address, decoration: InputDecoration(border: InputBorder.none,hintText: userAddress.toString()), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),),
                            ],
                        );
                      }
                    }
                ),
              )
          ],
        ),
      ),
    );
  }
}
