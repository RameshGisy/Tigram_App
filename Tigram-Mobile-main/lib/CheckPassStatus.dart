
import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'dart:isolate';

import 'dart:ui';
import 'package:Tigram/NocViewApplication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
//import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:Tigram/Form1.dart';
import 'package:Tigram/ViewApplication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Directory, File, FileMode, HttpClient, HttpClientRequest, HttpClientResponse, Platform;
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:schedulers/schedulers.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CheckPassStatus extends StatefulWidget {
  String sessionToken ;
  String userName ;
  String userEmail;
  String userGroup;
  CheckPassStatus({this.sessionToken,this.userName,this.userEmail,this.userGroup});
  @override
  _CheckPassStatusState createState() => _CheckPassStatusState(sessionToken,userName,userEmail,userGroup);
  
}

class _CheckPassStatusState extends State<CheckPassStatus> {
  String sessionToken ;
  String userName ;
  String userEmail;
  String userGroup;

_CheckPassStatusState(this.sessionToken,this.userName,this.userEmail,this.userGroup);
  final imageUrl = "http://13.235.67.23:8000/api/auth/new_transit_pass_pdf/90/";
  final scheduler = LazyScheduler(latency: Duration(seconds: 1));

 // List<Status> status = <Status>[];
 // StatusDataSource statusDataSource;

  bool downloading=true;
  String downloadingStr="No data";
  double download=0.0;
  File f;

  Future downloadFile() async
  {
    try{

      Dio dio=Dio();
      var dir=await getApplicationDocumentsDirectory();
      f=File("${dir.path}/myimagepath.jpg");
      String fileName=imageUrl;
      dio.download(imageUrl, "${dir.path}/$fileName",onReceiveProgress: (rec,total){
        setState(() {
          downloading=true;
          download=(rec/total)*100;
          downloadingStr="Downloading Image : "+(download).toStringAsFixed(0);
        });

        setState(() {
          downloading=false;
          downloadingStr="Completed";

        });

      });
    }catch( e)
    {
      print(e.getMessage());
    }


  }




