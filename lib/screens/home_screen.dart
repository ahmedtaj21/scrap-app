
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scrap_app/screens/allOrder_screen.dart';
import 'package:scrap_app/screens/chat_screen.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:scrap_app/screens/offer_screen.dart';
import 'package:scrap_app/screens/order_screen.dart';
import 'package:scrap_app/screens/profile_screen.dart';
import 'package:scrap_app/screens/search_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}
   String result = "";

class _homeState extends State<home> {
  int index = 2;
  @override
  final screen = [
    order(),
    offer(),
    search(),
    chat(),
    profile(),
  ];
  Widget build(BuildContext context) {
    
    final items = <Widget>[
      Icon(
        Icons.add_box,
        size: 30,
        color: Colors.white ,
      //  color: Color.fromARGB(254, 140, 169, 193) ,
      ),
      Icon(
        Icons.local_offer,
        size: 30,
        //color: Color.fromARGB(254, 140, 169, 193) ,
        color: Colors.white 
      ),
      Icon(
        Icons.search,
        size: 30,
        color: Colors.white 
        //color: Color.fromARGB(254, 140, 169, 193) ,
      ),
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
      extendBody: true,
      drawer: Drawer(
        
        //backgroundColor: Color.fromARGB(164, 140, 169, 193),
        child: Container(
          color:Color.fromARGB(234, 255, 255, 255),
          //color:Color.fromARGB(164, 140, 169, 193) ,
          child: ListView(
            
            children: [
              // SizedBox(height: 20,),
          
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
                                  
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("إدارة الحساب", style: TextStyle(color: Colors.black , fontSize: 20,fontWeight:FontWeight.bold),),
                                    ),
                                  ],
                                )),
                                SizedBox(height: 5,),
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
                              InkWell(
                                onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Logine()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("تسجيل الدخول", style: TextStyle(color: Colors.black ,fontWeight:FontWeight.bold, fontSize: 20),),
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
                                      child: Text("الإعدادات", style: TextStyle(color: Colors.black ,fontWeight:FontWeight.bold, fontSize: 20),),
                                    ),
                                  ],
                                )),
                            ],
                          )
            ],
          ),
        ),
      ),
      appBar: AppBar(
          shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),),
        foregroundColor: Colors.white,
      //  foregroundColor: Color.fromARGB(254, 140, 169, 193) ,
        //backgroundColor: Color.fromARGB(255, 226, 240, 250),
        backgroundColor: Color.fromARGB(255, 69, 88, 181),
        toolbarHeight: 60,
        title:(index==0)? Text(
          "الطلبات",
          style: TextStyle(color: Colors.white , fontSize: 25),
        ):(index==1)?Text(
          "العروض",
          style: TextStyle(color: Colors.white , fontSize: 25),
        ):(index==2)?
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            
            child: Card(
                    
                    elevation: 20,
                     shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.white,
                      child: TextField(
                        
                         keyboardType:TextInputType.text,
                         textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          
                         
                          prefixIcon: Icon(Icons.search,color: redColor.primaryColor),
                          hintText: ' ابحث عن تشليح   ',
                         border: UnderlineInputBorder(
                          
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color:  redColor.primaryColor, width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                focusedBorder: OutlineInputBorder(
                                  
                                    borderSide: BorderSide(color: redColor.primaryColor, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                        ),
                    
                       
                        onChanged: (String str){
                              setState((){
                                result = str;
                                (context as Element).reassemble();
                              });
                            }
                      ),
                    ),
          ),
       )
        :(index==3)?Text(
          "المحادثات",
          style: TextStyle(color: Colors.white , fontSize: 25),
        ):Text(
          "الصفحة الشخصية    ",
          style: TextStyle(color: Colors.white , fontSize: 25),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 246, 246, 247),
      // Color.fromARGB(255, 103, 140, 171)
      //,
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
}
