import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:scrap_app/screens/verfiy_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';
// ignore: unused_import

import '../constant/linkApi.dart';
import '../main.dart';
import '../widget/customtextform.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  //***************** */  final _auth = FirebaseAuth.instance;

  Future openDialog(String title, String object) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "${title}",
            style:
                TextStyle(fontFamily: "ReadexPro", fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          content: SizedBox(
            width: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(
                    "${object}",
                    style: TextStyle(
                        color: redColor.primaryColor, fontFamily: "ReadexPro"),
                    textAlign: TextAlign.right,
                  ),
                  MaterialButton(
                    color: redColor.primaryColor,
                    onPressed: () {
                      isLoding = false;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      "حسنا",
                      style: TextStyle(
                          fontFamily: "ReadexPro",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoding = false;
  bool navigat = false;
  Curd _curd = Curd();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  String dropdownValue2 = 'مستخدم';

  signup() async {
    isLoding = true;
    setState(() {});
    var formDate = formstate.currentState;
    if (password.text == password2.text) {
      if (formDate!.validate()) {
        var respons = await _curd.postRequst(linkSingUp, {
          "username": username.text.trim(),
          "email": email.text.trim(),
          "password": password.text.trim(),
          "phone": phone.text.trim(),
          "user_type":dropdownValue2
        });
        if (respons == null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => verfiy_screen(
                    email: email.text.trim(),
                    username: username.text.trim(),
                  )));

          print(respons["status"]);
        } else {
          openDialog("!تنبية",
              "اسم المستخدم تم استخدامة من قبل الرجاء المحاولة مرة اخرى");
          isLoding = false;

          setState(() {});
        }
      }
    } else {
      openDialog("!تنبية", "الرقم السري غير متطابق");

      //  return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await openDialog2("هل ترغب بلخروج حقا ؟"),
      child: Scaffold(
        backgroundColor:  Colors.white,
        body: (isLoding == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: ListView(children: [
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: formstate,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Image.asset("images/i6.jpg"),
                            // sharedPref.getBool("mode") ?? ""==true? Image.asset("images/i16.jpg") :Image.asset("images/i15.jpg"),
                            //Text("افراحي",style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "ReadexPro"),),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  //  child: Text(".اهلا وسهلا بكم",style: TextStyle(color: sharedPref.getBool("mode") ?? ""==true? const Color.fromARGB(255, 233, 60, 60): Colors.black87,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "ReadexPro"),),
                                  ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "مرحبا بكم في تشاليح التطبيق الذي يسهل لكم البحث عن قطع الغيار",
                                  style: TextStyle(
                                      color: sharedPref.getBool("mode") ??
                                              "" == true
                                          ? Colors.white
                                          : Colors.black45,
                                      fontSize: 17,
                                      fontFamily: "ReadexPro"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            // Image.asset("images/i5.png"),
                            customTextform(
                              hint: 'ahmed55',
                              myControl: username,
                              obscure: false,
                              maxLength: 4,
                              formChoose: 0,
                              labelText: 'اسم المستخدم',
                            ),
                            customTextform(
                              hint: 'email@gmail.com',
                              myControl: email,
                              obscure: false,
                              maxLength: 15,
                              formChoose: 3,
                              labelText: 'الإيميل',
                            ),
                            customTextform(
                              hint: '05xxxxxxxx',
                              myControl: phone,
                              obscure: false,
                              maxLength: 10,
                              formChoose: 2,
                              labelText: 'رقم الجوال',
                            ),
                            customTextform(
                              hint: 'password',
                              myControl: password,
                              obscure: false,
                              maxLength: 8,
                              formChoose: 1,
                              labelText: 'الرقم السري',
                            ),
                            customTextform(
                              hint: 'password',
                              myControl: password2,
                              obscure: false,
                              maxLength: 8,
                              formChoose: 4,
                              labelText: 'تأكيد الرقم السري',
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                   borderRadius: BorderRadius.circular(10),
                                   border: Border.all(color:Colors.black87 )
                                   ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                        // Step 3.
                                        hint: Text(
                                          "${dropdownValue2}",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 69, 88, 181)),
                                        ),
                                      
                                        //  value: dropdownValue3,
                                        dropdownColor: Color.fromARGB(255, 69, 88, 181),
                                        // Step 4.
                                    
                                        items: <String>[
                                          'مستخدم',
                                          'صاحب تشليح',
                                        ].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                    
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue2 = newValue!;
                                          });
                                          (context as Element).reassemble();
                                        },
                                      ),
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Text(": نوع الحساب",style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 69, 88, 181)),),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)),
                                  color:
                                      sharedPref.getBool("mode") ?? "" == true
                                          ? Color.fromARGB(255, 230, 52, 52)
                                          : redColor.primaryColor,
                                  onPressed: () async {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //           builder: (context) => verfiy_screen(email: email.text.trim(),)));
                                    // print(formstate.currentState?.validate());
                                    if (formstate.currentState?.validate() ==
                                        true) {
                                      await signup();
                                    } else {
                                      openDialog("!حدث خطأ ما",
                                          "تأكد من إدخال البيانات بصورة صحيحة");
                                    }
                                  },
                                  child: Text("تسجيل جديد",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: "ReadexPro"))),
                            ),
                            //SizedBox(height:5,),
                            Text(
                              "هل لديك حساب بلفعل ؟",
                              // style: TextStyle(
                              //color: sharedPref.getBool("mode") ?? ""==true?Colors.white: Colors.black45,fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "ReadexPro"),textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  //Navigator.of(context).pushReplacementNamed("Logine");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Logine()));
                                },
                                child: Text("تسجيل دخول",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "ReadexPro")))
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
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
                                  // SharedPreferences preferences = await SharedPreferences.getInstance();
                                  //   await preferences.clear();
                                  exit(0);
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
