import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'package:http/http.dart' as http;

class allOrder extends StatefulWidget {
  const allOrder({super.key});

  @override
  State<allOrder> createState() => _allOrderState();
}

class _allOrderState extends State<allOrder> {
  File? myfole;
  TextEditingController contant = TextEditingController();
  bool isLoding = false;
  Curd _curd = Curd();
  late List listOfTokens = [];

  final String serverToken =
      'AAAA8PMN14I:APA91bHFsIavFUR81FmgzbOJMRrxhlwYbXio3EEtMOshDPsePJoaTsV0SRYgkFwLL1tiGXdFmrAoTpAWzZBNpepfwKsTkNqShUjikf7EESrYaSyvhkZ0XzV78gu1cjyNPDnyShUFhbJb';

  readOrder() async {
    setState(() {});
    var respons = await _curd.postRequst(linkallOrder, {});

    if (respons["status"] == "success") {
      return respons;
    } else {
      return null;
    }
  }

  sendOffer(id, orderId, toke) async {
    setState(() {});
    var respons = await _curd.postRequst(linksend_offer, {
      "userId": id,
      "offer_description": contant.text.trim(),
      "token": sharedPref.getString("token") ?? "",
      "orderId": orderId
    });

    if (respons["exsist"] == "yes") {
      await openDialog3("سبق لك ان قمت بتقديم عرض  لهذا الطلب");
      print(respons["exsist"]);
        isLoding = false;

       setState(() {});
      // await openDialog2('تم إرسال عرضك بنجاح', toke);
      //   await updatOrderState(orderId);
    } else {
      if (respons["status"] == "success") {
        print(respons["status"]);
        await openDialog2('تم إرسال عرضك بنجاح', toke);
          await updatOrderState(orderId);
      } else {
        isLoding = false;

        setState(() {});
        print(respons["status"]);
      }
    }
  }
  // sendOffer(id, orderId, toke) async {
  //   setState(() {});
  //   var respons = await _curd.postRequst(linksend_offer, {
  //     "userId": id,
  //     "offer_description": contant.text.trim(),
  //     "token": sharedPref.getString("token") ?? "",
  //     "orderId": orderId
  //   });

  //   if (respons["status"] == "success") {
  //     print(respons["status"]);
  //     await openDialog2('تم إرسال عرضك بنجاح', toke);
  //       await updatOrderState(orderId);
  //   } else {
  //     isLoding = false;

  //     setState(() {});
  //     print(respons["status"]);
  //   }
  // }

  updatOrderState(id) async {
    var respons = await _curd.postRequst(linkupdate_orderstat, {
      "id": id,
    });
    if (respons["status"] == "success") {
      print(respons["status"]);
    } else {
      print(respons["status"]);
    }
  }
  // readTokens() async {
  //   var respons = await _curd.postRequst(linkReadTokens, {
  //     "classification": dropdownValue1,
  //     "type": dropdownValue2,
  //   });

  //   if (respons["status"] == "success") {
  //     listOfTokens = respons["data"];

  //     //  await openDialog2("تم رفع طلبك سيتم التواصل معك لإعتماد طلبك وعرضة");

  //     return respons;
  //   } else {
  //     return null;
  //   }
  // }

