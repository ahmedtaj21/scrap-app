import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/allOrder_screen.dart';
import 'package:scrap_app/screens/chat_screen.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:scrap_app/screens/offer_screen.dart';
import 'package:scrap_app/screens/order_screen.dart';
import 'package:scrap_app/screens/profile_screen.dart';
import 'package:scrap_app/screens/search_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  int index ;
   home({super.key, required this.index});

  @override
  State<home> createState() => _homeState();
}

String result = "";

class _homeState extends State<home> {
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
    sharedPref.setString("part", '');
  }
  // int index = 2;
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
        color: Colors.white,
        //  color: Color.fromARGB(254, 140, 169, 193) ,
      ),
      Icon(Icons.local_offer,
          size: 30,
          //color: Color.fromARGB(254, 140, 169, 193) ,
          color: Colors.white),
      Icon(Icons.search, size: 30, color: Colors.white
          //color: Color.fromARGB(254, 140, 169, 193) ,
          ),
      Icon(Icons.chat, size: 30, color: Colors.white
          //color: Color.fromARGB(254, 140, 169, 193) ,
          ),
      Icon(Icons.person, size: 30, color: Colors.white
          //color: Color.fromARGB(254, 140, 169, 193) ,
          ),
    ];
    return Scaffold(
      extendBody: true,
      drawer: Drawer(
        //backgroundColor: Color.fromARGB(164, 140, 169, 193),
        child: Container(
          color: Colors.white,
          //color:Color.fromARGB(164, 140, 169, 193) ,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: Image.asset('images/i5.jpeg').image,
                    ),
                  )),
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
                            child: Text(
                              "الطلبات العامة",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Logine()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.signIn),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        openDialog2("هل تريد الخروج حقا ؟");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.signOut,
                            color: Colors.red[700],
                          ),
                          //Icon(Icons.out),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "تسجيل خروج",
                              style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        print(sharedPref.getString("profil"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "الشروط والأحكام",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 69, 88, 181),
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "تواصل معنا",
                    style: TextStyle(
                        color: Color.fromARGB(255, 69, 88, 181),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      onTap: () async {
                        // final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";

                        //         _launchURL(url: url);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                //     final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";

                                //   _launchURL(url: url);
                              },
                              icon: FaIcon(FontAwesomeIcons.whatsapp),
                              color: const Color.fromARGB(255, 55, 127, 57),
                            ),
                            Text(
                              "0544206594",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ReadexPro"),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      onTap: () async {
                        // final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";

                        //         _launchURL(url: url);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                //     final  url="https://api.whatsapp.com/send/?phone=966544206594&text&type=phone_number&app_absent=0";

                                //   _launchURL(url: url);
                              },
                              icon: FaIcon(FontAwesomeIcons.instagram),
                              color: Colors.purpleAccent,
                            ),
                            Text(
                              "tshalih",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ReadexPro"),
                            ),
                            SizedBox(
                              width: 20,
                            )
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 69, 88, 181),
        toolbarHeight: 60,
        title: (widget.index == 0)
            ? Text(
                "الطلبات",
                style: TextStyle(color: Colors.white, fontSize: 25),
              )
            : (widget.index == 1)
                ? Text(
                    "العروض",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                : (widget.index == 2)
                    ? Padding(
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
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search,
                                      color: redColor.primaryColor),
                                  hintText: ' ابحث عن تشليح   ',
                                  hintStyle: TextStyle(color: Color.fromARGB(255, 69, 88, 181)),
                                  border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: redColor.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: redColor.primaryColor,
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                                onChanged: (String str) {
                                  setState(() {
                                    result = str;
                                    (context as Element).reassemble();
                                  });
                                }),
                          ),
                        ),
                      )
                    : (widget.index == 3)
                        ? Text(
                            "المحادثات",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        : Text(
                            "الصفحة الشخصية    ",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 246, 246, 247),
      // Color.fromARGB(255, 103, 140, 171)
      //,
      body: screen[widget.index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 69, 88, 181),
        //color: Color.fromARGB(255, 226, 240, 250),
        items: items,
        height: 60,
        index: widget.index,
        onTap: (index) => setState(
          () => this.widget.index = index,
        ),
      ),
    );
  }

  Future openDialog2(
    String title,
  ) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
                title: Center(
                  child: Text(
                    "${title}",
                    style: TextStyle(
                        fontFamily: "ReadexPro", fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
                content: SizedBox(
                    width: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                    side: BorderSide(color: Colors.white)),
                                color: redColor.primaryColor,
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                      fontFamily: "ReadexPro",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                    side: BorderSide(color: Colors.white)),
                                color: redColor.primaryColor,
                                onPressed: () async {
                                  //  Navigator.of(context).push(MaterialPageRoute(
                                  //                   builder: (context) => Logine()));
                                  // prefManager = await SharedPreferences.getInstance();
                                  // await prefManager.clear();
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MyApp()));
                                  //exit(0);
                                },
                                child: Text(
                                  "نعم",
                                  style: TextStyle(
                                      fontFamily: "ReadexPro",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ));
}
