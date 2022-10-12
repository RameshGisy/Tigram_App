import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:Tigram/CheckPassStatus.dart';
import 'package:Tigram/Form1.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SFViewReports extends StatefulWidget {
  String sessionToken;
  String SelectedRange;
  String SelectedRange1;
  int R1;
  int R2;
  int R3;
  int R4;
  int R5;
  int R6;
  int R7;
  int R8;
  int R9;
  int R10;
  SFViewReports({this.sessionToken,this.SelectedRange,this.SelectedRange1,this.R1,this.R2,this.R3,this.R4,this.R5,this.R6,this.R7,this.R8,this.R9,this.R10});
  @override
  _SFViewReportsState createState() => _SFViewReportsState(sessionToken,SelectedRange,SelectedRange1,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10);
}

class _SFViewReportsState extends State<SFViewReports> {
  String sessionToken;
  String SelectedRange;
  String SelectedRange1;
  int R1;
  int R2;
  int R3;
  int R4;
  int R5;
  int R6;
  int R7;
  int R8;
  int R9;
  int R10;
  _SFViewReportsState(this.sessionToken,this.SelectedRange,this.SelectedRange1,this.R1,this.R2,this.R3,this.R4,this.R5,this.R6,this.R7,this.R8,this.R9,this.R10);

  bool flag= true;
  var tab=0;
  int _radioValue = 0;
  String toggle;


 /* List<Employee> employees = <Employee>[];
  EmployeeDataSource employeeDataSource;

  List<Status> status = <Status>[];
  StatusDataSource statusDataSource;*/

  List<table1> Tabel1 = <table1>[];
  Table1DataSource table1DataSource;

  List<table2> Tabel2 = <table2>[];
  Table2DataSource table2DataSource;

  List<table3> Tabel3 = <table3>[];
  Table3DataSource table3DataSource;

  List<table4> Tabel4 = <table4>[];
  Table4DataSource table4DataSource;

  List<table5> Tabel5 = <table5>[];
  Table5DataSource table5DataSource;

  List<table6> Tabel6 = <table6>[];
  Table6DataSource table6DataSource;

  List<table7> Tabel7 = <table7>[];
  Table7DataSource table7DataSource;

  List<table8> Tabel8 = <table8>[];
  Table8DataSource table8DataSource;

  List<table9> Tabel9 = <table9>[];
  Table9DataSource table9DataSource;

  List<table10> Tabel10 = <table10>[];
  Table10DataSource table10DataSource;

  List<TreesData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    pie_chart();

    Table_1();
    Tabel1 = getTable1Data();
    table1DataSource = Table1DataSource(Table1Data:Tabel1);

    Table_2();
    Tabel2 = getTable2Data();
    table2DataSource = Table2DataSource(Table2Data:Tabel2);

    Table_3();
    Tabel3 = getTable3Data();
    table3DataSource = Table3DataSource(Table3Data:Tabel3);

    Table_4();
    Tabel4 = getTable4Data();
    table4DataSource = Table4DataSource(Table4Data:Tabel4);

    Table_5();
    Tabel5 = getTable5Data();
    table5DataSource = Table5DataSource(Table5Data:Tabel5);

    Table_6();
    Tabel6 = getTable6Data();
    table6DataSource = Table6DataSource(Table6Data:Tabel6);

    Table_7();
    Tabel7 = getTable7Data();
    table7DataSource = Table7DataSource(Table7Data:Tabel7);

    Table_8();
    Tabel8 = getTable8Data();
    table8DataSource = Table8DataSource(Table8Data:Tabel8);

    Table_9();
    Tabel9 = getTable9Data();
    table9DataSource = Table9DataSource(Table9Data:Tabel9);

