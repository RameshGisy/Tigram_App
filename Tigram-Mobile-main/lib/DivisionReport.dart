import 'package:Tigram/DivisionViewReport.dart';
import 'package:Tigram/ViewReports.dart';
import 'package:flutter/material.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DivisionReport extends StatefulWidget {
  String sessionToken;
  List userRange;
  DivisionReport({this.sessionToken,this.userRange});
  @override
  _DivisionReportState createState() => _DivisionReportState(sessionToken,userRange);
}

class _DivisionReportState extends State<DivisionReport> {
  String sessionToken;
  List<String> userRange;
  _DivisionReportState(this.sessionToken,this.userRange);

  String SelectedRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          title: Text(
              'All Records'
          ),
         // gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          // backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [
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
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " * ",
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
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
                print(SelectedRange);
              },
              items:userRange.toSet().toList().map<DropdownMenuItem<String >>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
         // automaticallyImplyLeading: false,
        ),
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 1
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
            margin: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
            padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
            child:ListView(
              children:<Widget> [
                Card(child: ListTile(title: Text('Application Received/Approved/Rejected'),
                    onTap: (){
                      int R1=1;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R1:R1,))
                      );
                    }
                ),
                  elevation: 3,),
                Card(child: ListTile(title: Text('Reason For Rejection'),
                    onTap: (){
                      int R2=2;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R2:R2,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Species-wise Volume & Tree Transport'),
                    onTap: (){
                      int R3=3;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R3:R3,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Volume & No. of tree Transported'),
                    onTap: (){
                      int R4=4;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R4:R4,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Species wise Total volume transported & Total  No of trees transported to each destination'),
                    onTap: (){
                      int R5=5;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R5:R5,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Total volume transported to each destination'),
                    onTap: (){
                      int R6=6;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R6:R6,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Time takes for application'),
                    onTap: (){
                      int R7=7;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R7:R7,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Reason for cutting'),
                    onTap: (){
                      int R8=8;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R8:R8,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('Number of Application received before & after cutting the tree'),
                    onTap: (){
                      int R9=9;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R9:R9,))
                      );
                    }
                ),elevation: 3,),
                Card(child: ListTile(title: Text('NOC Report'),
                    onTap: (){
                      int R10=10;
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => DivisionViewReport(sessionToken:sessionToken,SelectedRange:SelectedRange,R10:R10,))
                      );
                    }
                ),elevation: 3,),
              ],
            )
        )
    );
  }
}
