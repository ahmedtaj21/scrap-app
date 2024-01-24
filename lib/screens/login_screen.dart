

import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/signup_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';


import '../component/crud.dart';
import '../constant/linkApi.dart';

import '../widget/customtextform.dart';
import 'home_screen.dart';

class Logine extends StatefulWidget {
  const Logine({super.key});

  @override
  State<Logine> createState() => _LogineState();
}

class _LogineState extends State<Logine> {
   void initState(){
    super.initState();
  
    // FirebaseMessaging.instance.getToken().then((value) {
    //     print("**********************************************************************************");
    //     print(value);
    //     String? token=value;
    //   });

    // setState(() {
      
    // });
  }
  Future openDialog(String title,String object) => showDialog(
      context:context,
      builder: (context) => AlertDialog(
                 title: Text("${title}",style: TextStyle(fontFamily: "ReadexPro",fontWeight: FontWeight.bold ),
              textAlign: TextAlign.right,),
        content:   SizedBox(
                  width: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                    
                      Text("${object}",style: TextStyle(color: redColor.primaryColor,fontFamily: "ReadexPro"),
              textAlign: TextAlign.right,),
              MaterialButton(
                color: redColor.primaryColor,
                onPressed: (){
                  Navigator.pop(context);
                  }, 
              child:
              
                 Text("حسنا",style: TextStyle(fontFamily: "ReadexPro",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            
               
              ),

             
                      ],
                    ),
                  ),
                ),
          ),);
GlobalKey<FormState> formstate=GlobalKey();
bool isLoding=false;

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
    Curd _curd = Curd();
    // void gettoken(){
    //   FirebaseMessaging.instance.getToken().then((value) {
    //     print("**********************************************************************************");
    //     print(value);
    //     String? token=value;
    //   });
    //   //super.gettoken();
    // }
 login() async {
   
   isLoding=true;
   setState(() {
     
   });
         var respons = await _curd.postRequst(linklogin, {
      "username":
      //"7015",
      email.text.trim().toString(),
      "password":password.text.trim().toString(),
    });
     if(respons["status"] == "success"){
      sharedPref.setString("id", respons['data']['id'].toString());
      
      sharedPref.setString("phone", respons['data']['phone']);
      sharedPref.setString("username", respons['data']['username']);
      sharedPref.setString("email", respons['data']['email']);
   Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context) => home()));
    // Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    }  else{
      isLoding=false;
   setState(() {
     
   });
        openDialog("!تنبية","الرقم السري او اسم المستخدم  غير صحيح الرجاء المحاولة مرة اخرى");

     }
    
  
  }
//  update_token() async {
   
//    isLoding=true;
//    setState(() {
     
//    });
//          var respons = await _curd.postRequst(linkupdate_token, {
//       "username":
//       //"7015",
//       email.text.trim().toString(),
//       "token":sharedPref.getString("token") ?? "",
//     });
//      if(respons["status"] == "success"){
  
//     }  else{
//        //  print("****//token//****");
    
//     print(sharedPref.getString("token") ?? "");
//       isLoding=false;
//    setState(() {
     
//    });
//       //  openDialog("!تنبية","لن يمكنك إستقبال الإشعارات من تطبيق افراحي على هذا الجهاز قم بإعادة تسجيل الدخول أو تغيير الجهاز في حال رغبتك في تلقي الإشعارات من افراحي");
//       // print(object)

//      }
    
  
//   }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => await openDialog2("هل ترغب بلخروج حقا ؟"),
      child: Scaffold(
        backgroundColor:  sharedPref.getBool("mode") ?? ""==true? darktheam.primaryColor:Colors.white,
        body: (isLoding==true)?Center(child: CircularProgressIndicator(),):
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              padding: EdgeInsets.all(15),
              child: ListView(
    
                children:[
                   Form(
                  child: SingleChildScrollView(
                     scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                      //  Padding(
                      //    padding: const EdgeInsets.all(8.0),
                      //    child: Container(child: Image.asset("images/i11.png")),
                      //  ),
                      Image.asset("images/i4.jpeg"),
                  //   sharedPref.getBool("mode") ?? ""==true? Image.asset("images/i13.png") :Image.asset("images/i14.jpeg"),
                      customTextform(hint: 'username',myControl: email, obscure: false,  maxLength: 5, formChoose: 0, labelText: 'اسم المستخدم',),
                         customTextform(hint: 'password',myControl: password, obscure: true,  maxLength: 8, formChoose: 1, labelText: 'كلمة المرور',),
                         SizedBox(height: 7,),
                         Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: MaterialButton(
                            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                    ),
                            padding: EdgeInsets.symmetric(horizontal: 100,vertical: 14),
                            color: sharedPref.getBool("mode") ?? ""==true?Color.fromARGB(255, 230, 52, 52):redColor.primaryColor,
                            onPressed: () async{
                            await login();
                           //************await update_token();
                           },
                           child:Text("تسجيل دخول",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "ReadexPro"))
                           ),
                           
                         ),
                         SizedBox(height: 5,),
                         Text("ليس لديك حساب  ؟",style: TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black45,fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "ReadexPro"),textAlign: TextAlign.center,),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                               Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => signup( )));        
                            },
                         
                            child: Text("تسجيل جديد",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18,fontFamily: "ReadexPro")))
                       
                      ],
                    ),
                  ),
                ),
                ]
              ),
            ),
          ),
       
      ),
    );
  }
    Future openDialog2(String title,) => showDialog(
      context:context,
      builder: (context) => AlertDialog(
                 title: Center(
                   child: Text("${title}",style: TextStyle(fontFamily: "ReadexPro",fontWeight: FontWeight.bold ),
                               textAlign: TextAlign.right,),
                 ),
        content:   SizedBox(
                  width: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                   

            
                   
                  
                    SizedBox(height: 10,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90.0),
                              side: BorderSide(color: Colors.white)
                            ),
                         color: redColor.primaryColor,
                          onPressed: ()async{
                   
                            Navigator.pop(context);
                            }, 
                    child:
                    
                           Text("إلغاء",style: TextStyle(fontFamily: "ReadexPro",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                                  
                         
                    ),
                    SizedBox(width: 10,),
                         MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90.0),
                              side: BorderSide(color: Colors.white)
                            ),
                          color: redColor.primaryColor,
                          onPressed: ()async{
                   
                            //  Navigator.of(context).push(MaterialPageRoute(
                            //                   builder: (context) => Logine()));
                                              // prefManager = await SharedPreferences.getInstance();
                                              // await prefManager.clear();
                                              // SharedPreferences preferences = await SharedPreferences.getInstance();
                                              //   await preferences.clear();
                                                exit(0);
                            }, 
                    child:
                    
                           Text("نعم",style: TextStyle(fontFamily: "ReadexPro",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                                  
                         
                    ),
                       ],
                     ),
               
                 
               

             
                      ],
                    ),)

                    ),
                    )
                    );
}