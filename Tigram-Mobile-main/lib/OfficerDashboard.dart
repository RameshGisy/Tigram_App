import 'dart:convert';
import 'dart:io';
import 'package:Tigram/Form3Page1.dart';
import 'package:Tigram/NocViewApplication.dart';
import 'package:Tigram/SFDashboard.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:Tigram/QueryPage.dart';
import 'package:Tigram/Reports.dart';
import 'package:Tigram/ViewApplication.dart';
import 'package:Tigram/login.dart';
import 'package:flutter/foundation.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficerDashboard extends StatefulWidget {
  String sessionToken ;
  int userId;
  String userName ;
  String userEmail;
  String userGroup;
  String dropdownValue;
  List Range;
  OfficerDashboard({this.userId,this.userName,this.userEmail,this.sessionToken,this.userGroup,this.dropdownValue,this.Range});
  @override
  _OfficerDashboardState createState() => _OfficerDashboardState(userId,userName,userEmail,sessionToken,userGroup,dropdownValue,Range);
}

class _OfficerDashboardState extends State<OfficerDashboard> {
  void initState()  {
    super.initState();
    print(userId);
    pie_chart();
    PendingApp();
    ApprovedApp();
    DeemedApp();
    NocForm();
  }
  String sessionToken ;
  int userId;
  String userName ;
  String userEmail;
  String userGroup;
  String dropdownValue;
  List Range;
  double Approved=0;
  double Rejected=0;
  double Pending=0;

  _OfficerDashboardState(this.userId,this.userName,this.userEmail,this.sessionToken,this.userGroup,this.dropdownValue,this.Range);

//---------------------Pie-chart------------------
    void pie_chart() async {
    final String url = 'http://13.235.67.23:8000/api/auth/dashbord_chart';

    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    setState(() {
       Approved=responseJSON['data']['per_approved'];
       Rejected=responseJSON['data']['per_rejected'];
       Pending=responseJSON['data']['per_submitted'];
      });
  }
  List<Color> colors = [Colors.blue, Colors.red, Colors.orange ];

//------------------End--Pie--Chart--------------

String url="http://65.1.132.43:8080/api/auth/new_transit_pass_pdf/90/";



  //---------------Table ----------------------
  //---------pending-------------
  final List Ids = [];
  final List sr=[];
  final List App_no = [];
  final List App_Name = [];
  final List App_Date = [];
  final List Current_status = [];
  final List days_left_transit = [];
  final List Approved_date = [];
  final List Action = [];
  //------------
    final List reason_office=[];
    final List reason_depty_ranger_office=[];
    final List reason_range_officer=[];
    final List disapproved_reason=[];
    final List reason_division=[];
  //------------
  //------------
  final List verify_office_date=[];
  final List deputy_officer_date=[];
  final List range_officer_date=[];
  final List division_date=[];
  //final List disapproved_reason=[];
  //------------
  final List Remark = [];
  final List Remark_date = [];
  final List Tp_status = [];
  final List Tp_Issue_Date = [];
  final List Tp_Number = [];
  final List verify_range=[];
  final List depty_range_officer=[];
  final List verify_range_officer=[];
  final List division=[];
  final List tp_expiry_date=[];
  final List other_State=[];

  final List verify_deputy2=[];
  final List reason_deputy2=[];
  final List deputy2_date=[];

  final List is_form_two=[];


  final List assigned_deputy1_by_id=[];
  final List assigned_deputy2_by_id=[];

  final List log_updated_by_use=[];
  final List verify_forest1=[];
  //------------------------

  List  list1=[];
  int allApplication = 0;
//-----------Approved------------------------
  int allApplication1 = 0;
  final List Ids1 = [];
  final List sr1=[];
  final List App_no1 = [];
  final List App_Name1 = [];
  final List App_Date1 = [];
  final List Current_status1 = [];
  final List days_left_transit1 = [];
  final List Approved_date1 = [];
  final List Action1 = [];
  final List Remark1 = [];
  final List Remark_date1 = [];
  final List Tp_status1 = [];
  final List Tp_Issue_Date1 = [];
  final List Tp_Number1 = [];
  final List verify_range1=[];
  final List depty_range_officer1=[];
  final List verify_range_officer1=[];
  final List division1=[];
  final List tp_expiry_date1=[];
  //------------
  final List reason_office1=[];
  final List reason_depty_ranger_office1=[];
  final List reason_range_officer1=[];
  final List disapproved_reason1=[];
  final List reason_division1=[];
  //------------
  final List verify_office_date1=[];
  final List deputy_officer_date1=[];
  final List range_officer_date1=[];
  final List division_date1=[];

