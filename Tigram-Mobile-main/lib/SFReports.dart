import 'package:Tigram/SFViewReports.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';


class SFReports extends StatefulWidget {
  String sessionToken;
  List <String> Dist;
  List <String> Range;
  SFReports({this.sessionToken,this.Dist,this.Range});
  @override
  _SFReportsState createState() => _SFReportsState(sessionToken,Dist,Range);
}

class _SFReportsState extends State<SFReports> {
  String sessionToken;
  List <String> Dist;
  List <String> Range;
  _SFReportsState(this.sessionToken,this.Dist,this.Range);

  String SelectedRange;
  String SelectedRange1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          title: Text(
              'All Records'
          ),
    //      gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          elevation: 0,

        ),
        body: Container(
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,//<---- Insert Gradient Here
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),*/
            margin: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
            padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
            child:ListView(
              children:<Widget> [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 0,left:10,right: 10,bottom: 5),
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.blue,width: 1,), borderRadius: BorderRadius.circular(8)
                  ),
                  padding: const EdgeInsets.only(left:15,right: 15),
                  child: Row(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: SelectedRange,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint:  RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Select Range",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                            TextSpan(
                                text: " * ",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14,
                                )),
                          ]),
                        ),
                        /*underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),*/
                        onChanged: (String data) {
                          setState(() {
                            SelectedRange = data;
                          });

                        },
                        items:Range.toSet().toList().map<DropdownMenuItem<String >>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toString(),style: TextStyle(fontSize: 16),),
                          );
                        }).toList(),
                      ),
                      Spacer(),
                      DropdownButton<String>(
                        value: SelectedRange1,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint:  RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Selected Division",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " * ",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14,
                                )),
                          ]),
                        ),
                        /*underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),*/
                        onChanged: (String data) {
                          setState(() {
                            SelectedRange1 = data;
                          });
                        },
                        items:Dist.toSet().toList().map<DropdownMenuItem<String >>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toString(),style: TextStyle(fontSize: 16),),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Card(child: ListTile(title: Text('Application Received/Approved/Rejected'),
                    onTap: (){
                      int R1=1;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R1:R1,))
                      );
                    }
                ),
                  elevation: 3,),
                Card(child: ListTile(title: Text('Reason For Rejection'),
                    onTap: (){
                      int R2=2;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R2:R2,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Species-wise Volume & Tree Transport'),
                    onTap: (){
                      int R3=3;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R3:R3,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Volume & No. of tree Transported'),
                    onTap: (){
                      int R4=4;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R4:R4,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Species wise Total volume transported & Total  No of trees transported to each destination'),
                    onTap: (){
                      int R5=5;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R5:R5,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Total volume transported to each destination'),
                    onTap: (){
                      int R6=6;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R6:R6,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Time takes for application'),
                    onTap: (){
                      int R7=7;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R7:R7,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Reason for cutting'),
                    onTap: (){
                      int R8=8;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R8:R8,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Number of Application received before & after cutting the tree'),
                    onTap: (){
                      int R9=9;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R9:R9,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('NOC Report'),
                    onTap: (){
                      int R10=10;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => SFViewReports(sessionToken:sessionToken,SelectedRange:SelectedRange,SelectedRange1:SelectedRange1,R10:R10,))
                      );
                    }
                ),elevation: 3,),
              ],
            )
        )
    );
  }
}