  @override
  void initState() {
    super.initState();
    check_pass();
    NocForm();

    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });


    FlutterDownloader.registerCallback(downloadingCallback);
  }

  int progress = 0;


  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort.send([id, status, progress]);
  }

 void _requestDownload(String link) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final localPath = await getExternalStorageDirectory();
      final Id = await FlutterDownloader.enqueue(
        url: link,
        savedDir: localPath.path,
        showNotification: true,
        openFileFromNotification: true,
      );
      print(localPath.path);
    }else {
      print("Permission deined");
    }
  }


  void _requestDownload1(String link) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final localPath = await getExternalStorageDirectory();
      final Id1 = await FlutterDownloader.enqueue(
        url: link,

        savedDir: localPath.path,
        showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );
      print(localPath.path);
    }else {
      print("Permission deined");
    }
  }

  final List Ids = [];
  final List sr=[];
  final List App_no = [];
  final List App_Date = [];
  final List App_Status = [];
  final List Current_status = [];
  final List Tp_status = [];
  final List Tp_Issue_Date = [];
  final List Tp_Number = [];
  final List days_left_transit = [];
  final List Remark = [];
  final List Action = [''];
  List  list=[];
  final List verify_range=[];
  final List depty_range_officer=[];
  final List verify_range_officer=[];
  final List tp_expiry_date=[];

  //------------
  final List reason_office=[];
  final List reason_depty_ranger_office=[];
  final List reason_range_officer=[];
  final List disapproved_reason=[];


  final List division=[];
  final List other_State=[];
  final List division_date=[];
  final List reason_division=[];
  final List is_form_two=[];

  //
  final List verify_deputy2=[];
  final List reason_deputy2=[];
  final List deputy2_date=[];

  final List assigned_deputy1_by_id=[];
  final List assigned_deputy2_by_id=[];
  final List log_updated_by_use=[];
  final List verify_forest1=[];
  //------------
  Map<String, dynamic> responseJSON;
  int allApplication = 0;
  void check_pass() async {
    //----clear----
    sr.clear();
    App_no.clear();
    App_Date.clear();
    Current_status.clear();
    days_left_transit.clear();
    Action.clear();
    Remark.clear();
    Tp_Issue_Date.clear();
    Tp_Number.clear();
    verify_range.clear();
    depty_range_officer.clear();
    verify_range_officer.clear();
    tp_expiry_date.clear();
    reason_office.clear();
    reason_depty_ranger_office.clear();
    reason_range_officer.clear();
    disapproved_reason.clear();
    division.clear();
    reason_division.clear();
    division_date.clear();
    other_State.clear();
    verify_deputy2.clear();
    reason_deputy2.clear();
    deputy2_date.clear();
    is_form_two.clear();
    assigned_deputy1_by_id.clear();
    assigned_deputy2_by_id.clear();
    log_updated_by_use.clear();
    verify_forest1.clear();
    //-----clear------
    print("hello");
    final String url = 'http://13.235.67.23:8000/api/auth/ListViewApplication';

    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);

     List list = responseJSON["data"];

    setState(() {
     //print(list);
      allApplication = list.length;

    });
    for (var i = 0; i < allApplication; i++) {
      sr.add((i).toString());
      Ids.add(list[i]['id'].toString());
      App_no.add(list[i]['application_no']);
      App_Date.add(list[i]['created_date'].toString());
      App_Status.add(list[i]['application_status'].toString());
      Current_status.add(list[i]['created_date'].toString());
      Tp_status.add(list[i]['application_status'].toString());
      Tp_Issue_Date.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number.add(list[i]['transit_pass_id'].toString());
      days_left_transit.add(list[i]['transit_pass_created_date'].toString());
      verify_range.add(list[i]['verify_office']);
      depty_range_officer.add(list[i]['depty_range_officer']);
      verify_range_officer.add(list[i]['verify_range_officer']);
      tp_expiry_date.add(list[i]['tp_expiry_date']);
     // Action.add(list[i][''].toString());
      Remark.add(list[i]['reason_range_officer'].toString());
      reason_office.add(list[i]['reason_office']);
      reason_depty_ranger_office.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer.add(list[i]['reason_range_officer']);
      disapproved_reason.add(list[i]['disapproved_reason']);

      division.add(list[i]['division_officer']);
      reason_division.add(list[i]['reason_division_officer']);
      division_date.add(list[i]['division_officer_date']);
      // Remark.add(list[i]['transit_pass_created_date']);
      other_State.add(list[i]['other_state']);
      is_form_two.add(list[i]['is_form_two']);

      verify_deputy2.add(list[i]['verify_deputy2']);
      reason_deputy2.add(list[i]['reason_deputy2']);
      deputy2_date.add(list[i]['deputy2_date']);

      assigned_deputy1_by_id.add(list[i]['assigned_deputy1_name']);
      assigned_deputy2_by_id.add(list[i]['assigned_deputy2_name']);
      log_updated_by_use.add(list[i]['log_updated_by_user']);
      verify_forest1.add(list[i]['verify_forest1']);

    }

    print("---------------check--pass----------------");
    print(Ids+App_no+App_Date+App_Status+Current_status);
    print("---------------Date Time----------------");
    print(tp_expiry_date);
    print("------------------Deputy name-------------");
    print(assigned_deputy1_by_id);
  }


  //-------------------------Noc--Form------------------------------------
  //--------------------
  int allApplication3 = 0;
  final List Ids3 = [];
  final List sr3=[];
  final List App_no3 = [];
  final List App_Name3 = [];
  final List App_Date3 = [];
  final List Current_status3 = [];
  final List days_left_transit3 = [];
  final List Approved_date3 = [];
  final List Action3 = [];
  final List Remark3 = [];
  final List Remark_date3 = [];
  final List Tp_status3 = [];
  final List Tp_Issue_Date3 = [];
  final List Tp_Number3 = [];

  //--------------------

  void NocForm()async{
    sr3.clear();
    print("Noc Application");
    final String url = 'http://13.235.67.23:8000/api/auth/UserNocListApplication';
    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    List list = responseJSON["data"];
    setState(() {
      allApplication3 = list.length;
    });
    for (var i = 0; i < allApplication3; i++) {
      sr3.add(i.toString());
      Ids3.add(list[i]['id'].toString());
      App_no3.add(list[i]['application_no']);
      App_Name3.add(list[i]['name'].toString());
      App_Date3.add(list[i]['created_date'].toString());
      Current_status3.add(list[i]['application_status'].toString());
      days_left_transit3.add(list[i]['application_status'].toString());
      Approved_date3.add(list[i]['verify_office_date'].toString());
      Action3.add(list[i][''].toString());
      Remark3.add(list[i]['reason_office'].toString());
      Remark_date3.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date3.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number3.add(list[i]['transit_pass_created_date'].toString());
    }
    print("---------------Noc-Application----------------");
    print(Ids3+App_no3+App_Date3+App_Name3+Current_status3);
  }

  //-----------------------End-Noc-Form-----------------------------------
  String OfficerRemark(String AppStatus,String disapproved,String division,String forest,String deputy,String revenue){
    if(AppStatus=='R'){
      return disapproved;
    }
    else if(division.isNotEmpty){
      return division;
    }
    else if(forest.isNotEmpty){
      return forest;
    }
    else if(deputy.isNotEmpty){
      return deputy;
    }
    else if(revenue.isNotEmpty){
      return revenue;
    }else{
      return "N/A";
    }
  }
  String OfficerDate(String AppStatus,String disapproved,String division,String forest,String deputy,String revenue){
    if(AppStatus=='R'){
      return disapproved;
    }
    else if(division!=null){
      return division;
    }
    else if(forest!=null){
      return forest;
    }
    else if(deputy!=null){
      return deputy;
    }
    else if(revenue!=null){
      return revenue;
    }else{
      return "N/A";
    }
  }

  String OfficerStatus(bool division,bool revenue,bool deputy,bool forest,String AppStatus, bool otherState,bool deputy2,bool log_updated_by_user,bool verify_forest1){
    if(division==true){
      if(AppStatus=='R'){
        return "Rejected By Division Officer";
      }else{
        return "Approved by Division Officer";
      }
    }
    else if(forest==true){
      if(otherState==false){
        if(AppStatus=='R'){
          return "Rejected By Forest Range Officer";
        }else{
          return "Approved by Forest Range Officer";
        }
      }else{
        if(AppStatus=='R'){
          return "Rejected By Forest Range Officer";
        }else{
          return "Approved by Forest Range Officer \& \n Division Officer Approval Pending ";
        }
      }
    }
    else if(deputy==true){
      if(AppStatus=='R'){
        return "Rejected By Deputy Range Officer";
      }else{
        return "Approved by Deputy Range Officer \& \n Forest Range Officer Approval Pending";
      }
    }
    else if(verify_forest1==true){
      if(log_updated_by_user==true){
        if(App_Status=='R'){
          return 'Rejected by Forest Range Officer';
        }else{
          return 'Wood logs details have been be\n entered for Stage 2. Deputy Range \nOfficer Approval Pending for Stage 2';
        }
      } else{
        if(App_Status=='R'){
          return 'Rejected by Forest Range Officer\n(Trees Cutting Approval)';
        }else{
          return 'Approved by Forest Range Officer\n for cutting of Trees. Wood logs\n details to be entered.';
        }
      }
    }
    else if(deputy2==true){
        if(AppStatus=='R'){
          return 'Rejected  by Deputy Range Officer\n at Stage 1';
        }else{
          return 'Approved by Deputy Range Officer\n for Stage 1 and Forest Range Officer\n Approval pending for cutting of trees.';
        }
    }
    else if(revenue==true){
      if(AppStatus=='R'){
        return "Rejected By Revenue  Officer";
      }else{
        return "Approved by Revenue  Officer \& \n Deputy Officer Approval Pending";
      }
    }
    else{
      if(AppStatus=='R'){
        return "Rejected by Revenue Officer";
      }
      else{
        return "Revenue Officer Approval Pending";
      }
    }
  }
  String AssignOfficer( bool isForm2,String assign_deputy2,String assign_deputy1,bool log_updated_by_user){
    if(isForm2==true){
      if(assign_deputy2!=null){
        return assign_deputy2;
      }
      else if(assign_deputy1!=null){
        if(log_updated_by_user==true){
          return 'Yet to Assign for Stage 2';
        }else{
          return  assign_deputy1;
        }
      }else{
        return 'Yet to Assign for Stage 1';
      }
    }
  }


  int daysBetween(DateTime from) {
    DateTime a=DateTime.now();
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime(a.year, a.month, a.day);
    int b= 7-(to.difference(from).inHours / 24).round();
    if(b<0){
      return 0;
    }
    else{
      return b;
    }
  }

  bool _isVisible = true;

  //void showToast() {
  //  if(Remark[int.parse(value)].toString()==null){
  //    _isVisible=false;
   // }
  //}
  var _sortAscending = true;
  var _sortColumnIndex = 0;
  int _currentSortColumn = 9;
  bool _isAscending = true;


  int _radioValue = 0;
  bool flag= true;
  var tab=0;
  @override
  void _handleRadioValueChange(int value) async {
    setState(() {
      _radioValue = value;
      if (_radioValue == 0) {

        setState(() {
          tab=0;
          flag=true;
          check_pass();
        });
      } else if (_radioValue == 1) {
        setState(() {
          tab=1;
          flag=false;
          NocForm();
        });
      }
    });
  }

  GlobalKey myKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          //backgroundColor: Colors.blueGrey,
          title: Text("Check Pass Status"),
      //    gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          elevation: 0,
         // automaticallyImplyLeading: false,
        ),
        body:SingleChildScrollView(
            scrollDirection: Axis.vertical,
           child: Column(
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(top: 10,bottom: 10),
                 child: ToggleSwitch(
                   minWidth:MediaQuery.of(context).size.width,
                   initialLabelIndex: _radioValue,
                   cornerRadius: 8.0,
                   activeFgColor: Colors.white,
                   inactiveBgColor: Colors.grey[200],
                   inactiveFgColor: Colors.blue,
                   labels: ['Transit Pass','NOC'],
                   activeBgColors: [Colors.orange,Colors.green],
                   onToggle: _handleRadioValueChange,
                 ),
               ),
               LayoutBuilder(
                   builder: (context, constraints) {
                    if(tab == 0) {
                       return Container(
                           height: MediaQuery.of(context).size.height * 0.79,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.deepOrangeAccent,
                                 blurRadius: 2.0,
                                 spreadRadius: 1.0,
                                 //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                               )
                             ],
                           ),
                           margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                           padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                           child:Scrollbar(
                               isAlwaysShown: true,
                               thickness: 15,
                            child:SingleChildScrollView(
                               scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(bottom: 15),
                                child:Scrollbar(
                                    isAlwaysShown: true,
                                    thickness: 15,
                                  child :SingleChildScrollView(
                                   scrollDirection: Axis.vertical,
                                   child: DataTable(
                                       sortColumnIndex:_currentSortColumn,
                                       sortAscending:_isAscending,
                                       dividerThickness: 2,
                                       columnSpacing: 20,
                                       showBottomBorder: true,
                                       headingRowColor:
                                       MaterialStateColor.resolveWith((states) => Colors.orange),
                                       columns: [
                                         DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                         DataColumn(label: Text('Application\n       No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                         DataColumn(label: Text('Application \n      Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                         DataColumn(label: Text('Application\n     Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('Current Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('Deputy Officer \n Assignment status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('TP Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('TP Issuing\n      Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('TP No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                         DataColumn(label: Text(' No.of days left\n   for Transit',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('Remark',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                         DataColumn(label: Text('Notified / Non-Notified\n     Villages',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('Download\n    TP',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('Download\n Report',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                         DataColumn(label: Text('Action',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       ],

                                     rows:
                                     sr// Loops through dataColumnText, each iteration assigning the value to element
                                         .map(
                                       ((value) => DataRow(

                                     cells: <DataCell>[
                                       DataCell((Text((int.parse(value)+1).toString()))), //Extracting from Map element the value
                                       DataCell(Text(App_no[int.parse(value)].toString())),
                                       DataCell(Text(App_Date[int.parse(value)].toString())),
                                       DataCell(Text(App_Status[int.parse(value)].toString()=='A'?"Approved":App_Status[int.parse(value)].toString()=='S'?"Submitted":App_Status[int.parse(value)].toString()=='R'?"Rejected":App_Status[int.parse(value)].toString()=='A'?"Accepted":"Pending")),
                                       DataCell(Text(OfficerStatus(division[int.parse(value)],verify_range[int.parse(value)], depty_range_officer[int.parse(value)], verify_range_officer[int.parse(value)],Current_status[int.parse(value)].toString(),other_State[int.parse(value)],verify_deputy2[int.parse(value)],log_updated_by_use[int.parse(value)],verify_forest1[int.parse(value)]))),
                                       DataCell(Text(AssignOfficer(is_form_two[int.parse(value)], assigned_deputy2_by_id[int.parse(value)], assigned_deputy1_by_id[int.parse(value)], log_updated_by_use[int.parse(value)])==null?"N/A":AssignOfficer(is_form_two[int.parse(value)], assigned_deputy2_by_id[int.parse(value)], assigned_deputy1_by_id[int.parse(value)], log_updated_by_use[int.parse(value)]).toString())),
                                       DataCell(Text(Tp_status[int.parse(value)].toString()=='A'?"Approved":Tp_status[int.parse(value)].toString()=='S'?"Submitted":Tp_status[int.parse(value)].toString()=='R'?"Rejected":"Pending")),
                                       DataCell(Text(Tp_Number[int.parse(value)].toString()=='0'?"Not Generated":Tp_Issue_Date[int.parse(value)].toString())),
                                       DataCell(Text(Tp_Number[int.parse(value)].toString()=='0'?"Not Generated":Tp_Number[int.parse(value)].toString())),
                                       DataCell(Text(Tp_Number[int.parse(value)].toString()=='0'?"  N/A  ":"   "+daysBetween(DateTime.parse(Tp_Issue_Date[int.parse(value)].toString())).toString())),
                                       DataCell(Text(OfficerRemark(Current_status[int.parse(value)], disapproved_reason[int.parse(value)],reason_division[int.parse(value)], reason_range_officer[int.parse(value)], reason_depty_ranger_office[int.parse(value)], reason_office[int.parse(value)]))),
                                       DataCell(Text(is_form_two[int.parse(value)]==true?"Notified":"Non-Notified")),
                                       DataCell( Visibility(
                                         visible: (App_Status[int.parse(value)].toString()=='A')?true:false,
                                         child: IconButton(
                                           icon: new Icon(Icons.file_download),
                                           color: Colors.blue,
                                           onPressed: ()async{
                                             await launch("http://13.235.67.23:8000/api/auth/new_transit_pass_pdf/"+Ids[int.parse(value)]+"/");
                                             // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                           },
                                         ),
                                       ),
                                       ),
                                       DataCell(Visibility(
                                         visible: (App_Status[int.parse(value)].toString()=='A')?true:false,
                                         child: IconButton(
                                           icon: new Icon(Icons.file_download),
                                           color: Colors.blue,
                                           onPressed: () async {
                                             // _downloadFile(down,"TransitPass.pdf");
                                             //   downloadFile();
                                             await launch("http://13.235.67.23:8000/api/auth/new_user_report/"+Ids[int.parse(value)]+"/");
                                           },
                                         ),
                                       ),
                                       ),
                                       DataCell(Visibility(
                                         visible: verify_deputy2[int.parse(value)]==true?true: App_Status[int.parse(value)].toString()=='A'?true:false,
                                         child: IconButton(
                                           icon: new Icon(Icons.visibility),
                                           color: Colors.blue,
                                           onPressed: (){
                                             if(userGroup=='user'){
                                               String IDS= Ids[int.parse(value)].toString();
                                               Navigator.push(
                                                   context,MaterialPageRoute(builder: (_) =>
                                                   ViewApplication(
                                                     sessionToken:sessionToken,
                                                     userGroup:userGroup,
                                                     Ids:IDS,
                                                   ))
                                               );
                                             }
                                           },
                                         ),
                                       ),),
                                     ],
                                   )),
                                 ).toList(),
                               )
                               )
                            )
                           )
                       )
                       );
                     }else if(tab == 1) {
                       return Container(
                           height: MediaQuery.of(context).size.height * 0.78,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.green,
                                 blurRadius: 2.0,
                                 spreadRadius: 1.0,
                                 //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                               )
                             ],
                           ),
                           margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                           padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                           child:Scrollbar(
                               isAlwaysShown: true,
                               thickness: 15,
                            child:SingleChildScrollView(
                               scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(bottom: 10),
                                child:Scrollbar(
                                    isAlwaysShown: true,
                                    thickness: 15,
                                  child :SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                   child:DataTable(
                                     columnSpacing: 20,
                                     dividerThickness: 2,
                                     headingRowColor:
                                     MaterialStateColor.resolveWith((states) => Colors.green),
                                     columns: [
                                       DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                       DataColumn(label: Text('Application\n       No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       DataColumn(label: Text('Application\n      Name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       DataColumn(label: Text('Application\n      Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       //DataColumn(label: Text('Current\n   Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       //DataColumn(label: Text('Days  left\nfor Approved',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       // DataColumn(label: Text('Approved\n    Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       DataColumn(label: Text('Action',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       DataColumn(label: Text('Download\n   NOC',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       //DataColumn(label: Text('Download\n Report',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       //DataColumn(label: Text('QR Code',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       //DataColumn(label: Text('Remark',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                       // DataColumn(label: Text('Remark\n  Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                     ],
                                     rows:
                                     sr3// Loops through dataColumnText, each iteration assigning the value to element
                                         .map(
                                       ((value) => DataRow(
                                         cells: <DataCell>[
                                           DataCell((Text((int.parse(value)+1).toString()))), //Extracting from Map element the value
                                           DataCell(Text(App_no3[int.parse(value)].toString())),
                                           DataCell(Text(App_Name3[int.parse(value)].toString())),
                                           DataCell(Text(App_Date3[int.parse(value)].toString())),
                                           //DataCell(Text(Current_status3[int.parse(value)].toString()=='S'?"Submitted":Current_status3[int.parse(value)].toString()=='P'?"Pending":"Rejected")),
                                           // DataCell(Text(days_left_transit3[int.parse(value)].toString()==6?"Not Generated":"Not Generated")),
                                           // DataCell(Text((Approved_date3[int.parse(value)].toString()=='true')?Approved_date3[int.parse(value)].toString():"N/A",)),
                                           DataCell(
                                             new Visibility(
                                               // visible: (Current_status[int.parse(value)].toString()=='A')?true:false,
                                               child: IconButton(
                                                 icon: new Icon(Icons.visibility),
                                                 color: Colors.blue,
                                                 onPressed: (){
                                                     String IDS= Ids3[int.parse(value)].toString();
                                                     Navigator.push(
                                                         context,MaterialPageRoute(builder: (_) =>
                                                         NocViewApplication(
                                                           sessionToken:sessionToken,
                                                           userGroup:userGroup,
                                                           Ids:IDS,
                                                         ))
                                                     );
                                                 },
                                               ),
                                             ),),
                                           DataCell( IconButton(
                                             icon: new Icon(Icons.file_download),
                                             color: Colors.blue,
                                             onPressed: ()async{
                                               await launch("http://13.235.67.23:8000/api/auth/new_noc_pdf/"+Ids3[int.parse(value)]+"/");
                                               // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                             },
                                           ),
                                           ),
                                           /*DataCell( new  Visibility(
                                          //  visible: (Current_status[int.parse(value)].toString()=='A')?true:false,
                                          child: IconButton(
                                            icon: new Icon(Icons.file_download),
                                            color: Colors.blue,
                                            onPressed: ()async{
                                              await launch("http://65.1.132.43:8080/api/auth/new_user_report/"+Ids[int.parse(value)]+"/");
                                              // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                            },
                                          ),
                                        ),
                                        ),*/
                                           /*DataCell(new  Visibility(
                                          visible: (Current_status3[int.parse(value)].toString()=='Accepted')?true:false,
                                          child: IconButton(
                                            icon: new Icon(Icons.qr_code_outlined),
                                            color: Colors.blue,
                                            onPressed: ()async{
                                              await launch("http://65.1.132.43:8080/api/auth/qr_code_pdf/"+Ids[int.parse(value)]+"/");
                                              // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                            },
                                          ),
                                        ),),*/
                                           //DataCell(Text((Remark3[int.parse(value)].toString()=='null')?Remark3[int.parse(value)].toString():"N/A",)),
                                           //DataCell(Text((Remark_date3[int.parse(value)].toString()!='null')?Remark_date3[int.parse(value)].toString():"N/A",)),
                                         ],
                                       )),
                                     ).toList(),
                                   )
                               )
                            )
                           )
                       )
                       );
                     }
                   }
               ),

             ],
           ),

            )
    );
  }
}

