import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scrap_app/screens/home_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';

import '../component/crud.dart';
import '../constant/linkApi.dart';
import '../main.dart';
import '../widget/customtextform.dart';
class verfiy_screen extends StatefulWidget {
  final String email;
  final String username;
  const verfiy_screen({super.key, required this.email, required this.username});

  @override
  State<verfiy_screen> createState() => _verfiy_screenState();
}

class _verfiy_screenState extends State<verfiy_screen> {
  TextEditingController verfiyCode=TextEditingController();
  TextEditingController verfiyCode1=TextEditingController();
  TextEditingController verfiyCode2=TextEditingController();
  TextEditingController verfiyCode3=TextEditingController();
    bool isLoding=false;

  Curd _curd = Curd();



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
                  isLoding=false;
              setState(() {
                
              });
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
  verfiy() async {
   
   isLoding=true;
   setState(() {
     
   });
         var respons = await _curd.postRequst(linkVerfiy, {
      "verifayCode":'${verfiyCode.text}${verfiyCode1.text}${verfiyCode2.text}${verfiyCode3.text}',
     // "2673",
      //verfiyCode.text.trim().toString(),
      "username":widget.username.toString(),
      "email":
      widget.email.toString(),
    });
   // print(widget.email);
    if(respons["status"] == "success"){
     //  print(respons["status"]);
    
      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => home(index: 2,)));
    // Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
     print(respons['data']['id']);
        sharedPref.setString("id", respons['data']['id'].toString());
          sharedPref.setString("profil", '');
          sharedPref.setString("user_type", respons['data']['user_type']);
        sharedPref.setString("phone", respons['data']['phone']);
        sharedPref.setString("username", respons['data']['username']);
        sharedPref.setString("email", respons['data']['email']);
    } 
     else{
      print('the code should exeute ##############');
           isLoding=false;
   setState(() {
     
   });
        openDialog("كود التحقق خاطئ","الرجاء التحقق من إدخال الكود الصحيح");
 
    }
    
  
  }
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: ()async => await openDialog2("هل ترغب بلخروج حقا ؟"),
      child: Scaffold(
  //  backgroundColor: sharedPref.getBool("mode") ?? ""==true? darktheam.primaryColor:Colors.white,
      body:(isLoding==true)?Center(child:CircularProgressIndicator()):
    
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              SizedBox(height: 40,),
              Text(":تم ارسال كود تحقق ",style: TextStyle(color: redColor.primaryColor,fontSize: 20,fontFamily: "ReadexPro"),),
              SizedBox(height: 10,),
              Text(widget.email.toString(),style: TextStyle(color:sharedPref.getBool("mode") ?? ""==true?Colors.white: Colors.black45,fontWeight: FontWeight.bold,fontSize: 18)),
              SizedBox(height: 5,),
             
             Form(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color:  sharedPref.getBool("mode") ?? ""==true? darktheam.primaryColor:Colors.white,),
                        
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:       TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1)
                        ],
                      onChanged: ((value) {
                        if(value.length==1){
                          FocusScope.of(context).nextFocus();
                        }
                        // if(value.length<1){
                        //   FocusScope.of(context).previousFocus();
                        // }
                        
                      }),
                     // maxLength: 1,
                     style: TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                      //TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                       textAlign: TextAlign.center,
                     keyboardType: TextInputType.number,
                      controller: verfiyCode,
                     //textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  redColor.primaryColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redColor.primaryColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                             
                     
                      ),
                     ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color:  sharedPref.getBool("mode") ?? ""==true? darktheam.primaryColor:Colors.white,),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:       TextFormField(
                          inputFormatters: [
                          LengthLimitingTextInputFormatter(1)
                        ],
                         onChanged: ((value) {
                           if(value.length==1){
                          FocusScope.of(context).nextFocus();
                        }
                        //    if(value.length<1){
                        //   FocusScope.of(context).previousFocus();
                        // }
                      }),
                     // maxLength: 1,
                       style: TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                      //TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                       textAlign: TextAlign.center,
                     keyboardType: TextInputType.number,
                      controller: verfiyCode1,
                     //textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  redColor.primaryColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redColor.primaryColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                             
                     
                      ),
                     ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                         border: Border.all(color:  sharedPref.getBool("mode") ?? ""==true? darktheam.primaryColor:Colors.white,),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:       TextFormField(
                          inputFormatters: [
                          LengthLimitingTextInputFormatter(1)
                        ],
                         onChanged: ((value) {
                            if(value.length==1){
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                     // maxLength: 1,
                     style: TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                      //TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                       textAlign: TextAlign.center,
                     keyboardType: TextInputType.number,
                      controller: verfiyCode2,
                     //textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  redColor.primaryColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redColor.primaryColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                             
                     
                      ),
                     ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                         border: Border.all(color:  sharedPref.getBool("mode") ?? ""==true? darktheam.primaryColor:Colors.white,),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:       TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1)
                        ],
                     // maxLength: 1,
                      style: TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                      //TextStyle(color:sharedPref.getBool("mode") ?? ""==true? Colors.white: Colors.black,),
                       textAlign: TextAlign.center,
                     keyboardType: TextInputType.number,
                      controller: verfiyCode3,
                     //textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  redColor.primaryColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redColor.primaryColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                             
                     
                      ),
                     ),
                    ),
                  ],
                ),
              )
             
             
             ),
            
           
                SizedBox(height: 20,),
               MaterialButton(
                                shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white)
                        ),
                                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                                color: redColor.primaryColor,
                                onPressed: () async{
                             await verfiy();
                        
                               },
                               child:Text("تحقق",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20))
                               ),
             ],
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