  final List other_State1=[];

  final List verify_deputy2_1=[];
  final List reason_deputy2_1=[];
  final List deputy2_date_1=[];

  final List is_form_two1=[];
  final List is_form3_1=[];


  final List assigned_deputy1_by_id1=[];
  final List assigned_deputy2_by_id1=[];
  final List log_updated_by_use1=[];
  final List verify_forest1_1=[];
  //------------------------------------------
  void PendingApp() async {
    sr.clear();
    App_no.clear();
    App_Name.clear();
    App_Date.clear();
    Current_status.clear();
    days_left_transit.clear();
    Approved_date.clear();
    Action.clear();
    Remark.clear();
    Remark_date.clear();
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
    verify_office_date.clear();
    deputy_officer_date.clear();
    range_officer_date.clear();
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
    print("Pending Application");
    final String url = 'http://13.235.67.23:8000/api/auth/PendingListViewApplication';
    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    List list = responseJSON["data"];
    setState(() {
      allApplication = list.length;
    });
    for (var i = 0; i < allApplication; i++) {
      sr.add(i.toString());
      Ids.add(list[i]['id'].toString());
      App_no.add(list[i]['application_no']);
      App_Name.add(list[i]['name'].toString());
      App_Date.add(list[i]['created_date'].toString());
      Current_status.add(list[i]['application_status'].toString());
      days_left_transit.add(list[i]['6'].toString());
      Approved_date.add(list[i]['tp_expiry_status'].toString());
      Action.add(list[i][''].toString());
      Remark.add(list[i]['disapproved_reason'].toString());
      Remark_date.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number.add(list[i]['transit_pass_id'].toString());
      verify_range.add(list[i]['verify_office']);
      depty_range_officer.add(list[i]['depty_range_officer']);
      verify_range_officer.add(list[i]['verify_range_officer']);
      division.add(list[i]['division_officer']);
      tp_expiry_date.add(list[i]['tp_expiry_date']);
      reason_office.add(list[i]['reason_office']);
      reason_depty_ranger_office.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer.add(list[i]['reason_range_officer']);
      reason_division.add(list[i]['reason_division_officer']);
      disapproved_reason.add(list[i]['disapproved_reason']);

      verify_office_date.add(list[i]['verify_office_date']);
      deputy_officer_date.add(list[i]['deputy_officer_date']);
      range_officer_date.add(list[i]['range_officer_date']);
      division_date.add(list[i]['division_officer_date']);
      // Remark.add(list[i]['transit_pass_created_date']);
      other_State.add(list[i]['other_state']);
      verify_deputy2.add(list[i]['verify_deputy2']);
      reason_deputy2.add(list[i]['reason_deputy2']);
      deputy2_date.add(list[i]['deputy2_date']);
      is_form_two.add(list[i]['is_form_two']);
      assigned_deputy1_by_id.add(list[i]['assigned_deputy1_name']);
      assigned_deputy2_by_id.add(list[i]['assigned_deputy2_name']);
      log_updated_by_use.add(list[i]['log_updated_by_user']);
      verify_forest1.add(list[i]['verify_forest1']);
    }
    print("--------------- Pending Application----------------");
    print("---------------log----------");
    print(log_updated_by_use);
    print(Ids+App_no+App_Date+App_Name+Current_status);
  }
//-----------Approved-------------
  void ApprovedApp() async {
    sr1.clear();
    App_no1.clear();
    App_Name1.clear();
    App_Date1.clear();
    Current_status1.clear();
    days_left_transit1.clear();
    Approved_date1.clear();
    Action1.clear();
    Remark1.clear();
    Remark_date1.clear();
    Tp_Issue_Date1.clear();
    Tp_Number1.clear();
    verify_range1.clear();
    depty_range_officer1.clear();
    verify_range_officer1.clear();
    tp_expiry_date1.clear();
    reason_office1.clear();
    reason_depty_ranger_office1.clear();
    reason_range_officer1.clear();
    disapproved_reason1.clear();
    verify_office_date1.clear();
    deputy_officer_date1.clear();
    range_officer_date1.clear();
    division1.clear();
    reason_division1.clear();
    division_date1.clear();
    other_State1.clear();
    verify_deputy2_1.clear();
    reason_deputy2_1.clear();
    deputy2_date_1.clear();
    is_form_two1.clear();
    assigned_deputy1_by_id1.clear();
    assigned_deputy2_by_id1.clear();
    log_updated_by_use1.clear();
    verify_forest1_1.clear();
    print("Approved Application");
    final String url = 'http://13.235.67.23:8000/api/auth/ApprovedListViewApplication';
    var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    List list = responseJSON["data"];

    setState(() {
      allApplication1 = list.length;
    });
    print(list.length);
    for (var i = 0; i < allApplication1; i++) {
      sr1.add(i.toString());
      Ids1.add(list[i]['id'].toString());
      App_no1.add(list[i]['application_no']);
      App_Name1.add(list[i]['name'].toString());
      App_Date1.add(list[i]['created_date'].toString());
      Current_status1.add(list[i]['application_status'].toString());
      days_left_transit1.add(list[i]['application_status'].toString());
      Approved_date1.add(list[i]['verify_office_date'].toString());
      Action1.add(list[i][''].toString());
      Remark1.add(list[i]['reason_office'].toString());
      Remark_date1.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date1.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number1.add(list[i]['transit_pass_id'].toString());
      verify_range1.add(list[i]['verify_office']);
      depty_range_officer1.add(list[i]['depty_range_officer']);
      verify_range_officer1.add(list[i]['verify_range_officer']);
      division1.add(list[i]['division_officer']);
      tp_expiry_date1.add(list[i]['tp_expiry_date']);
      reason_office1.add(list[i]['reason_office']);
      reason_depty_ranger_office1.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer1.add(list[i]['reason_range_officer']);
      reason_division1.add(list[i]['reason_division_officer']);
      disapproved_reason1.add(list[i]['disapproved_reason']);
      verify_office_date1.add(list[i]['verify_office_date']);
      deputy_officer_date1.add(list[i]['deputy_officer_date']);
      range_officer_date1.add(list[i]['range_officer_date']);
      division_date1.add(list[i]['division_officer_date']);
      // Remark.add(list[i]['transit_pass_created_date']);
      other_State1.add(list[i]['other_state']);

      verify_deputy2_1.add(list[i]['verify_deputy2']);
      reason_deputy2_1.add(list[i]['reason_deputy2']);
      deputy2_date_1.add(list[i]['deputy2_date']);

      is_form_two1.add(list[i]['is_form_two']);
      is_form3_1.add(list[i]['is_form3']);

      assigned_deputy1_by_id1.add(list[i]['assigned_deputy1_name']);
      assigned_deputy2_by_id1.add(list[i]['assigned_deputy2_name']);
      log_updated_by_use1.add(list[i]['log_updated_by_user']);
      verify_forest1_1.add(list[i]['verify_forest1']);
    }
    print("--------------- Approved Application ----------------");
    print(Ids+App_no+App_Date+App_Name+Current_status);
  }

//--end-Approve-------------------
  //---------------------------Deemed-Approve-----------------------------
      //----------------------
      int allApplication2=0;
      final List Ids2 = [];
      final List sr2=[];
      final List App_no2 = [];
      final List App_Name2 = [];
      final List App_Date2 = [];
      final List Current_status2 = [];
      final List days_left_transit2 = [];
      final List Approved_date2 = [];
      final List Action2 = [];
      final List Remark2 = [];
      final List Remark_date2 = [];
      final List Tp_status2 = [];
      final List Tp_Issue_Date2 = [];
      final List Tp_Number2 = [];
       final List DeemedApproved2 = [];

