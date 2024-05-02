import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/Inventory_screen.dart';
import 'package:scrap_app/screens/creatProfile_screen.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:scrap_app/screens/profile_page.dart';
import 'package:scrap_app/widget/dark_theams.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? myfole;
  bool isLoding = false;
  Curd _curd = Curd();
  late List profileInfo = [];
  late List userInfo = [];
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  updatImg(img) async {
    isLoding = true;
    setState(() {});

    var respons = await _curd.postRequstWithFile(
        linkupdateImg,
        {
          "user_Id": sharedPref.getString("id") ?? "",
          "imageName":
              "${linkServerName}/upload/${profileInfo[0]["img"].toString().replaceAll('{', '').replaceAll('}', '')}",
        },
        myfole!);

    if (respons["status"] == "success") {
      print(respons["status"]);
      isLoding = false;

      setState(() {});
      (context as Element).reassemble();
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
    }
  }

  readProfile() async {
    isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(
        linkread_profile, {'userId': sharedPref.getString("id") ?? ""});

    if (respons["status"] == "success") {
      // profileInfo = respons["data"];
      // print(profileInfo);
      isLoding = false;
      setState(() {});
      return respons;
    } else {
      isLoding = false;
      setState(() {});
      return null;
    }
  }

  readUser() async {
    isLoding = true;
    setState(() {});
    var respons = await _curd
        .postRequst(linkread_user, {'id': sharedPref.getString("id") ?? ""});

    if (respons["status"] == "success") {
      // userInfo = respons["data"];
      // print(userInfo);
      isLoding = false;
      setState(() {});
      return respons;
    } else {
      isLoding = false;
      setState(() {});
      return null;
    }
  }

