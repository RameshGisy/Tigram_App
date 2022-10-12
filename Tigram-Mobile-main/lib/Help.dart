import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  TextEditingController Query = TextEditingController();
  bool a= false;
  bool b= false;
  bool c= false;
  bool d= false;
  bool e= false;

  bool a1= false;
  bool b1= false;
  bool c1= false;
  bool d1= false;
  bool e1= false;

  bool a2= false;
  bool b2= false;
  bool c2= false;
  bool d2= false;
  bool e2= false;

  bool a3= false;
  bool b3= false;
  bool c3= false;
  bool d3= false;
  bool e3= false;
  bool f3= false;


  bool a4= false;
  bool b4= false;
  bool c4= false;
  bool d4= false;
  bool e4= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          title: Text("FAQ" ,
            textAlign: TextAlign.left,
          ),
    //      gradient: LinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),
          // backgroundColor: Colors.blueGrey,
        ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                  color: Colors.white,
                  width: 1
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
            margin: const EdgeInsets.only(left:5,right:5,top: 10,bottom: 10),
            padding: const EdgeInsets.all(5),
          child:Column(
           children: <Widget>[
             Card(child: ListTile(title: Text("What is TIGRAM ?", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
               onPressed: (){
                 if(a==false){
                   setState(() {
                     a=true;
                   });
                 }else{
                   setState(() {
                     a=false;
                   });
                 }
               },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: a,
               child: ListTile(title: Text("TIGRAM is a web based application and mobile application developed for  private forest owner to apply for transit pass for exempted species of trees and  NOC for non-exempted species.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("What is a transit pass ?", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(b==false){
                     setState(() {
                       b=true;
                     });
                   }else{
                     setState(() {
                       b=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: b,
               child: ListTile(title: Text("A transit pass is a pass issued by the forest department for intra-state  transit or transportation of timber for non-exempted species as per the Forest  Act . \n List of non-exempted species \n \>  Rosewood (Dalbergia latifolia) \n \>  Teak (Tectona grandis)  \n \>  Thempavu (Terminalia tomentosa)  \n \>  Teak (Tectona grandis) \n \>  Kampakam (Hopea Parviflora) \n \>  Chadachi (Grewia tiliifolia) \n \>  Chandana vempu (Cedrela toona) \n \>  Vellakil (Dysoxylum malabaricum) \n \>  Irul (Xylia xylocarpa) \n \>  Ebony (Diospyrus sp.) ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("When one can apply for Transit pass ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(c==false){
                     setState(() {
                       c=true;
                     });
                   }else{
                     setState(() {
                       c=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: c,
               child: ListTile(title: Text("An applicant can apply for transit pass only after the Revenue Department  approves the application.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How Timber Transit Pass System works ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(d==false){
                     setState(() {
                       d=true;
                     });
                   }else{
                     setState(() {
                       d=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: d,
               child: ListTile(title: Text("An applicant has to register in the system, thereafter the applicant can apply  for a transit pass. Application will move to concerned Officers. After following  specific procedure of verification, Transit Pass will be issued. The applicant can  later download the transit pass generated from check pass status option.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How to register on the website ?", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(e==false){
                     setState(() {
                       e=true;
                     });
                   }else{
                     setState(() {
                       e=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: e,
               child: ListTile(title: Text("The applicant can click on Register button on the home page of website. An applicant needs to register by entering personal details like name, email-id,  password, mobile number and id proof in the registration form. The applicant  can attach any one the below mentioned identity proofs. \n List Identity proof documents \n \>  Aadhar card\n \>  Driving License \n \>  Passport\n \>  Government ID\n \> Voter Identity Card ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("What credentials are required to login into the system ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(a1==false){
                     setState(() {
                       a1=true;
                     });
                   }else{
                     setState(() {
                       a1=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: a1,
               child: ListTile(title: Text("The applicant can login by entering registered email address and the  password which was set during registration. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("What are document required for transit pass ?", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(b1==false){
                     setState(() {
                       b1=true;
                     });
                   }else{
                     setState(() {
                       b1=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: b1,
               child: ListTile(title: Text("Following is the list of documents required while applying for a transit  pass. \n \> Revenue Application document. \n \> Revenue Approval document  \n \> Declaration document. \n \> Tree Ownership Proof. \n \>Location Sketch  \n \> Identity Proof.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("Is there any validity of Transit Pass ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(c1==false){
                     setState(() {
                       c1=true;
                     });
                   }else{
                     setState(() {
                       c1=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: c1,
               child: ListTile(title: Text("A transit pass will be available for download from TIGRAM application for  7 days after the application is approved by forest range officer. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("Can I take a printout of my online transit pass ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(d1==false){
                     setState(() {
                       d1=true;
                     });
                   }else{
                     setState(() {
                       d1=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: d1,
               child: ListTile(title: Text("Yes you can take the print of your online transit pass, you can click on  download button link in check pass status to download the transit pass and  print the same.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("Can the officer change the applicant details or edit the form after submitting  the online form ?  ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(e1==false){
                     setState(() {
                       e1=true;
                     });
                   }else{
                     setState(() {
                       e1=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: e1,
               child: ListTile(title: Text("The officer can change only the wood log details by editing the form  during or after the verification / field inspection is carried out. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How do I track my transit pass once I have applied ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(a2==false){
                     setState(() {
                       a2=true;
                     });
                   }else{
                     setState(() {
                       a2=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: a2,
               child: ListTile(title: Text("The applicant can track the transit pass by clicking on the Check Pass  Status option which is seen on user dashboard once the applicant logs in  successfully. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("Can a single Transit Pass generated or used for exempted and non exempted species ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(b2==false){
                     setState(() {
                       b2=true;
                     });
                   }else{
                     setState(() {
                       b2=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: b2,
               child: ListTile(title: Text("No. For exempted species NOC (No Objection Certificate) will be generated based on the application made by the applicant using Download  NOC link and for non-exempted species transit pass is generated.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("When one can apply for No Objection Certificate ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(c2==false){
                     setState(() {
                       c2=true;
                     });
                   }else{
                     setState(() {
                       c2=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: c2,
               child: ListTile(title: Text("If an applicant wants to transport a species which is exempted as per  Forest Act and which does not require transit pass, but still as per Forest  Department rule transit of such timber will require an applicant to apply for  NOC for hassle free movement.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("What are documents required for No Objection Certificate ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(d2==false){
                     setState(() {
                       d2=true;
                     });
                   }else{
                     setState(() {
                       d2=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: d2,
               child: ListTile(title: Text("A Valid Photo identity card (Aadhar card / Passport /Voter Id / Driving License / Government Id) is required along with details of exempted timber  species to be transited, while applying for NOC.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("Can I apply for transit pass before or after the felling of the tree ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(e2==false){
                     setState(() {
                       e2=true;
                     });
                   }else{
                     setState(() {
                       e2=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: e2,
               child: ListTile(title: Text("The applicant can apply for transit in both cases, before and even after the  felling of the trees on TIGRAM application.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How to set my password if I forgot my password ?  ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(a3==false){
                     setState(() {
                       a3=true;
                     });
                   }else{
                     setState(() {
                       a3=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: a3,
               child: ListTile(title: Text("To reset password, the applicant can click on Forgot password link on the  user login page, the applicant will be redirected to Change Password page, where  he can enter email address or mobile number used while registration and then  click on SEND OTP button. Lastly, he needs to enter the OTP received on the  registered email address or phone number click on VERIFY button. After  verification of OTP, enter a new password for login and then click on SAVE  button. The applicant can then login with the new password.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("When one can enter the vehicle details? Is it mandatory to enter vehicle  details ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(b3==false){
                     setState(() {
                       b3=true;
                     });
                   }else{
                     setState(() {
                       b3=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: b3,
               child: ListTile(title: Text("The applicant can select the radio button yes to enter the vehicle details  while submitting an application. The applicant can enter vehicle registration  number, name of the driver, mobile phone number of the driver, mode of  transportation and attach image of license copy. No it is not mandatory to  enter vehicle details", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("On what Android version of mobile phone the TIGRAM application can be  installed ?  ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(c3==false){
                     setState(() {
                       c3=true;
                     });
                   }else{
                     setState(() {
                       c3=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: c3,
               child: ListTile(title: Text("The TIGRAM application can be installed on the android version 6 to  android version 11 on the mobile phone. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("What is deemed approved application ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(d3==false){
                     setState(() {
                       d3=true;
                     });
                   }else{
                     setState(() {
                       d3=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: d3,
               child: ListTile(title: Text("The application after being approved by the revenue department, if not  approved by the forest officer will be automatically approved by the system i.e. approved deemed approved after 20 days.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("From where can I download my Transit Pass ?", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(e3==false){
                     setState(() {
                       e3=true;
                     });
                   }else{
                     setState(() {
                       e3=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: e3,
               child: ListTile(title: Text("The applicant can login and click on Check Pass status option and scroll to  Download TP column and click on Download link to download the transit pass. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("What are the exempted species for which NOC is issued ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(f3==false){
                     setState(() {
                       f3=true;
                     });
                   }else{
                     setState(() {
                       f3=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: f3,
               child: ListTile(title: Text("Following is the list of exempted species for which NOC is issued.\n \1. Coconut \2. Rubber \3. Cashew  \4.Tamarind \5. Mango \6. Jack Fruit Tree  \7.Kodampuli  \8.Matti  \9.Arecanut 10.Konna 11.Seema Konna 12.Nelli  13.Neem  14.Murukku  15.Jathi  16.Albezia  17.Silk Cotton  18.Acacia auraculiformis  19.Mangium  20.Anhili  21.Kilimaram  22.Manchadimaram  23.Vatta  24.Palm tree  25.Aranamaram  26.Eucalyptus  27.Seemaplavu  28.Paala ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("From where can I download my NOC ?  ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(a4==false){
                     setState(() {
                       a4=true;
                     });
                   }else{
                     setState(() {
                       a4=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: a4,
               child: ListTile(title: Text("The applicant can login and click on Check Pass status option and scroll to  Download NOC column and click on Download link to download the NOC.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How to enter wood log details? Is it mandatary to enter wood log details ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(b4==false){
                     setState(() {
                       b4=true;
                     });
                   }else{
                     setState(() {
                       b4=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: b4,
               child: ListTile(title: Text("The applicant can click on the Yes button after the question “Would you  like to enter log Details?” and enter the length, girth and click on location icon  to set the latitude and longitude of the wood log. The volume of the log is  automatically calculated by the system. No, it is not mandatory to enter the  wood log details. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How to enter the latitude and longitude of the tree ?", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(c4==false){
                     setState(() {
                       c4=true;
                     });
                   }else{
                     setState(() {
                       c4=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: c4,
               child: ListTile(title: Text("The applicant click on location icon to set the latitude and longitude of the  wood log. After the location icon is clicked, the applicant will be directed to a  map where the applicant can zoom in or pan to set the latitude and longitude of  the trees. There is a marker on the map which will be displaying the location of  the trees.", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("How to exit from the application ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(d4==false){
                     setState(() {
                       d4=true;
                     });
                   }else{
                     setState(() {
                       d4=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: d4,
               child: ListTile(title: Text("The applicant can click on the logout button which is placed on the top  right corner of the website and can tap on the three lined icon on mobile  application and click on Log out option in left side menu bar on mobile  application. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             Card(child: ListTile(title: Text("In what formats the documents and proofs be attached on TIGRAM ? ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),trailing: IconButton(
                 onPressed: (){
                   if(e4==false){
                     setState(() {
                       e4=true;
                     });
                   }else{
                     setState(() {
                       e4=false;
                     });
                   }
                 },
                 icon: Icon(Icons.arrow_drop_down)
             ),),),
             Card(child:Visibility(
               visible: e4,
               child: ListTile(title: Text("The images of the document in .jpg, .jpeg and .png format can be attached  on TIGRAM. ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),),)),
             ]
           )
         ),
        )
      );
  }
}
