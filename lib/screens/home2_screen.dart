import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/allOrder_screen.dart';
import 'package:scrap_app/screens/chat_screen.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:scrap_app/screens/profile_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  @override
    Curd _curd = Curd();
    exsistProfile() async {
  //  isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(
        linkreed_creat_profile, {'id': sharedPref.getString("id") ?? ""});

    if (respons["status"] == "success") {
      sharedPref.setString("profil", respons['data']['name']);
      // print("kkkkkkkkkkkkkkkkkkkkkk");
      // print(respons['data']['name']);
      // print(respons["status"]);
      // print(respons);
    //  return respons;
    } else {
    //  isLoding = false;
      // setState(() {});
      // return null;
    }
  }
    void initState() {
    super.initState();
    exsistProfile();

  }
  int index = 1;
    final screen = [  
    chat(),
    profile(),
  ];
  //   void _launchURL({required String url}) async => await canLaunch(url)
  //     ? await launch(url,
  //         forceSafariVC: true, forceWebView: false, enableJavaScript: true)
  //     : throw 'Could not launch $url';
  //       Future openBroeser({
  //   required String url,
  //   bool inApp = false,
  // }) async {
  //   if (await canLaunch(url)) {
  //     await launch(url,
  //         forceSafariVC: inApp, forceWebView: inApp, enableJavaScript: true);
  //   }
  // }
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.chat,
        size: 30,
        color: Colors.white 
        //color: Color.fromARGB(254, 140, 169, 193) ,
      ),
      Icon(
        Icons.person,
        size: 30,
        color: Colors.white 
        //color: Color.fromARGB(254, 140, 169, 193) ,
      ),
    ];
  
    return Scaffold(
        drawer: Drawer(
        
        child: Container(
         color:Colors.white,
          //color:Color.fromARGB(164, 140, 169, 193) ,
          child: ListView(
            
            children: [
               SizedBox(height: 20,),
          
                      Container(
                        decoration: BoxDecoration(
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image:Image.asset('images/i5.jpeg').image ,),
                        ) 
                      ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        //    SizedBox(height: 10,),
            
                              InkWell(
                                onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => allOrder()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                                                  
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("الطلبات العامة", style: TextStyle(color: Colors.black ,fontWeight:FontWeight.bold, fontSize: 20),),
                                    ),
                                  ],
                                )),
                                SizedBox(height: 5,),
                                // InkWell(
                                // onTap: () {
                                  
                                // },
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Text("إدارة الحساب", style: TextStyle(color: Colors.black , fontSize: 20,fontWeight:FontWeight.bold),),
                                //     ),
                                //   ],
                                // )),
                                // SizedBox(height: 5,),
                              InkWell(
                                onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Logine()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.signIn),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("تسجيل الدخول", style: TextStyle(color: Colors.black ,fontWeight:FontWeight.bold, fontSize: 20),),
                                    ),
                                  ],
                                )),
                                SizedBox(height: 5,),
                              InkWell(
                                onTap: () {
                                  openDialog2("هل تريد الخروج حقا ؟"); 
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.signOut,color: Colors.red[700],),
                                    //Icon(Icons.out),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("تسجيل خروج", style: TextStyle(color: Colors.red[700] ,fontWeight:FontWeight.bold, fontSize: 20),),
                                    ),
                                  ],
                                )),
                                  SizedBox(height: 5,),
                                      InkWell(
                                onTap: () {
                                  
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("الشروط والأحكام", style: TextStyle(color: Colors.black , fontSize: 20,fontWeight:FontWeight.bold),),
                                    ),
                                  ],
                                )),
                                SizedBox(height: 20,),
                                  const Divider(
                                          color:  Color.fromARGB(255, 69, 88, 181),
                                          height: 25,
                                          thickness: 2,
                                          indent: 5,
                                          endIndent: 5,
                                        ),
                                        SizedBox(height: 10,),
                                        Text("تواصل معنا", style: TextStyle(color: Color.fromARGB(255, 69, 88, 181) , fontSize: 20,fontWeight:FontWeight.bold),),
                                          SizedBox(height: 10,),
                               Padding(
                                 padding: const EdgeInsets.all(0.0),
                                 child: InkWell(
                                                   onTap: ()async{
                                                    // final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";
                                                 
                                                    //         _launchURL(url: url);
                                                    
                                                   },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         IconButton(onPressed: (){
                                                          //     final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";
                                                 
                                                          //   _launchURL(url: url);
                                                         }, icon: FaIcon(FontAwesomeIcons.whatsapp),color:const Color.fromARGB(255, 55, 127, 57),),
                                                        
                                                         Text("0544206594",style: TextStyle( color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "ReadexPro"),),
                                                        SizedBox(width: 20,)
                                                       ],
                                                      ),
                                                    ),
                                                  ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(0.0),
                                 child: InkWell(
                                                   onTap: ()async{
                                                    // final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";
                                                 
                                                    //         _launchURL(url: url);
                                                    
                                                   },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         IconButton(onPressed: (){
                                                          //     final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";
                                                 
                                                          //   _launchURL(url: url);
                                                         }, icon: FaIcon(FontAwesomeIcons.instagram),color:Colors.purpleAccent,),
                                                        
                                                         Text("tshalih",style: TextStyle( color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "ReadexPro"),),
                                                        SizedBox(width: 20,)
                                                       ],
                                                      ),
                                                    ),
                                                  ),
                               ),
                            ],
                          )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor:Color.fromARGB(255, 69, 88, 181) ,
        title:(index==0)?Text(
          "المحادثات",
          style: TextStyle(color: Colors.white , fontSize: 25),
        ):Text(
          "الصفحة الشخصية    ",
          style: TextStyle(color: Colors.white , fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: screen[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 69, 88, 181),
        //color: Color.fromARGB(255, 226, 240, 250),
        items: items,
        height: 60,
        index: index,
        onTap: (index) => setState(
          () => this.index = index,
        ),
      ),
    );
  }
   Future openDialog2(String title,) => showDialog(
      context:context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
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
                                              SharedPreferences preferences = await SharedPreferences.getInstance();
                                                await preferences.clear();
                                                 Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => MyApp()));
                                                //exit(0);
                            }, 
                    child:
                    
                           Text("نعم",style: TextStyle(fontFamily: "ReadexPro",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                                  
                         
                    ),
                       ],
                     ),
               
                 
               

             
                      ],
                    ),)

                    ),));
}