      final List reason_office2=[];
      final List reason_depty_ranger_office2=[];
      final List reason_range_officer2=[];
      final List disapproved_reason2=[];
      final List reason_division2=[];
      //------------
      final List verify_office_date2=[];
      final List deputy_officer_date2=[];
      final List range_officer_date2=[];
      final List division_date2=[];

      final List other_State2=[];
      final List division2=[];




      //---------------------
      void DeemedApp() async{
        sr2.clear();
        print("Deemed Application");
        final String url = 'http://13.235.67.23:8000/api/auth/DeemedApprovedList';
        var response = await http.get(url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': "token $sessionToken"
            });
        Map<String, dynamic> responseJSON = json.decode(response.body);
        print(responseJSON);
        List list = responseJSON["data"];
        setState(() {
          allApplication2 = list.length;
        });
        for (var i = 0; i < allApplication2; i++) {
          sr2.add(i.toString());
          Ids2.add(list[i]['id'].toString());
          App_no2.add(list[i]['application_no']);
          App_Name2.add(list[i]['name'].toString());
          App_Date2.add(list[i]['created_date'].toString());
          Current_status2.add(list[i]['application_status'].toString());
          Approved_date2.add(list[i]['transit_pass_created_date'].toString());
          Action2.add(list[i][''].toString());
          Remark2.add(list[i]['reason_office']);
          Remark_date2.add(list[i]['verify_office_date']);
          Tp_Issue_Date2.add(list[i]['transit_pass_created_date']);
          Tp_Number2.add(list[i]['transit_pass_id'].toString());
          DeemedApproved2.add(list[i]['deemed_approval']);

          reason_office2.add(list[i]['reason_office']);
          reason_depty_ranger_office2.add(list[i]['reason_depty_ranger_office']);
          reason_range_officer2.add(list[i]['reason_range_officer']);
          disapproved_reason2.add(list[i]['disapproved_reason']);
          verify_office_date2.add(list[i]['verify_office_date']);
          deputy_officer_date2.add(list[i]['deputy_officer_date']);
          range_officer_date2.add(list[i]['range_officer_date']);

          division2.add(list[i]['division_officer']);
          reason_division2.add(list[i]['reason_division_officer']);
          division_date2.add(list[i]['division_officer_date']);
          // Remark.add(list[i]['transit_pass_created_date']);
          other_State2.add(list[i]['other_state']);
        }
        print("---------------Deemed Application----------------");
        print(Ids2+App_no2+App_Date2+App_Name2+Current_status2);
      }

  //---------------------------End-Deemed-Approve-------------------------
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
      final String url = 'http://13.235.67.23:8000/api/auth/NocListApplication/';
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
        // Remark.add(list[i]['transit_pass_created_date']);
      }
      print("---------------Noc-Application----------------");
      print(Ids3+App_no3+App_Date3+App_Name3+Current_status3);
    }

  //-----------------------End-Noc-Form-----------------------------------
  //---------------End---Table-----------------
  int _radioValue = 0;
  bool flag= true;
  var tab=0;
  @override
  void _handleRadioValueChange(int value) async {
    pie_chart();
    setState(() {
      _radioValue = value;
      if (_radioValue == 0) {

        setState(() {
          tab=0;
          flag=true;
          pie_chart();
        });
      } else if (_radioValue == 1) {
        setState(() {
          tab=1;
          flag=false;
          PendingApp();
        });
      }
      else if(_radioValue == 2){
        setState(() {
          tab=2;
          ApprovedApp();
        });
      }
      else if(_radioValue == 3){
        setState(() {
          tab=3;
          DeemedApp();
        });
      }
      else if(_radioValue == 4){
        setState(() {
          tab=4;
          NocForm();
        });
      }
    });
  }
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
      print("-------dhuf--");
      print(log_updated_by_user);
      if(log_updated_by_user==true){
        if(AppStatus=='R'){
          return 'Rejected by Forest Range Officer';
        }else{
          return 'Wood logs details have been\n be entered for Stage 2. Deputy Range Officer\n Approval Pending for Stage 2';
        }
      } else{
        if(AppStatus=='R'){
          return 'Rejected by Forest Range Officer(Trees Cutting Approval)';
        }else{
          return 'Approved by Forest Range Officer\n for cutting of Trees. Wood logs\n details to be entered.';
        }
      }
    }
    else if(deputy2==true){
        if(AppStatus=='R'){
          return 'Rejected  by Deputy Range Officer at Stage 1';
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
      if(assign_deputy2!=null ){
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
 bool getForm(bool isform,bool other_State,bool division_officer,bool verify_range_officer,String App_status){
    bool can_apply3 =false;
    if (App_status =='A'){
      return can_apply3;
    }
    if(isform==true){
      if(other_State == true){
        if(division_officer==true && App_status !='R'){
          can_apply3=true;
          return can_apply3;
        }
        else{
          return can_apply3;
        }
      }
      else{
        if(verify_range_officer==true && App_status !='R'){
          can_apply3=true;
          return can_apply3;
        }
        else{
          return can_apply3;
        }
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
  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        title: Text(" Officer Dashboard"),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin:const EdgeInsets.only(top: 8,bottom: 8),
               child:ToggleSwitch(
               minWidth: MediaQuery.of(context).size.width,
                initialLabelIndex: _radioValue,
                cornerRadius: 8.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey[200],
                inactiveFgColor: Colors.blue,
                labels: ['Report','Pending','Approved/Rejected','Deemed Approved','Noc Form'],
                activeBgColors: [Colors.blueAccent,Colors.orange,Colors.green,Colors.cyan,Colors.blue],
                onToggle: _handleRadioValueChange,
              ),
            ),

            LayoutBuilder(
                builder: (context, constraints) {
                  if(tab==0) {
                    return Container(
                        width:  MediaQuery.of(context).size.width,
                        //height:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                             // offset: Offset(2.0, 2.0),
                              // shadow direction: bottom right
                            )
                          ],
                        ),
                        margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                        padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                        child: Column(children: <Widget>[
                          PieChart(
                            dataMap:{"Approved": Approved,"Rejected":Rejected,"Pending":Pending},
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 20,
                            chartRadius: MediaQuery.of(context).size.width*0.50,
                            initialAngleInDegree: 0,
                            chartType: ChartType.disc ,
                            colorList: [Colors.blue, Colors.red, Colors.orange ],
                            ringStrokeWidth: MediaQuery.of(context).size.width,
                            centerText: "",
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.left,
                              showLegends: true,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                          FlatButton.icon(
                            icon: Icon(Icons.file_download),
                            onPressed: () async {
                              await launch("http://13.235.67.23:8000/api/auth/summary_report/");
                            },
                            label: Text("Download"),
                          ),
                        ],
                        )
                    );;
                  } else if(tab == 1) {
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
                                      child:DataTable(
                                        columnSpacing: 20,
                                        dividerThickness: 2,
                                        headingRowColor:
                                        MaterialStateColor.resolveWith((states) => Colors.orange),
                                        columns: [
                                          DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                          DataColumn(label: Text('Application\n       No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Application\n      Name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Application\n      Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Current Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Deputy Officer \n Assignment status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Notified / Non-Notified\n     Villages',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Days  left\nfor Approval',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Approval\n    Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Action',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Download\n      Tp',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Download\n Report',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('QR Code',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Remark',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Remark\n  Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                        ],
                                        rows:
                                        sr// Loops through dataColumnText, each iteration assigning the value to element
                                            .map(
                                          ((value) => DataRow(
                                            cells: <DataCell>[
                                              DataCell((Text((int.parse(value)+1).toString()))), //Extracting from Map element the value
                                              DataCell(Text(App_no[int.parse(value)].toString())),
                                              DataCell(Text(App_Name[int.parse(value)].toString())),
                                              DataCell(Text(App_Date[int.parse(value)].toString())),
                                              DataCell(Text(OfficerStatus(division[int.parse(value)],verify_range[int.parse(value)], depty_range_officer[int.parse(value)], verify_range_officer[int.parse(value)],Current_status[int.parse(value)].toString(),other_State[int.parse(value)],verify_deputy2[int.parse(value)],log_updated_by_use[int.parse(value)],verify_forest1[int.parse(value)]).toString())),
                                              DataCell(Text(AssignOfficer(is_form_two[int.parse(value)], assigned_deputy2_by_id[int.parse(value)], assigned_deputy1_by_id[int.parse(value)], log_updated_by_use[int.parse(value)])==null?"N/A":AssignOfficer(is_form_two[int.parse(value)], assigned_deputy2_by_id[int.parse(value)], assigned_deputy1_by_id[int.parse(value)], log_updated_by_use[int.parse(value)]).toString())),
                                              DataCell(Text(is_form_two[int.parse(value)]==true?"Notified":"Non-Notified")),
                                              DataCell(Text(Tp_Number[int.parse(value)].toString()=='0'?"N/A":daysBetween(DateTime.parse(Tp_Issue_Date[int.parse(value)].toString())).toString())),
                                              DataCell(Text((Tp_Number[int.parse(value)].toString()=='0'?"N/A":Approved_date[int.parse(value)]!=null?Approved_date[int.parse(value)].toString():"N/A"))),
                                              DataCell(
                                                new Visibility(
                                                 visible: true,
                                                  child: IconButton(
                                                    icon: new Icon(Icons.visibility),
                                                    color: Colors.blue,
                                                    onPressed: (){
                                                      if(userGroup== userGroup){
                                                        String IDS= Ids[int.parse(value)].toString();
                                                        Navigator.push(
                                                            context,MaterialPageRoute(builder: (_) =>
                                                            ViewApplication(
                                                              sessionToken:sessionToken,
                                                              userGroup:userGroup,
                                                              userId:userId,
                                                              Ids:IDS,
                                                              Range:Range,
                                                            ))
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),),
                                              DataCell(new  Visibility(
                                                visible: (Current_status[int.parse(value)].toString()=='A')?true:false,
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
                                              DataCell( IconButton(
                                                        icon: new Icon(Icons.file_download),
                                                  color: Colors.blue,
                                                        onPressed: ()async{
                                                          await launch("http://13.235.67.23:8000/api/auth/new_user_report/"+Ids[int.parse(value)]+"/");
                                                          // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                        },
                                                ),
                                              ),
                                              DataCell(new  Visibility(
                                                visible: (Current_status[int.parse(value)].toString()=='A')?true:false,
                                                child: IconButton(
                                                  icon: new Icon(Icons.qr_code_outlined),
                                                  color: Colors.blue,
                                                  onPressed: ()async{
                                                    await launch("http://13.235.67.23:8000/api/auth/qr_code_pdf/"+Ids[int.parse(value)]+"/");
                                                    // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                  },
                                                ),
                                              ),),
                                              DataCell(Text(OfficerRemark(Current_status[int.parse(value)], disapproved_reason[int.parse(value)],reason_division[int.parse(value)], reason_range_officer[int.parse(value)], reason_depty_ranger_office[int.parse(value)], reason_office[int.parse(value)]).toString())),
                                              DataCell(Text(OfficerDate(Current_status[int.parse(value)],verify_office_date[int.parse(value)] ,division_date[int.parse(value)],range_officer_date[int.parse(value)], deputy_officer_date[int.parse(value)], verify_office_date[int.parse(value)]).toString())),
                                            ],
                                          )),
                                        ).toList(),
                                      )
                          )
                        )
                        )
                    )
                    );
                  }else if(tab==2){
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.79,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                             // offset: Offset(2.0, 2.0,), // shadow direction: bottom right
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
                                        child:DataTable(
                                          columnSpacing: 30,
                                          dividerThickness: 2,
                                          headingRowColor:
                                          MaterialStateColor.resolveWith((states) => Colors.green),
                                          columns: [
                                            DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                            DataColumn(label: Text('Application\n       No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                            DataColumn(label: Text('Application\n     Name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Application\n      Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Current Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Deputy Officer \n Assignment status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Notified / Non-Notified\n     Villages',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Approved\n     Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Action',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Download\n       Tp',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Download\n  Report',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('QR Code',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Remark',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(label: Text('Remark\n  Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                            DataColumn(
                                                label:Visibility(
                                                  visible:  userGroup=='forest range officer'?true:false,
                                                  child: Text('FORM - III',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                                ) )),
                                          ],
                                          rows:
                                          sr1// Loops through dataColumnText, each iteration assigning the value to element
                                              .map(
                                            ((value) => DataRow(
                                              cells: <DataCell>[
                                                DataCell((Text((int.parse(value)+1).toString()))), //Extracting from Map element the value
                                                DataCell(Text(App_no1[int.parse(value)].toString())),
                                                DataCell(Text(App_Name1[int.parse(value)].toString())),
                                                DataCell(Text(App_Date1[int.parse(value)].toString())),
                                                DataCell(Text(OfficerStatus(division1[int.parse(value)],verify_range1[int.parse(value)], depty_range_officer1[int.parse(value)], verify_range_officer1[int.parse(value)],Current_status1[int.parse(value)].toString(),other_State1[int.parse(value)],verify_deputy2_1[int.parse(value)],log_updated_by_use1[int.parse(value)],verify_forest1_1[int.parse(value)]).toString())),
                                                DataCell(Text(AssignOfficer(is_form_two1[int.parse(value)], assigned_deputy2_by_id1[int.parse(value)], assigned_deputy1_by_id1[int.parse(value)], log_updated_by_use1[int.parse(value)])??"N/A")),
                                                DataCell(Text(is_form_two1[int.parse(value)]==true?"   Notified  ":"  Non-Notified  ")),
                                                DataCell(Text(Tp_Number1[int.parse(value)].toString().length=='0'?"N/A":Approved_date1[int.parse(value)].toString()!='null'?Approved_date1[int.parse(value)].toString():"N/A")),
                                                DataCell(
                                                  new Visibility(
                                                   // visible: (Current_status1[int.parse(value)].toString()=='A')?true:false,
                                                    visible: true,
                                                    child: IconButton(
                                                      icon: new Icon(Icons.visibility),
                                                      color: Colors.blue,
                                                      onPressed: (){
                                                        if(userGroup== userGroup){
                                                          String IDS= Ids1[int.parse(value)].toString();
                                                          Navigator.push(
                                                              context,MaterialPageRoute(builder: (_) =>
                                                              ViewApplication(
                                                                sessionToken:sessionToken,
                                                                userGroup:userGroup,
                                                                userId:userId,
                                                                Ids:IDS,
                                                                Range:Range,
                                                              ))
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),),
                                                DataCell(new  Visibility(
                                                  visible: (Current_status1[int.parse(value)].toString()=='A')?true:false,
                                                  child: IconButton(
                                                    icon: new Icon(Icons.file_download),
                                                    color: Colors.blue,
                                                    onPressed: ()async{
                                                      await launch("http://13.235.67.23:8000/api/auth/new_transit_pass_pdf/"+Ids1[int.parse(value)]+"/");
                                                      // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                    },
                                                  ),
                                                ),
                                                ),
                                                DataCell(IconButton(
                                                    icon: new Icon(Icons.file_download),
                                                    color: Colors.blue,
                                                    onPressed: ()async{
                                                      await launch("http://13.235.67.23:8000/api/auth/new_user_report/"+Ids1[int.parse(value)]+"/");
                                                      // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                    },
                                                ),
                                                ),
                                                DataCell(new  Visibility(
                                                   visible: (Current_status1[int.parse(value)].toString()=='A')?true:false,
                                                  child: IconButton(
                                                    icon: new Icon(Icons.qr_code_outlined),
                                                    color: Colors.blue,
                                                    onPressed: ()async{
                                                      await launch("http://13.235.67.23:8000/api/auth/qr_code_pdf/"+Ids1[int.parse(value)]+"/");
                                                      // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                    },
                                                  ),
                                                ),
                                                ),
                                                DataCell(Text(OfficerRemark(Current_status1[int.parse(value)].toString(), disapproved_reason1[int.parse(value)].toString(),reason_division1[int.parse(value)] ,reason_range_officer1[int.parse(value)], reason_depty_ranger_office1[int.parse(value)], reason_office1[int.parse(value)]).toString())),
                                                DataCell(Text(OfficerDate(Current_status1[int.parse(value)],verify_office_date1[int.parse(value)] ,division_date1[int.parse(value)], range_officer_date1[int.parse(value)], deputy_officer_date1[int.parse(value)], verify_office_date1[int.parse(value)]).toString())),
                                                DataCell(new  Visibility(
                                                  visible: (getForm(is_form_two1[int.parse(value)], other_State1[int.parse(value)], division1[int.parse(value)], verify_range_officer1[int.parse(value)], Current_status1[int.parse(value)])==true && is_form3_1[int.parse(value)] == false)?true:false,
                                                  child: IconButton(
                                                    icon: new Icon(Icons.file_copy_outlined),
                                                    color: Colors.blue,
                                                    onPressed: ()async{
                                                      print("form 3");
                                                      print(getForm(is_form3_1[int.parse(value)], other_State1[int.parse(value)], division1[int.parse(value)], verify_range_officer1[int.parse(value)], Current_status1[int.parse(value)]));
                                                      Navigator.push(
                                                          context,MaterialPageRoute(builder: (_) =>
                                                          Form3Page1(
                                                            sessionToken:sessionToken,
                                                            Ids1:Ids1[int.parse(value)].toString(),
                                                          ))
                                                      );
                                                      // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                    },
                                                  ),
                                                ),
                                                ),
                                              ],
                                            )),
                                          ).toList(),
                                        )
                            )
                        )
                            )
                        )
                    );
                  } else if(tab == 3) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.79,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                             // offset: Offset(2.0, 2.0), // shadow direction: bottom right
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
                                      child:DataTable(
                                        sortColumnIndex: _currentSortColumn,
                                        sortAscending: _isAscending,
                                        columnSpacing: 20,
                                        dividerThickness: 2,
                                        headingRowColor:
                                        MaterialStateColor.resolveWith((states) => Colors.cyan),
                                        columns: [
                                          DataColumn(label: Text('Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                          DataColumn(label: Text('Application\n       No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Application\n      Name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Application\n      Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Current Status',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Approved\n    Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Action',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Download\n      Tp',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Download\n Report',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('QR Code',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Remark',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                          DataColumn(label: Text('Remark\n  Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                        ],
                                        rows:
                                        sr2// Loops through dataColumnText, each iteration assigning the value to element
                                            .map(
                                          ((value) => DataRow(
                                            cells: <DataCell>[
                                              DataCell((Text((int.parse(value)+1).toString()))), //Extracting from Map element the value
                                              DataCell(Text(App_no2[int.parse(value)].toString())),
                                              DataCell(Text(App_Name2[int.parse(value)].toString())),
                                              DataCell(Text(App_Date2[int.parse(value)].toString())),
                                              DataCell(Text(DeemedApproved2[int.parse(value)]==true?"Deemed Approved":'')),
                                              DataCell(Text(Approved_date2[int.parse(value)].toString())),
                                              DataCell(
                                                new Visibility(
                                                  // visible: (Current_status[int.parse(value)].toString()=='A')?true:false,
                                                  child: IconButton(
                                                    icon: new Icon(Icons.visibility),
                                                    color: Colors.blue,
                                                    onPressed: (){
                                                      if(userGroup== userGroup){
                                                        String IDS= Ids2[int.parse(value)].toString();
                                                        Navigator.push(
                                                            context,MaterialPageRoute(builder: (_) =>
                                                            ViewApplication(
                                                              sessionToken:sessionToken,
                                                              userGroup:userGroup,
                                                              userId:userId,
                                                              Ids:IDS,
                                                            ))
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),),
                                              DataCell(new  Visibility(
                                                visible: (Current_status2[int.parse(value)].toString()=='A')?true:false,
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
                                              DataCell( IconButton(
                                                  icon: new Icon(Icons.file_download),
                                                  color: Colors.blue,
                                                  onPressed: ()async{
                                                    await launch("http://13.235.67.23:8000/api/auth/new_user_report/"+Ids2[int.parse(value)]+"/");
                                                    // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                  },
                                                ),
                                              ),
                                              DataCell(new  Visibility(
                                                visible: (Current_status2[int.parse(value)].toString()=='A')?true:false,
                                                child: IconButton(
                                                  icon: new Icon(Icons.qr_code_outlined),
                                                  color: Colors.blue,
                                                  onPressed: ()async{
                                                    await launch("http://13.235.67.23:8000/api/auth/qr_code_pdf/"+Ids[int.parse(value)]+"/");
                                                    // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                  },
                                                ),
                                              ),),
                                              DataCell(Text(OfficerRemark(Current_status2[int.parse(value)].toString(), disapproved_reason2[int.parse(value)].toString(),reason_division2[int.parse(value)], reason_range_officer2[int.parse(value)], reason_depty_ranger_office2[int.parse(value)], reason_office2[int.parse(value)]))),
                                              DataCell(Text(OfficerDate(Current_status2[int.parse(value)],verify_office_date2[int.parse(value)] ,division_date2[int.parse(value)],range_officer_date2[int.parse(value)], deputy_officer_date2[int.parse(value)], verify_office_date2[int.parse(value)]))),
                                            ],
                                          )),
                                        ).toList(),
                                      )
                            )
                        )
                            )
                        )
                    );
                  }else if(tab == 4) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.79,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                            //  offset: Offset(2.0, 2.0), // shadow direction: bottom right
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
                                        child:DataTable(
                                          sortColumnIndex: _currentSortColumn,
                                          sortAscending: _isAscending,
                                          columnSpacing: 20,
                                          dividerThickness: 2,
                                          headingRowColor:
                                          MaterialStateColor.resolveWith((states) => Colors.blue),
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
                                                 IconButton(
                                                      icon: new Icon(Icons.visibility),
                                                      color: Colors.blue,
                                                      onPressed: (){
                                                        if(userGroup== userGroup){
                                                          String IDS= Ids3[int.parse(value)].toString();
                                                          Navigator.push(
                                                              context,MaterialPageRoute(builder: (_) =>
                                                              NocViewApplication(
                                                                sessionToken:sessionToken,
                                                                userGroup:userGroup,
                                                                Ids:IDS,
                                                              ))
                                                          );
                                                        }
                                                      },
                                                  ),
                                                ),
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
      ),
      drawer: Container(
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),),
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
                    leading: Icon(Icons.receipt_long_outlined, color: Colors.black,size: 25,),
                    title: Text('Reports',style: TextStyle(color: Colors.black,fontSize: 20),),
                    onTap: (){
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => Reports(sessionToken:sessionToken))
                      );
                    }
                ),
                ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.black,size: 25,),
                    title: Text('Dashboard',style: TextStyle(color: Colors.black,fontSize: 20),),
                    onTap: (){
                      Navigator.push(
                          context,MaterialPageRoute(builder: (_) => OfficerDashboard(
                        sessionToken: sessionToken,
                        userName: userName,
                        userEmail: userEmail,
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