    Table_10();
    Tabel10 = getTable10Data();
    table10DataSource = Table10DataSource(Table10Data:Tabel10);

    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  //---------------------------Table 1----------------------------------------
  //-----------------------variable---------------------------------------
  int t1=0;
  List t1_sr=[];
  List t1_Date=[];
  List t1_Received=[];
  List t1_Approved=[];
  List t1_Rejected=[];
  //-----------------------End-Variable-----------------------------------
  Table_1()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_one/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    List responseJSON = json.decode(response.body);
    print("---------------Table 1-------------------");
    print(responseJSON);
    setState(() {
      t1 = responseJSON.length;

      for(int i=0;i<t1;i++){
        t1_sr.add(i);
        t1_Date.add(responseJSON[i]["created_date"].toString());
        t1_Received.add(responseJSON[i]["no_of_received"].toString());
        t1_Approved.add(responseJSON[i]["no_of_approved"].toString());
        t1_Received.add(responseJSON[i]["no_of_rejected"].toString());
      }

      for (var i = 0; i < t1; i++) {
        Tabel1 = getTable1Data();
      }
      table1DataSource = Table1DataSource(Table1Data:Tabel1);

    });
    print("-----------------------Output T1--------------------");
    print(t1_sr+t1_Date+t1_Received+t1_Approved+t1_Rejected);
  }
  List<table1> getTable1Data() {
    //print(Ids.toString()+App_no.toString()+App_Date.toString()+App_Status.toString()+Current_status.toString());
    List <table1> t1_lists = new List();
    for(int i=0;i<t1;i++){
      t1_lists.add(table1((i+1).toString(), t1_Date[i].toString(), t1_Received[i].toString(), t1_Approved[i].toString(),t1_Received[i].toString()));
    }
    return t1_lists;
  }
  //--------------------------End--Table 1------------------------------------

  //---------------------------Table 2-----------------------------------------
  //----------------Variable-----------------------------------------
  int t2=0;
  List t2_sr=[];
  List t2_Reason=[];
  List t2_percentage=[];
  List t2_lists=[];
  Map<String, dynamic> T2_P;
  Map<String, double> T2_C;
  //----------------End-Variable------------------------------------
  Table_2()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_two/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 2-------------------");
    print(responseJSON);
    setState(() {
      T2_P=responseJSON;
      T2_C=Map<String, double>.from(T2_P);
      t2=responseJSON.length;
      for (var i = 0; i < t2; i++) {
        t2_sr.add(i + 1);
      }
      responseJSON.forEach((key, value) {
        print('Key = $key : Value = $value');
        //t2_Reason=[0];
        //t2_percentage=[0];
        t2_Reason.add('$key');
        t2_percentage.add('$value');
      });
      for (var i = 0; i < t2; i++) {
        Tabel2 = getTable2Data();
      }
      table2DataSource = Table2DataSource(Table2Data:Tabel2);
    });
    print("-----table2-------");

    // print(t2_Reason+t2_percentage);
  }

  List<table2> getTable2Data() {
    //print(Ids.toString()+App_no.toString()+App_Date.toString()+App_Status.toString()+Current_status.toString());
    print(t2);
    print(t2_sr);
    print(t2_Reason);
    print(t2_percentage);
    List <table2> t2_lists = new List();
    for(int i=0;i<t2;i++) {

      t2_lists.add(table2((i+1).toString(),t2_Reason[i].toString(),t2_percentage[i].toString()));
    }
    print(t2_lists);
    return t2_lists;

  }
  //----------------------------End--Table 2-----------------------------------

  //---------------------------Table 3-----------------------------------------
  //-----------------------variable--------------------------------------
  int t3=0;
  List t3_sr=[];
  List t3_Date=[];
  List t3_Species=[];
  List t3_Transported=[];
  List t3_No_of_TreeTrans=[];
  List t3_list=[];
  //--Graph
  int g3=0;
  List g3_list=[];
  List <String> X_axis=[];
  List <String> Y_axis=[];
  List <String> total_data=[];
  //--end-Graph
  //-----------------------End-Variable---------------------------------
  Table_3()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_three/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 3-------------------");
    print(responseJSON);
    t3_list = responseJSON["tabel"];
    g3_list = responseJSON["graph"];
    setState(() {
      t3=t3_list.length;
      g3=g3_list.length;
      for(int i=0;i<t3;i++){
        t3_sr.add(i);
        t3_Date.add(t3_list[i]['appform__created_date'].toString());
        t3_Species.add(t3_list[i]['species_of_tree'].toString());
        t3_Transported.add(t3_list[i]['volume_sum'].toString());
        t3_No_of_TreeTrans.add(t3_list[i]['no_of_trees'].toString());
      }
      for(int i=0;i<g3;i++){
        X_axis.add(g3_list[i]['created_date'].toString());
        Y_axis.add(g3_list[i]['as_float'].toString());
        total_data.add(g3_list[i]['total_trees'].toString());
      }
      for (var i = 0; i < t3; i++) {
        Tabel3 = getTable3Data();
      }
      table3DataSource = Table3DataSource(Table3Data:Tabel3);
      for (var i = 0; i < g3; i++) {
        _chartData = getChartData();
      }

      _tooltipBehavior = TooltipBehavior(enable: true);


    });
    print("-----------------------Output T3--------------------");
    print(t3_sr+t3_Date+t3_Species+t3_Transported+t3_No_of_TreeTrans);
    print(X_axis+Y_axis+total_data);
  }
  List<table3> getTable3Data() {
    //print(Ids.toString()+App_no.toString()+App_Date.toString()+App_Status.toString()+Current_status.toString());
    List <table3> t3_lists = new List();
    for(int i=0;i<t3;i++){
      t3_lists.add(table3((i+1).toString(), t3_Date[i].toString(), t3_Species[i].toString(), t3_Transported[i].toString(),t3_No_of_TreeTrans[i].toString()));
    }
    return t3_lists;
  }
  //----------------------------End--Table 3-----------------------------------

  //---------------------------Table 4-----------------------------------------

  //-----------------------variable--------------------------------------
  int t4=0;
  List t4_sr=[];
  List t4_Date=[];
  List t4_volume_sum=[];
  List t4_volume_percentage=[];
  List t4_list=[];
  //-----------------------End-Variable---------------------------------
  Table_4()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_four/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 4-------------------");
    print(responseJSON);
    t4_list = responseJSON["applicantions"];
    setState(() {
      t4=t4_list.length;

      for(int i=0;i<t4;i++){
        t4_sr.add(i);
        t4_Date.add(t4_list[i]['appform__created_date'].toString());
        t4_volume_sum.add(t4_list[i]['volume_sum'].toString());
        t4_volume_percentage.add(t4_list[i]['volume_percentage'].toString());
      }
      for (var i = 0; i < t4; i++) {
        Tabel4 = getTable4Data();
      }
      table4DataSource = Table4DataSource(Table4Data:Tabel4);
    });
    print("-----------------------Output T4--------------------");
    print(t4_sr+t4_Date+t4_volume_sum+t4_volume_percentage);
  }
  List<table4> getTable4Data() {
    //print(Ids.toString()+App_no.toString()+App_Date.toString()+App_Status.toString()+Current_status.toString());
    List <table4> t4_lists = new List();
    for(int i=0;i<t4;i++){
      t4_lists.add(table4((i+1).toString(), t4_Date[i].toString(), t4_volume_sum[i].toString(), t4_volume_percentage[i].toString()));
    }
    return t4_lists;
  }
  //----------------------------End--Table 4------------------------------------

  //---------------------------Table 5-----------------------------------------
  //-----------------------variable-------------------------------------
  int t5=0;
  List t5_sr=[];
  List t5_Date=[];
  List t5_Species=[];
  List t5_destination=[];
  List t5_volume_sum=[];
  List t5_no_of_trees=[];
  List t5_list=[];
  //-----------------------End-Variable---------------------------------
  Table_5()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_five/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body:body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 5-------------------");
    print(responseJSON);
    t5_list = responseJSON["applicantions"];
    setState(() {
      t5=t5_list.length;

      for(int i=0;i<t5;i++){
        t5_sr.add(i);
        t5_Date.add(t5_list[i]['appform__created_date'].toString());
        t5_Species.add(t5_list[i]['species_of_tree'].toString());
        t5_destination.add(t5_list[i]['appform__destination_details'].toString());
        t5_volume_sum.add(t5_list[i]['volume_sum'].toString());
        t5_no_of_trees.add(t5_list[i]['no_of_trees'].toString());
      }
      for (var i = 0; i < t5; i++) {
        Tabel5 = getTable5Data();
      }
      table5DataSource = Table5DataSource(Table5Data:Tabel5);
    });
    print("-----------------------Output T5--------------------");
    print(t5_sr+t5_Date+t5_Species+t5_destination+t5_volume_sum+t5_no_of_trees);
  }
  List<table5> getTable5Data() {

    List <table5> t5_lists = new List();
    for(int i=0;i<t5;i++){
      t5_lists.add(table5((i+1).toString().toString(),t5_Date[i].toString(), t5_Species[i].toString(), t5_destination[i].toString(),t5_volume_sum[i].toString(),t5_no_of_trees[i].toString()));
    }
    return t5_lists;
  }
  //----------------------------End--Table 5-----------------------------------

  //---------------------------Table 6------------------------------------------
  //-----------------------variable-------------------------------------
  int t6=0;
  List t6_sr=[];
  List t6_Date=[];
  List t6_destination=[];
  List t6_volume_sum=[];
  List t6_volume_percentage=[];
  List t6_list=[];
  //-----------------------End-Variable---------------------------------
  Table_6()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_six/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body:body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 6-------------------");
    print(responseJSON);
    t6_list = responseJSON["applicantions"];
    setState(() {
      t6=t6_list.length;
      for(int i=0;i<t6;i++){
        t6_sr.add(i);
        t6_Date.add(t6_list[i]['appform__created_date'].toString());
        t6_destination.add(t6_list[i]['appform__destination_details'].toString());
        t6_volume_sum.add(t6_list[i]['volume_sum'].toString());
        t6_volume_percentage.add(t6_list[i]['volume_percentage'].toString());
      }
      for (var i = 0; i < t6; i++) {
        Tabel6 = getTable6Data();
      }
      table6DataSource = Table6DataSource(Table6Data:Tabel6);
    });
    print("-----------------------Output T6--------------------");
    print(t6_sr+t6_Date+t6_destination+t6_volume_sum+t6_volume_percentage);
  }
  List<table6> getTable6Data() {
    //print(Ids.toString()+App_no.toString()+App_Date.toString()+App_Status.toString()+Current_status.toString());
    List <table6> t6_lists = new List();
    for(int i=0;i<t6;i++){
      t6_lists.add(table6((i+1).toString(), t6_Date[i].toString(), t6_destination[i].toString(), t6_volume_sum[i].toString(),t6_volume_percentage[i].toString()));
    }
    return t6_lists;
  }
  //----------------------------End--Table 6-----------------------------------

  //---------------------------Table 7------------------------------------------
  //-----------------------variable-------------------------------------
  int t7=0;
  List t7_sr=[];
  List t7_Date=[];
  List t7_Time_for_Approval=[];
  List t7_no_of_appln=[];
  List t7_Appln_percentage=[];
  List t7_list=[];
  //-----------------------End-Variable---------------------------------
  Table_7()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_seven/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 7-------------------");
    print(responseJSON);
    t7_list = responseJSON["applicantions"];
    setState(() {
      t7=t7_list.length;
      for(int i=0;i<t7;i++){
        t7_sr.add(i);
        t7_Date.add(t7_list[i]['created_date'].toString());
        t7_Time_for_Approval.add(t7_list[i]['time_taken_applications'].toString());
        t7_no_of_appln.add(t7_list[i]['no_of_applicantions'].toString());
        t7_Appln_percentage.add(t7_list[i]['no_of_applicantions'].toString());
      }
      for (var i = 0; i < t7; i++) {
        Tabel7 = getTable7Data();
      }
      table7DataSource = Table7DataSource(Table7Data:Tabel7);
    });
    print("-----------------------Output T7--------------------");
    print(t7_sr+t7_Date+t7_Time_for_Approval+t7_no_of_appln+t7_Appln_percentage);

  }
  List<table7> getTable7Data() {
    List <table7> t7_lists = new List();
    for(int i=0;i<t7;i++){
      t7_lists.add(table7((i+1).toString().toString(), t7_Date[i].toString(), t7_Time_for_Approval[i].toString(), t7_no_of_appln[i].toString(),t7_Appln_percentage[i].toString()));
    }
    return t7_lists;
  }
  //----------------------------End--Table 7-----------------------------------

  //---------------------------Table 8-----------------------------------------
  //-----------------------variable-------------------------------------
  int t8=0;
  List t8_sr=[];
  List t8_Date=[];
  List t8_Reason_for_Cutting=[];
  List t8_no_of_appln=[];
  List t8_Appln_percentage=[];
  List t8_list=[];
  //-----------------------End-Variable---------------------------------
  Table_8()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_eight/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 8-------------------");
    print(responseJSON);
    t8_list = responseJSON["applicantions"];
    setState(() {
      t8=t8_list.length;
      for(int i=0;i<t8;i++){
        t8_sr.add(i);
        t8_Date.add(t8_list[i]['created_date'].toString());
        t8_Reason_for_Cutting.add(t8_list[i]['purpose'].toString());
        t8_no_of_appln.add(t8_list[i]['no_of_applicantions'].toString());
        t8_Appln_percentage.add(t8_list[i]['applications_percentage'].toString());
      }
      for (var i = 0; i < t8; i++) {
        Tabel8 = getTable8Data();
      }
      table8DataSource = Table8DataSource(Table8Data:Tabel8);
    });
    print("-----------------------Output T8--------------------");
    print(t8_sr+t8_Date+t8_Reason_for_Cutting+t8_no_of_appln+t8_Appln_percentage);
  }
  List<table8> getTable8Data() {

    List <table8> t8_lists = new List();
    for(int i=0;i<t8;i++){
      t8_lists.add(table8((i+1).toString(), t8_Date[i].toString(), t8_Reason_for_Cutting[i].toString(), t8_no_of_appln[i].toString(),t8_Appln_percentage[i]));
    }
    return t8_lists;
  }
  //----------------------------End--Table 8-----------------------------------

  //---------------------------Table 9------------------------------------------
  //-----------------------variable-------------------------------------
  int t9=0;
  List t9_sr=[];
  List t9_Date=[];
  List t9_Speices=[];
  List t9_before_cutting=[];
  List t9_after_cutting=[];
  List t9_before_cutting_percentage=[];
  List t9_after_cutting_percentage=[];
  List t9_total_Application=[];
  List t9_list=[];
  //-----------------------End-Variable---------------------------------
  Table_9()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_nine/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 9-------------------");
    print(responseJSON);
    t9_list = responseJSON["applicantions"];
    setState(() {
      t9=t9_list.length;
      for(int i=0;i<t9;i++){
        t9_sr.add(i);
        t9_Date.add(t9_list[i]['appform__created_date'].toString());
        t9_Speices.add(t9_list[i]['species_of_tree'].toString());
        t9_before_cutting.add(t9_list[i]['no_before_cutting'].toString());
        t9_after_cutting.add(t9_list[i]['no_after_cutting'].toString());
        t9_before_cutting_percentage.add(t9_list[i]['before_cutting_percentage'].toString());
        t9_after_cutting_percentage.add(t9_list[i]['after_cutting_percentage'].toString());
        t9_total_Application.add(t9_list[i]['no_of_applicantions'].toString());
      }
      for (var i = 0; i < t9; i++) {
        Tabel9 = getTable9Data();
      }
      table9DataSource = Table9DataSource(Table9Data:Tabel9);
    });
    print("-----------------------Output T9--------------------");
    print(t9_sr+t9_Date+t9_Speices+t9_before_cutting+t9_after_cutting+t9_before_cutting_percentage+t9_after_cutting_percentage+t9_total_Application);

  }
  List<table9> getTable9Data() {
    List <table9> t9_lists = new List();
    for(int i=0;i<t9;i++){
      t9_lists.add(table9((i+1).toString(), t9_Date[i].toString(), t9_Speices[i].toString(), t9_before_cutting[i].toString(),t9_after_cutting[i].toString(),t9_before_cutting_percentage[i].toString(),t9_after_cutting_percentage[i].toString(),t9_total_Application[i].toString()));
    }
    return t9_lists;
  }
  //----------------------------End--Table 9------------------------------------
  //-----------------------------Noc-Table--------------------------------------
  //----------------------Variables-----------------------
  int t10=0;
  List t10_sr=[];
  List species_of_tree=[];
  List appform__destination_details=[];
  List appform__created_date=[];
  List no_of_trees=[];
  List volume_sum=[];
  List t10_list=[];
  //----------------------End-Variable--------------------
  Table_10()async{
    final String url = 'http://13.235.67.23:8000/api/auth/sfd_table_noc_one/';
    Map data = {
      "division":SelectedRange1==null?"":SelectedRange1=="All Division"?"":SelectedRange1,
      "area_range":SelectedRange==null?"":SelectedRange=="All Range"?"":SelectedRange,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("---------------Table 10-NOC-------------------");
    print(responseJSON);
    t10_list = responseJSON["applicantions"];
    setState(() {
      t10=t10_list.length;
      for(int i=0;i<t10;i++){
        t10_sr.add(i);
        species_of_tree.add(t10_list[i]['species_of_tree'].toString());
        appform__destination_details.add(t10_list[i]['appform__destination_details'].toString());
        appform__created_date.add(t10_list[i]['appform__created_date'].toString());
        no_of_trees.add(t10_list[i]['no_of_trees'].toString());
        volume_sum.add(t10_list[i]['volume_sum'].toString());
      }
      for (var i = 0; i < t10; i++) {
        Tabel10 = getTable10Data();
      }
      table10DataSource = Table10DataSource(Table10Data:Tabel10);
    });
    print("-----------------------Output T10--------------------");
    print(t10_sr+species_of_tree+appform__destination_details+ appform__created_date+no_of_trees+volume_sum);

  }

  List<table10> getTable10Data() {
    List <table10> t10_lists = new List();
    for(int i=0;i<t10;i++){
      t10_lists.add(table10((i+1).toString(), species_of_tree[i].toString(), appform__destination_details[i].toString(), appform__created_date[i].toString(),no_of_trees[i].toString(),volume_sum[i].toString()));
    }
    return t10_lists;
  }
  //----------------------------End-Noc-Table----------------------------------
  //-----------------------------end-Connection--------------------------------
  @override
  void _handleRadioValueChange(int value) async {

    setState(() {
      _radioValue = value;
      if (_radioValue == 0) {
        toggle = 'Yes';
        setState(() {
          tab=0;
          flag=true;
        });
      } else if (_radioValue == 1) {
        toggle = 'No';
        setState(() {
          tab=1;
          flag=false;
        });
      }
    });
  }



  double Approved=0;
  double Rejected=0;
  double Pending=0;
  //api----------
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

  int i=0;
  List<TreesData> getChartData() {
    List<TreesData> chartData =new List();
    for(int i=0;i<g3;i++){
      TreesData(X_axis[i],Y_axis[i]);
    }

    return chartData;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text('View Report'),
        gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
            LayoutBuilder(
                builder: (context, constraints) {
                  if(R1==1)
                    return Container(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:12,bottom: 5),
                            child: ToggleSwitch(
                              minWidth: MediaQuery.of(context).size.width ,
                              initialLabelIndex: _radioValue,
                              cornerRadius: 12.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[200],
                              inactiveFgColor: Colors.blue,
                              labels: ['Pie-Chart', 'Application',],
                              activeBgColors: [Colors.blue,Colors.blue,Colors.blue],
                              onToggle: _handleRadioValueChange,
                            ),
                          ),
                          LayoutBuilder(
                              builder: (context, constraints) {
                                if(flag == true) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:  MediaQuery.of(context).size.height * 0.40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
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
                                    margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                                    padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                                    child:  PieChart(
                                      dataMap: {
                                        "Approved": Approved,
                                        "Rejected": Rejected,
                                      },
                                      animationDuration: Duration(milliseconds: 800),
                                      chartLegendSpacing: 20,
                                      chartRadius: MediaQuery.of(context).size.width*0.65,
                                      initialAngleInDegree: 0,
                                      chartType: ChartType.disc,
                                      colorList: [
                                        Colors.blue,
                                        Colors.red,
                                      ],
                                      ringStrokeWidth: 32,
                                      centerText: "",
                                      legendOptions: LegendOptions(
                                        showLegendsInRow: false,
                                        // ignore: missing_return
                                        // legendPosition: LegendPosition.left,
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
                                  );
                                }else if(flag == false){
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.79,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
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
                                    margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                                    padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                                    child:SfDataGrid(
                                      source:table1DataSource,
                                      //columnWidthMode: ColumnWidthMode.lastColumnFill,
                                      allowSorting: true,
                                      isScrollbarAlwaysShown: true,
                                      allowMultiColumnSorting: true,
                                      allowTriStateSorting: true,
                                      columns: <GridColumn>[
                                        GridTextColumn(
                                            columnName: 't1_sr',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                    'SR.NO',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                                ))),
                                        GridTextColumn(
                                            columnName: 't1_Date',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                                        GridTextColumn(
                                            columnName: 't1_Received',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                    'Received'
                                                    ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                                ))),
                                        GridTextColumn(
                                            columnName: 't1_Approved',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text('Approved',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                                        GridTextColumn(
                                            columnName: 't1_Rejected',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text('Rejecetd',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                                      ],

                                    ),
                                  );
                                }
                              }
                          ),
                        ])
                    );
                  else if(R2==2){
                    return Container(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:12,bottom: 5,left: 8,right: 8),
                            child: ToggleSwitch(
                              minWidth: MediaQuery.of(context).size.width,
                              initialLabelIndex: _radioValue,
                              cornerRadius: 12.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey[200],
                              inactiveFgColor: Colors.blue,
                              labels: ['Pie-Chart', 'Application',],
                              activeBgColors: [Colors.blue,Colors.blue,Colors.blue],
                              onToggle: _handleRadioValueChange,
                            ),
                          ),
                          LayoutBuilder(
                              builder: (context, constraints) {
                                if(flag == true) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:  MediaQuery.of(context).size.height * 0.40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
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
                                    margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                                    padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                                    child:  PieChart(
                                      dataMap:T2_C==null?{"Empty":100}:T2_C /*{

                                        t2_Reason[0].toString():double.parse(t2_percentage[0].toString()),
                                        t2_Reason[1].toString():double.parse(t2_percentage[1].toString()),
                                        t2_Reason[2].toString():double.parse(t2_percentage[2].toString()),
                                        t2_Reason[3].toString():double.parse(t2_percentage[3].toString()),

                                      }*/,
                                      animationDuration: Duration(milliseconds: 800),
                                      chartLegendSpacing: 20,
                                      chartRadius: MediaQuery.of(context).size.width*0.65,
                                      initialAngleInDegree: 0,
                                      chartType: ChartType.disc,
                                      colorList:T2_C==null? [
                                        Colors.grey,
                                      ]:[
                                        Colors.blue,
                                        Colors.red,
                                        Colors.orange,
                                        Colors.yellow,
                                      ],
                                      ringStrokeWidth: 72,
                                      centerText: "",
                                      legendOptions: LegendOptions(
                                        showLegendsInRow: false,
                                        // legendPosition: LegendPosition.left,
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
                                  );
                                }else if(flag == false){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 0.79,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
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
                                    margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                                    padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                                    child:SfDataGrid(
                                      source:table2DataSource,
                                      //columnWidthMode: ColumnWidthMode.lastColumnFill,
                                      allowSorting: true,
                                      isScrollbarAlwaysShown: true,
                                      allowMultiColumnSorting: true,
                                      allowTriStateSorting: true,
                                      columns: <GridColumn>[
                                        GridTextColumn(
                                            columnName: 't2_sr',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                    'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                                ))),
                                        GridTextColumn(
                                            width: 180,
                                            columnName: 't2_Reason',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text('Reasons For Rejection',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                                        GridTextColumn(
                                            width: 150,
                                            columnName: 't2_percentage',
                                            label: Container(
                                                color: Colors.blue,
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                    'Percentage',
                                                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                                ))),
                                      ],
                                    ),
                                  );
                                }
                              }
                          ),
                        ])
                    );
                  }
                  else if(R3==3){
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.79,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table3DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't3_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Sr.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              columnName: 't3_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't3_Species',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.only(top:8.0,bottom:8.0,left: 15,right: 15),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Species',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 130,
                              columnName: 't3_Transported',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Volume Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 130,
                              columnName: 't3_No_of_TreeTrans',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('No of Trees Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],
                      ),
                    );
                  }
                  else if(R4==4){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table4DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't4_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              columnName: 't4_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 130,
                              columnName: 't4_volume_sum',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Volume Transported',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't4_volume_percentage',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('No of Trees Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),

                        ],

                      ),
                    );

                  }
                  else if(R5==5){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table5DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't5_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              columnName: 't5_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't5_Species',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Species',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't5_destination',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Destination',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't5_volume_sum',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Volume transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't5_no_of_trees',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('No of Tree Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],

                      ),
                    );
                  }
                  else if(R6==6){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table6DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't6_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                  ))),
                          GridTextColumn(
                              columnName: 't6_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't6_destination',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Destination',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                  ))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't6_volume_sum',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Volume Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't6_volume_percentage',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('% Volume Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],

                      ),
                    );
                  }
                  else if(R7==7){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table7DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't7_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              columnName: 't7_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't7_Time_for_Approval',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Time Taken for Approval',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't7_no_of_appln',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('No of Application',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't7_Appln_percentage',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('% of Application',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],

                      ),
                    );
                  }
                  else if(R8==8){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table8DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't8_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                  ))),
                          GridTextColumn(
                              columnName: 't8_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't8_Reason_for_Cutting',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Reason For Cutting Trees',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't8_no_of_appln',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('No of Application',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't8_Appln_percentage',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('% of Application',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],

                      ),
                    );
                  }
                  else if(R9==9){
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table9DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't9_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              columnName: 't9_Date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't9_Speices',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Species',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't9_before_cutting',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('App. Received Before cutting',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 150,
                              columnName: 't9_after_cutting',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('App. Received After cutting',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't9_before_cutting_percentage',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(' % of App. Received Before cutting',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't9_after_cutting_percentage',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('%  of App. Received After cutting',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 't9_total_Application',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Total Application',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],

                      ),
                    );
                  }
                  else if(R10==10){
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                      margin: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 10),
                      padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                      child:SfDataGrid(
                        source:table10DataSource,
                        isScrollbarAlwaysShown: true,
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        columns: <GridColumn>[
                          GridTextColumn(
                              columnName: 't10_sr',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'SR.No',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),
                          GridTextColumn(
                              width: 150,
                              columnName: 'appform__created_date',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              columnName: 'species_of_tree',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Species',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 150,
                              columnName: 'appform__destination_details',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Destination',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                                  ))),

                          GridTextColumn(
                              width: 150,
                              columnName: 'no_of_trees',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('No of Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                          GridTextColumn(
                              width: 180,
                              columnName: 'volume_sum',
                              label: Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Volume Transported',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))),
                        ],
                      ),
                    );
                  }
                  else{
                    return Container(
                      width:10,height: 10,
                      color: Colors.blueGrey,
                    );
                  }
                }
            ),
          ]
          )
      ),
    );
  }
}


