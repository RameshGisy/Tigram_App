import 'package:flutter/material.dart';
import 'package:Tigram/ViewApplication2.dart';
import 'package:Tigram/Images.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ViewApplication1 extends StatefulWidget {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String img_signature;
  String img_revenue_approval;
  String img_declaration;
  String img_revenue_application;
  String img_location_sktech;
  String img_tree_ownership_detail;
  String img_aadhar_detail;

  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  ViewApplication1({this.sessionToken,this.userGroup,this.userId,this.Ids,this.Range,this.img_signature,this.img_revenue_approval,this.img_declaration,this.img_revenue_application,this.img_location_sktech,this.img_tree_ownership_detail,this.img_aadhar_detail,
    this.verify_officer,this.deputy_range_officer,this.verify_range_officer,this.is_form_two,this.assigned_deputy2_id,this.assigned_deputy1_id,this.verify_deputy2,this.division_officer,this.other_state,this.verify_forest1
  });
  @override
  _ViewApplication1State createState() => _ViewApplication1State(sessionToken,userGroup,userId,Ids,Range,img_signature,img_revenue_approval,img_declaration,img_revenue_application,img_location_sktech,img_tree_ownership_detail,img_aadhar_detail,
      verify_officer,deputy_range_officer,verify_range_officer,is_form_two,assigned_deputy2_id,assigned_deputy1_id,verify_deputy2,division_officer,other_state,verify_forest1
  );
}

class _ViewApplication1State extends State<ViewApplication1> {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String img_signature;
  String img_revenue_approval;
  String img_declaration;
  String img_revenue_application;
  String img_location_sktech;
  String img_tree_ownership_detail;
  String img_aadhar_detail;

  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  _ViewApplication1State(this.sessionToken,this.userGroup,this.userId,this.Ids,this.Range,this.img_signature,this.img_revenue_approval,this.img_declaration,this.img_revenue_application,this.img_location_sktech,this.img_tree_ownership_detail,this.img_aadhar_detail,
      this.verify_officer,this.deputy_range_officer,this.verify_range_officer,this.is_form_two,this.assigned_deputy2_id,this.assigned_deputy1_id,this.verify_deputy2,this.division_officer,this.other_state,this.verify_forest1
      );

    @override
    Widget build(BuildContext context) {
        List images = [
          img_signature,
          img_revenue_approval,
          img_declaration,
          img_revenue_application,
          img_location_sktech,
          img_tree_ownership_detail,
          img_aadhar_detail,
        ];
      print(img_signature);
        List<String> Image_nm = [
          "Signature",
          "Revenue Approval",
          "Declaration",
          "Revenue Application",
          "location Sketch",
          "Proof of OwnerShip",
          "Photo Proof",
        ];
        print(images.toString());
      return Scaffold(
          appBar: NewGradientAppBar(
            title: Text('Application View'),
      //      gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
            //backgroundColor: Colors.blueGrey,
            elevation: 0,
           // automaticallyImplyLeading: false,
          ),
          body:Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 15.0,top:10,bottom: 0,left: 15),
                    child: Text('------ATTACHMENTS GALLERY--------',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                    )
                ),
                Expanded(
                        child:GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                            itemCount: images.length,
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 5,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.only(top:10),
                                child:InkWell(
                                  onTap: () {
                                    print(images);
                                    Navigator.push(
                                        context,MaterialPageRoute(builder: (_) =>
                                        ImageView(
                                         Images:images[index].toString(),
                                        ))
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(images[index].toString()),
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.center,
                                      ),
                                    ),

                                    child: ListTile(title:Text(Image_nm[index].toString(),textAlign: TextAlign.center,style: TextStyle(backgroundColor: Colors.black,color: Colors.white),),),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            }),

                    )
           ] ),
       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.navigate_next),
      //    backgroundColor: HexColor("#0499f2"),
          onPressed: () {
            Navigator.push(
                context,MaterialPageRoute(builder: (_) =>
                ViewApplication2(
                    sessionToken:sessionToken,
                    userGroup:userGroup,
                    userId:userId,
                    Ids:Ids,
                    Range:Range,
                    img_signature:img_signature,
                    verify_officer:verify_officer,
                    deputy_range_officer:deputy_range_officer,
                    verify_range_officer:verify_range_officer,
                    is_form_two:is_form_two,
                    assigned_deputy2_id:assigned_deputy2_id,
                    assigned_deputy1_id:assigned_deputy1_id,
                    verify_deputy2:verify_deputy2,
                    division_officer:division_officer,
                    other_state:other_state,
                    verify_forest1:verify_forest1
                  //sessionToken:sessionToken,
                ))
            );
          },
        ),
          );
    }
  }