// update info
  updatName() async {
    isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(linkupdae_Name, {
      "user_Id": sharedPref.getString("id") ?? "",
      "name": name.text.trim(),
    });
    if (respons["status"] == "success") {
      print(respons["status"]);
      isLoding = false;

      setState(() {});
      (context as Element).reassemble();
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
    }
  }

  updatPhone() async {
    isLoding = true;
    setState(() {});
    var formDate = formstate.currentState;

    if (formDate!.validate()) {
      var respons = await _curd.postRequst(linkupdate_phone, {
        "user_Id": sharedPref.getString("id") ?? "",
        "phone": phone.text.trim(),
      });
      if (respons["status"] == "success") {
        print(respons["status"]);
        isLoding = false;

        setState(() {});
        (context as Element).reassemble();
      } else {
        isLoding = false;

        setState(() {});
        print(respons["status"]);
      }
    }
  }

  updatEmail() async {
    isLoding = true;
    setState(() {});
    var formDate = formstate.currentState;

    if (formDate!.validate()) {
      var respons = await _curd.postRequst(linkupdate_email, {
        "user_Id": sharedPref.getString("id") ?? "",
        "email": email.text.trim(),
      });
      if (respons["status"] == "success") {
        print(respons["status"]);
        isLoding = false;

        setState(() {});
        (context as Element).reassemble();
      } else {
        isLoding = false;

        setState(() {});
        print(respons["status"]);
      }
    }
  }

  updatPassword() async {
    isLoding = true;
    setState(() {});

    var respons = await _curd.postRequst(linkupdateImg, {});
    if (respons["status"] == "success") {
      print(respons["status"]);
      isLoding = false;

      setState(() {});
      (context as Element).reassemble();
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
    }
  }

  // exsistProfile() async {
  //   isLoding = true;
  //   setState(() {});
  //   var respons = await _curd.postRequst(
  //       linkreed_creat_profile, {'id': sharedPref.getString("id") ?? ""});

  //   if (respons["status"] == "success") {
  //     sharedPref.setString("profil", respons['data']['name']);
  //     // print("kkkkkkkkkkkkkkkkkkkkkk");
  //     // print(respons['data']['name']);
  //     // print(respons["status"]);
  //     // print(respons);
  //     return respons;
  //   } else {
  //     isLoding = false;
  //     setState(() {});
  //     return null;
  //   }
  // }

  void initState() {
    super.initState();
//    exsistProfile();
    readProfile();
    readUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (sharedPref.getString("profil") == '')
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("هل لديك صفحة شخصية ؟")),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      (sharedPref.getString("id") == null)
                          ? openDialog0("يجب عليك تسجيل الدخول اولا")
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => creatProfile(
                                    name: '',
                                  )));
                    },
                    color: const Color.fromARGB(208, 255, 255, 255),
                    child: Text("إنشاء صفحة شخصية"),
                  ),
                ),
              ],
            )
          : (isLoding == true)
              ? Center(
                  child: Lottie.asset("assets/Animation - 1706023859153.json"))
              : ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: readProfile(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                  itemCount: snapshot.data['data'].length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                  radius: 85,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 69, 88, 181),
                                                  child: CircleAvatar(
                                                    radius: 80,
                                                    backgroundImage: (snapshot
                                                                .data['data'][i]
                                                                    ['img']
                                                                .toString() !=
                                                            "")
                                                        ? Image.network(
                                                            "${linkServerName}/upload/${snapshot.data['data'][i]['img'].toString()}",
                                                            fit: BoxFit.cover,
                                                          ).image
                                                        : Image.asset(
                                                                'images/i1.jpeg')
                                                            .image,
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "معلومات الحساب",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 69, 88, 181),
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      // await openDialog3(
                                                      //     "",
                                                      //     snapshot.data['data']
                                                      //             [i]['img']
                                                      //         .toString());
                                                      print(
                                                          sharedPref.getString(
                                                                  "profil") ??
                                                              "");
                                                    },
                                                    child:
                                                        Text("تعديل صورة العرض",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            )))
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        await openDialog(
                                                            "تعديل الأسم");
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: Colors.black38,
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${snapshot.data['data'][i]['name'].toString()}',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    " : الأسم",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 69, 88, 181),
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      '${snapshot.data['data'][i]['type'].toString()}',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    " : نوع الحساب",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 69, 88, 181),
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder:
                                                                (_, __, ___) =>
                                                                    profilePage(
                                                              id: snapshot
                                                                  .data['data']
                                                                      [i][
                                                                      'user_Id']
                                                                  .toString(),
                                                            ),
                                                            transitionDuration:
                                                                Duration(
                                                                    seconds: 1),
                                                            transitionsBuilder: (_,
                                                                    a, __, c) =>
                                                                FadeTransition(
                                                                    opacity: a,
                                                                    child: c),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "زيارة الحساب",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            (snapshot.data['data'][i]['type']
                                                        .toString() ==
                                                    "صاحب تشليح")
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                PageRouteBuilder(
                                                                  pageBuilder: (_,
                                                                          __,
                                                                          ___) =>
                                                                      Inventory(
                                                                    name: snapshot
                                                                        .data[
                                                                            'data']
                                                                            [i][
                                                                            'name']
                                                                        .toString(),
                                                                  ),
                                                                  transitionDuration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  transitionsBuilder: (_,
                                                                          a,
                                                                          __,
                                                                          c) =>
                                                                      FadeTransition(
                                                                          opacity:
                                                                              a,
                                                                          child:
                                                                              c),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                                "إدارة المخزون",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                )))
                                                      ],
                                                    ),
                                                  )
                                                : Text(''),
                                            const Divider(
                                              color: Color.fromARGB(
                                                  255, 69, 88, 181),
                                              height: 25,
                                              thickness: 2,
                                              indent: 5,
                                              endIndent: 5,
                                            ),
                                          ],
                                        ));
                                  });
                            }
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Center(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: sharedPref.getBool("mode") ??
                                              "" == true
                                          ? Colors.white
                                          : Colors.black54),
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(),
                                  child: Image(
                                    image: Image.asset('images/i2.jpg').image,
                                  )),
                              Center(
                                child: Text(
                                  "لاتوجد بيانات حاليا",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 69, 88, 181),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                    FutureBuilder(
                        future: readUser(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                  itemCount: snapshot.data['data'].length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "معلومات المستخدم",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 69, 88, 181),
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${snapshot.data['data'][i]['username'].toString()}',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    " : اسم المستخدم",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF4558B5),
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        await openDialog_phone(
                                                            "تعديل الرقم");
                                                      },
                                                      icon: Icon(Icons.edit,
                                                          size: 20,
                                                          color:
                                                              Colors.black38)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${snapshot.data['data'][i]['phone'].toString()}",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    " : رقم الجوال",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF4558B5),
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        await openDialog_email(
                                                            "تعديل البريد الإلكتروني");
                                                      },
                                                      icon: Icon(Icons.edit,
                                                          size: 20,
                                                          color:
                                                              Colors.black38)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${snapshot.data['data'][i]['email'].toString()}',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    " : الإيميل",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF4558B5),
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.edit,
                                                          size: 20,
                                                          color:
                                                              Colors.black38)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "******",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    " : الرقم السري",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            69, 88, 181, 1),
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                          ],
                                        ));
                                  });
                            }
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Center(
                                child: Text(
                                  "....",
                                  style: TextStyle(
                                      color: sharedPref.getBool("mode") ??
                                              "" == true
                                          ? Colors.white
                                          : Colors.black54),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Text(
                              "",
                              style: TextStyle(
                                  color:
                                      sharedPref.getBool("mode") ?? "" == true
                                          ? Colors.white
                                          : Colors.black54),
                            ),
                          );
                        })
                  ],
                ),
    );
  }

  Future openDialog3(
    String title,
    String img,
  ) =>
      showDialog(
        // barrierColor: Colors.w,

        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          //icon:IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.locationCrosshairs),color: Colors.red,),
          title: Center(
            child: Text(
              "${title}",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "ReadexPro",
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: InkWell(
                    onTap: () async {
                      XFile? xFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 512,
                        maxHeight: 512,
                      );
                      myfole = File(xFile!.path);
                      (context as Element).reassemble();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 170.0,
                        width: 170.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: redColor.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Image(
                          image: (myfole != null)
                              ? Image.file(
                                  myfole!,
                                  fit: BoxFit.cover,
                                ).image
                              : Image.asset('images/i1.jpeg').image,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    onPressed: () async {
                      XFile? xFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        maxWidth: 512,
                        maxHeight: 512,
                      );
                      myfole = File(xFile!.path);
                      (context as Element).reassemble();
                    },
                    icon: Icon(Icons.camera),
                    color: redColor.primaryColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90.0),
                        side: BorderSide(color: Colors.white)),
                    color: redColor.primaryColor,
                    onPressed: () async {
                      await updatImg(img);

                      Navigator.pop(context);
                      //   (context as Element).reassemble();
                      // setState(() {});
                    },
                    child: Text(
                      "تعديل",
                      style: TextStyle(
                          fontFamily: "ReadexPro",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Future openDialog(
    String title,
  ) =>
      showDialog(
        // barrierColor: Colors.w,

        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            //icon:IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.locationCrosshairs),color: Colors.red,),
            title: Text(
              "${title}",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "ReadexPro",
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                //key: formstate,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ': تعديل الأسم',
                      style: TextStyle(
                          color: redColor.primaryColor,
                          fontSize: 15,
                          fontFamily: "ReadexPro"),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: TextField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        controller: name,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: redColor.primaryColor)),
                          hintText: " ادخل الأسم",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            side: BorderSide(color: Colors.white)),
                        color: redColor.primaryColor,
                        onPressed: () async {
                          await updatName();
                          Navigator.pop(context);
                          //await updateInfo();
                          // Navigator.of(context).pushReplacementNamed("home");
                        },
                        child: Text(
                          "تعديل",
                          style: TextStyle(
                              fontFamily: "ReadexPro",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
  Future openDialog_email(
    String title,
  ) =>
      showDialog(
        // barrierColor: Colors.w,

        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            //icon:IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.locationCrosshairs),color: Colors.red,),
            title: Text(
              "${title}",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "ReadexPro",
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formstate,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ': تعديل البريد الإلكتروني',
                      style: TextStyle(
                          color: redColor.primaryColor,
                          fontSize: 15,
                          fontFamily: "ReadexPro"),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        validator: (Text) {
                          // if (!(Text!.contains("@gmail.com")||Text!.contains("@hotmail.com")||Text.contains("@outlok.com")) && !Text.contains('/') && !Text.contains('#')) {
                          //   return "البريد الإلكتروني غير صحيح";
                          // }
                          // return null;
                        },
                        controller: email,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: redColor.primaryColor)),
                          hintText: " ادخل البريد الإلكتروني",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            side: BorderSide(color: Colors.white)),
                        color: redColor.primaryColor,
                        onPressed: () async {
                          await updatEmail();
                          Navigator.pop(context);
                          //await updateInfo();
                          // Navigator.of(context).pushReplacementNamed("home");
                        },
                        child: Text(
                          "تعديل",
                          style: TextStyle(
                              fontFamily: "ReadexPro",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
  // Future p(
  //   String title,
  // ) =>
  //     showDialog(
  //       // barrierColor: Colors.w,

  //       context: context,
  //       builder: (context) => AlertDialog(
  //           backgroundColor: Colors.white,
  //           //icon:IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.locationCrosshairs),color: Colors.red,),
  //           title: Text(
  //             "${title}",
  //             style: TextStyle(
  //                 color: Colors.black54,
  //                 fontFamily: "ReadexPro",
  //                 fontWeight: FontWeight.bold),
  //             textAlign: TextAlign.right,
  //           ),
  //           content: SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Form(
  //               autovalidateMode: AutovalidateMode.always,
  //               //key: formstate,
  //               child: Column(
  //                 //mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     ': تعديل الرقم',
  //                     style: TextStyle(
  //                         color: redColor.primaryColor,
  //                         fontSize: 15,
  //                         fontFamily: "ReadexPro"),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   Center(
  //                     child: TextField(
  //                       controller: phone,
  //                       decoration: InputDecoration(
  //                         focusedBorder: UnderlineInputBorder(
  //                             borderSide:
  //                                 BorderSide(color: redColor.primaryColor)),
  //                         hintText:
  //                             " ادخل الرقم", //hintStyle: TextStyle(  fontStyle: te),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Center(
  //                     child: MaterialButton(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(90.0),
  //                           side: BorderSide(color: Colors.white)),
  //                       color: redColor.primaryColor,
  //                       onPressed: () async {
  //                         await updatPhone();
  //                         Navigator.pop(context);
  //                         //await updateInfo();
  //                         // Navigator.of(context).pushReplacementNamed("home");
  //                       },
  //                       child: Text(
  //                         "تعديل",
  //                         style: TextStyle(
  //                             fontFamily: "ReadexPro",
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.white,
  //                             fontSize: 18),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )),
//      );
  Future openDialog_phone(
    String title,
  ) =>
      showDialog(
        // barrierColor: Colors.w,

        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            //icon:IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.locationCrosshairs),color: Colors.red,),
            title: Text(
              "${title}",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "ReadexPro",
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formstate,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ': تعديل الرقم ',
                      style: TextStyle(
                          color: redColor.primaryColor,
                          fontSize: 15,
                          fontFamily: "ReadexPro"),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        validator: (Text) {
                          if (Text!.length > 10 ||
                              Text.length < 10 ||
                              !Text.startsWith("05")) {
                            return "لايمكن ان لا يكون الرقم اقل او اكثر من ${10}";
                          }
                          return null;
                        },
                        controller: phone,
                        keyboardType:
                            TextInputType.number, // controller: location,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: redColor.primaryColor)),
                          hintText: "ادخل الرقم",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            side: BorderSide(color: Colors.white)),
                        color: redColor.primaryColor,
                        onPressed: () async {
                          await updatPhone();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "تعديل",
                          style: TextStyle(
                              fontFamily: "ReadexPro",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
  Future openDialog0(
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Logine()));
                                  // prefManager = await SharedPreferences.getInstance();
                                  // await prefManager.clear();
                                  // SharedPreferences preferences = await SharedPreferences.getInstance();
                                  //   await preferences.clear();
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
