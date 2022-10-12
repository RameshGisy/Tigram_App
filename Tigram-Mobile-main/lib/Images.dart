import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ImageView extends StatefulWidget {
  String Images;
  ImageView({this.Images});
  @override
  _ImageViewState createState() => _ImageViewState(Images);
}

class _ImageViewState extends State<ImageView> {
  String Images;
  _ImageViewState(this.Images);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Document View"),
     //   gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
        //backgroundColor: Colors.blueGrey,
        elevation: 0,
        //automaticallyImplyLeading: false,
      ),
      body:Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child:InteractiveViewer(
          minScale: 0.1,
          maxScale: 10.0,
          child: Image.network(Images,
          fit:BoxFit.fill,
        ),
      ),
      )
    );
  }
}