//---------------------------table 1--------------------------------------------
class table1{
  table1(this.t1_sr,this.t1_Date,this.t1_Received,this.t1_Approved,this.t1_Rejected);
  String t1_sr;
  String t1_Date;
  String t1_Received;
  String t1_Approved;
  String t1_Rejected;
}
List<DataGridRow> _Table1Data = [];

class Table1DataSource extends DataGridSource {
  @override
  Table1DataSource({List<table1> Table1Data}){
    _Table1Data = Table1Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't1_sr', value: e.t1_sr),
      DataGridCell<String>(columnName: 't1_Date', value: e.t1_Date),
      DataGridCell<String>(columnName: 't1_Received', value: e.t1_Received),
      DataGridCell<String>(columnName: 't1_Approved', value: e.t1_Approved),
      DataGridCell<String>(columnName: 't1_Rejected', value: e.t1_Rejected),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table1Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }


}
//---------------------------End table 1----------------------------------------

//---------------------------table 2--------------------------------------------
class table2{
  table2(this.t2_sr,this.t2_Reason,this.t2_percentage);
  String t2_sr;
  String t2_Reason;
  String t2_percentage;
}
List<DataGridRow> _Table2Data = [];

class Table2DataSource extends DataGridSource {
  @override
  Table2DataSource({List<table2> Table2Data}){
    _Table2Data = Table2Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't2_sr', value: e.t2_sr),
      DataGridCell<String>(columnName: 't2_Reason', value: e.t2_Reason),
      DataGridCell<String>(columnName: 't2_percentage', value: e.t2_percentage),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table2Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
//---------------------------End table 2----------------------------------------

//---------------------------table 3--------------------------------------------
class table3{
  table3(this.t3_sr,this.t3_Date,this.t3_Species,this.t3_Transported,this.t3_No_of_TreeTrans);
  String t3_sr;
  String t3_Date;
  String t3_Species;
  String t3_Transported;
  String t3_No_of_TreeTrans;
}
List<DataGridRow> _Table3Data = [];

class Table3DataSource extends DataGridSource {
  @override
  Table3DataSource({List<table3> Table3Data}){
    _Table3Data = Table3Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't3_sr', value: e.t3_sr),
      DataGridCell<String>(columnName: 't3_Date', value: e.t3_Date),
      DataGridCell<String>(columnName: 't3_Species', value: e.t3_Species),
      DataGridCell<String>(columnName: 't3_Transported', value: e.t3_Transported),
      DataGridCell<String>(columnName: 't3_No_of_TreeTrans', value: e.t3_No_of_TreeTrans),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table3Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }


}