  Widget build(BuildContext context) {
    //  double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 140, 169, 193),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 45,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            FutureBuilder(
                future: readOrder(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: (snapshot.data['data'][i]['accept'] ==
                                          '1')
                                      ? Color.fromARGB(86, 207, 204, 204)
                                      : Color.fromARGB(85, 236, 233, 233),
                                  //color:(snapshot.data[i]=='0')? Color.fromARGB(87, 240, 9, 9):Color.fromARGB(255, 111, 223, 13)
                                  borderRadius: BorderRadius.circular(10.0),

                                  ///border: Border.all()
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${snapshot.data['data'][i]['name'].toString()}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الطلب",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await openDialog(
                                                    "${linkServerName}/upload/${snapshot.data['data'][i]['img'].toString()}");
                                              },
                                              child: Text(
                                                "اضغط هنا",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 16),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": صورة القطعة",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${snapshot.data['data'][i]['classification'].toString()}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": تصنيف القطعة",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ]),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${snapshot.data['data'][i]['type'].toString()}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الشركة",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await openDialog1(
                                                    "${snapshot.data['data'][i]['decription'].toString()}");
                                              },
                                              child: Text(
                                                "الوصف",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الوصف",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("زيارة الحساب")),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("بدء دردشة")),
                                        ]),
                                    Center(
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            side: BorderSide(
                                                color: Colors.white)),
                                        color: Colors.black,
                                        onPressed: () async {
                                          await openDialog_sendOffer(
                                              "تقديم عرض",
                                              snapshot.data['data'][i]['userId']
                                                  .toString(),
                                              snapshot.data['data'][i]['id']
                                                  .toString(),
                                              snapshot.data['data'][i]['token']
                                                  .toString());
                                        },
                                        child: Text(
                                          "تقديم عرض",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                            //     card(name: '${snapshot.data['data'][i]['note_title'].toString()}', image: '${snapshot.data['data'][i]['note_image'].toString()}', price: '${snapshot.data['data'][i]['price'].toString()}', id: '${snapshot.data['data'][i]['note_id'].toString()}', description: '${snapshot.data['data'][i]['note_content'].toString()}', phone: '${snapshot.data['data'][i]['phone'].toString()}', location: '${snapshot.data['data'][i]['location'].toString()}', username: '${snapshot.data['data'][i]['username'].toString()}', locationText: '${snapshot.data['data'][i]['locationText'].toString()}', email: '${snapshot.data['data'][i]['email'].toString()}', token: '${snapshot.data['data'][i]['token'].toString()}' , );
                          });
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: Text(
                          "loading ...",
                          style: TextStyle(
                              color: sharedPref.getBool("mode") ?? "" == true
                                  ? Colors.white
                                  : Colors.black54),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "لايوجد ماتبحث عنه ...",
                      style: TextStyle(
                          color: sharedPref.getBool("mode") ?? "" == true
                              ? Colors.white
                              : Colors.black54),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Future openDialog(
    String object,
  ) =>
      showDialog(
        barrierColor: Colors.black38,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.black26,
            content: (isLoding == true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: InteractiveViewer(
                      panEnabled: true,
                      clipBehavior: Clip.none,
                      child: AspectRatio(
                        aspectRatio: 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                              //  width: MediaQuery.of(context).size.width * 0.95,height:MediaQuery.of(context).size.height * 0.20 ,
                              image: Image.network(
                            "${object}",
                          ).image),
                        ),
                      ),
                    ))),
      );
  Future openDialog1(
    String title,
  ) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              "الوصف",
              style: TextStyle(
                  fontFamily: "ReadexPro",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${title}",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      );

  Future openDialog_sendOffer(
    String title,
    String id,
    String orderId,
    String token,
  ) =>
      showDialog(
        // barrierColor: Colors.w,

        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
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
                      'ادخل تفاصبل العرض',
                      style: TextStyle(
                          color: redColor.primaryColor,
                          fontSize: 15,
                          fontFamily: "ReadexPro"),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: TextField(
                          controller: contant,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: "اكتب تفاصيل العرض الذي ستقدمة",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ReadexPro",
                            ),
                            labelText: "اكتب تفاصيل العرض",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                fontFamily: "ReadexPro"),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: redColor.primaryColor, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: redColor.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          )),
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
                          await sendOffer(sharedPref.getString("id") ?? "", orderId, token);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "إرسال",
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
  Future openDialog2(
    String title,
    String token,
  ) =>
      showDialog(
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
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                          side: BorderSide(color: Colors.white)),
                      color: redColor.primaryColor,
                      onPressed: () async {
                        await http.post(
                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                            'Authorization': 'key=$serverToken',
                          },
                          body: jsonEncode(
                            <String, dynamic>{
                              'notification': <String, dynamic>{
                                'body': '',
                                'title': 'شخص ما قدم إليك عرضا',
                              },
                              'priority': 'high',
                              'data': <String, dynamic>{
                                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                //  'id': '1',
                                //  'status': 'done'
                              },
                              'to': token,
                            },
                          ),
                        );

                        Navigator.pop(context);

                        //(context as Element).reassemble();
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
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  Future openDialog3(
    String title,
  ) =>
      showDialog(
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
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                          side: BorderSide(color: Colors.white)),
                      color: redColor.primaryColor,
                      onPressed: () async {
                        Navigator.pop(context);

                        //(context as Element).reassemble();
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
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