//---------------------------End table 3----------------------------------------

//---------------------------table 4--------------------------------------------
class table4{
  table4(this.t4_sr,this.t4_Date,this.t4_volume_sum,this.t4_volume_percentage);
  String t4_sr;
  String t4_Date;
  String t4_volume_sum;
  String t4_volume_percentage;
}
List<DataGridRow> _Table4Data = [];

class Table4DataSource extends DataGridSource {
  @override
  Table4DataSource({List<table4> Table4Data}){
    _Table4Data = Table4Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't4_sr', value: e.t4_sr),
      DataGridCell<String>(columnName: 't4_Date', value: e.t4_Date),
      DataGridCell<String>(columnName: 't4_volume_sum', value: e.t4_volume_sum),
      DataGridCell<String>(columnName: 't4_volume_percentage', value: e.t4_volume_percentage),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table4Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }


}
//---------------------------End table 4----------------------------------------

//---------------------------table 5--------------------------------------------
class table5{
  table5(this.t5_sr,this.t5_Date,this.t5_Species,this.t5_destination,this.t5_volume_sum,this.t5_no_of_trees);
  String t5_sr;
  String t5_Date;
  String t5_Species;
  String t5_destination;
  String t5_volume_sum;
  String t5_no_of_trees;
}
List<DataGridRow> _Table5Data = [];

class Table5DataSource extends DataGridSource {
  @override
  Table5DataSource({List<table5> Table5Data}){
    _Table5Data = Table5Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't5_sr', value: e.t5_sr),
      DataGridCell<String>(columnName: 't5_Date', value: e.t5_Date),
      DataGridCell<String>(columnName: 't5_Species', value: e.t5_Species),
      DataGridCell<String>(columnName: 't5_destination', value: e.t5_destination),
      DataGridCell<String>(columnName: 't5_volume_sum', value: e.t5_volume_sum),
      DataGridCell<String>(columnName: 't5_no_of_trees', value: e.t5_no_of_trees),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table5Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}

//---------------------------End table 5----------------------------------------

//---------------------------table 6--------------------------------------------

class table6{
  table6(this.t6_sr,this.t6_Date,this.t6_destination,this.t6_volume_sum,this.t6_volume_percentage);
  String t6_sr;
  String t6_Date;
  String t6_destination;
  String t6_volume_sum;
  String t6_volume_percentage;
}

List<DataGridRow> _Table6Data = [];

class Table6DataSource extends DataGridSource {
  @override
  Table6DataSource({List<table6> Table6Data}){
    _Table6Data = Table6Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't6_sr', value: e.t6_sr),
      DataGridCell<String>(columnName: 't6_Date', value: e.t6_Date),
      DataGridCell<String>(columnName: 't6_destination', value: e.t6_destination),
      DataGridCell<String>(columnName: 't6_volume_sum', value: e.t6_volume_sum),
      DataGridCell<String>(columnName: 't6_volume_percentage', value: e.t6_volume_percentage),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table6Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
//---------------------------End table 6----------------------------------------

//---------------------------table 7--------------------------------------------
class table7{
  table7(this.t7_sr,this.t7_Date,this.t7_Time_for_Approval,this.t7_no_of_appln,this.t7_Appln_percentage);
  String t7_sr;
  String t7_Date;
  String t7_Time_for_Approval;
  String t7_no_of_appln;
  String t7_Appln_percentage;
}
List<DataGridRow> _Table7Data = [];

class Table7DataSource extends DataGridSource {
  @override
  Table7DataSource({List<table7> Table7Data}){
    _Table7Data = Table7Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't7_sr', value: e.t7_sr),
      DataGridCell<String>(columnName: 't7_Date', value: e.t7_Date),
      DataGridCell<String>(columnName: 't7_Time_for_Approval', value: e.t7_Time_for_Approval),
      DataGridCell<String>(columnName: 't7_no_of_appln', value: e.t7_no_of_appln),
      DataGridCell<String>(columnName: 't7_no_of_appln', value: e.t7_Appln_percentage),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table7Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
//---------------------------End table 7----------------------------------------

//---------------------------table 8--------------------------------------------
class table8{
  table8(this.t8_sr,this.t8_Date,this.t8_Reason_for_Cutting,this.t8_no_of_appln,this.t8_Appln_percentage);
  String t8_sr;
  String t8_Date;
  String t8_Reason_for_Cutting;
  String t8_no_of_appln;
  String t8_Appln_percentage;
}
List<DataGridRow> _Table8Data = [];

class Table8DataSource extends DataGridSource {
  @override
  Table8DataSource({List<table8> Table8Data}){
    _Table8Data = Table8Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't8_sr', value: e.t8_sr),
      DataGridCell<String>(columnName: 't8_Date', value: e.t8_Date),
      DataGridCell<String>(columnName: 't8_Reason_for_Cutting', value: e.t8_Reason_for_Cutting),
      DataGridCell<String>(columnName: 't8_no_of_appln', value: e.t8_no_of_appln),
      DataGridCell<String>(columnName: 't8_Appln_percentage', value: e.t8_Appln_percentage),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table8Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
//---------------------------End table 8----------------------------------------

//---------------------------table 9--------------------------------------------
class table9{
  table9(this.t9_sr,this.t9_Date,this.t9_Speices,this.t9_before_cutting,this.t9_after_cutting,this.t9_before_cutting_percentage,this.t9_after_cutting_percentage,this.t9_total_Application);
  String t9_sr;
  String t9_Date;
  String t9_Speices;
  String t9_before_cutting;
  String t9_after_cutting;
  String t9_before_cutting_percentage;
  String t9_after_cutting_percentage;
  String t9_total_Application;
}
List<DataGridRow> _Table9Data = [];

class Table9DataSource extends DataGridSource {
  @override
  Table9DataSource({List<table9> Table9Data}){
    _Table9Data = Table9Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't9_sr', value: e.t9_sr),
      DataGridCell<String>(columnName: 't9_Date', value: e.t9_Date),
      DataGridCell<String>(columnName: 't9_Speices', value: e.t9_Speices),
      DataGridCell<String>(columnName: 't9_before_cutting', value: e.t9_before_cutting),
      DataGridCell<String>(columnName: 't9_after_cutting', value: e.t9_after_cutting),
      DataGridCell<String>(columnName: 't9_before_cutting_percentage', value: e.t9_before_cutting_percentage),
      DataGridCell<String>(columnName: 't9_after_cutting_percentage', value: e.t9_after_cutting_percentage),
      DataGridCell<String>(columnName: 't9_total_Application', value: e.t9_total_Application),
    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table9Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }

}
//---------------------------End table 9----------------------------------------


//---------------------------Graph for T3---------------------------------------

class TreesData {
  TreesData(this.X_axis, this.Y_axis);
  final String X_axis;
  final String Y_axis;
}
//---------------------------End-Graph -----------------------------------------


//------------------------------Noc-Report-Table--------------------------------
class table10{
  table10(this.t10_sr,this.species_of_tree,this.appform__destination_details,this.appform__created_date,this.no_of_trees,this.volume_sum);
  String t10_sr;
  String species_of_tree;
  String appform__destination_details;
  String appform__created_date;
  String no_of_trees;
  String volume_sum;
}
List<DataGridRow> _Table10Data = [];

class Table10DataSource extends DataGridSource {
  @override
  Table10DataSource({List<table10> Table10Data}){
    _Table10Data = Table10Data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 't10_sr', value: e.t10_sr),
      DataGridCell<String>(columnName: 'species_of_tree', value: e.species_of_tree),
      DataGridCell<String>(columnName: 'appform__destination_details', value: e.appform__destination_details),
      DataGridCell<String>(columnName: 'appform__created_date', value: e.appform__created_date),
      DataGridCell<String>(columnName: 'no_of_trees', value: e.no_of_trees),
      DataGridCell<String>(columnName: 'volume_sum', value: e.volume_sum),

    ])).toList();
  }
  @override
  List<DataGridRow> get rows => _Table10Data;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}


