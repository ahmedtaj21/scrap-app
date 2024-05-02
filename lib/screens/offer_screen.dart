import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/show_offers_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'package:http/http.dart' as http;

class offer extends StatefulWidget {
  const offer({super.key});

  @override
  State<offer> createState() => _offerState();
}

class _offerState extends State<offer> {
  Curd _curd = Curd();
  bool isLoding = false;
  final String serverToken =
      'AAAA8PMN14I:APA91bHFsIavFUR81FmgzbOJMRrxhlwYbXio3EEtMOshDPsePJoaTsV0SRYgkFwLL1tiGXdFmrAoTpAWzZBNpepfwKsTkNqShUjikf7EESrYaSyvhkZ0XzV78gu1cjyNPDnyShUFhbJb';
  // void initState() {
  //   super.initState();
  //   readOffer();
  // }
  // readOffer(orderId) async {
  //   setState(() {});
  //   var respons = await _curd.postRequst(linkread_allOffer, {
  //     //      'userId': id,
  //     //'orderId': orderId.toString()
  //     'orderId': "10"
  //   });

  //   if (respons["status"] == "success") {
  //     print("******************");
  //     print(respons["status"]);
  //     return respons;
  //   } else {
  //     print("******************");
  //     print(respons["status"]);
  //     return null;
  //   }
  // }

  readOrder() async {
    setState(() {});
    var respons = await _curd
        .postRequst(linkReadOrder, {'id': sharedPref.getString("id") ?? ""});

    if (respons["status"] == "success") {
      return respons;
    } else {
      return null;
    }
  }

  deletOffer(Id) async {
    isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(linkdelet_offer, {
      //      'userId': id,
      'id': Id.toString()
    });

    if (respons["status"] == "success") {
      print(respons["status"]);
      isLoding = false;
      setState(() {});
      //await readOffer(widget.orderId);
    } else {
      isLoding = false;
      setState(() {});
      print(respons["status"]);
    }
  }

  acceptOffer(Id, token, offerDiscription) async {
    isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(linkaccept_offer, {
      //      'userId': id,
      'id': Id.toString()
    });

    if (respons["status"] == "success") {
      print(respons["status"]);
      isLoding = false;
      setState(() {});
      (context as Element).reassemble();
      openDialog2(
          "تم قبول العرض بنجاح", token.toString(), offerDiscription.toString());
    } else {
      isLoding = false;
      setState(() {});
      print(respons["status"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        child: FutureBuilder(
            future: readOrder(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                  //    physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Stack(alignment: Alignment.center, children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  // maxHeight: 360,

                                  minHeight: 50),

                              //  height: 270,
                              // decoration: BoxDecoration(
                              //   color: (snapshot.data['data'][i]['accept'] ==
                              //           '1')
                              //       ? Color.fromARGB(86, 207, 204, 204)
                              //       : Color.fromARGB(85, 236, 233, 233),
                              //   //color:(snapshot.data[i]=='0')? Color.fromARGB(87, 240, 9, 9):Color.fromARGB(255, 111, 223, 13)
                              //   borderRadius: BorderRadius.circular(10.0),

                              //   ///border: Border.all()
                              // ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: (i % 2 != 0)
                                        ? Color.fromARGB(255, 246, 246, 247)
                                        : Color.fromARGB(255, 69, 88, 181),
                                    // (snapshot.data['data'][i]['accept'] ==
                                    //         '1')
                                    //     ? Color.fromARGB(86, 207, 204, 204)
                                    //     : Color.fromARGB(85, 236, 233, 233),
                                    //color:(snapshot.data[i]=='0')? Color.fromARGB(87, 240, 9, 9):Color.fromARGB(255, 111, 223, 13)
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: (i.isOdd)
                                        ? Border.all(width: 0.5)
                                        : Border(bottom: BorderSide(width: 0.5))
                                    // Border(bottom: BorderSide(width: 0.5))
                                    ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${snapshot.data['data'][i]['name'].toString()}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: (i.isEven)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الطلب",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: (i % 2 == 0)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await openDialog3(
                                                    "${linkServerName}/upload/${snapshot.data['data'][i]['img'].toString()}",
                                                    snapshot.data['data'][i]
                                                            ['name']
                                                        .toString(),
                                                    snapshot.data['data'][i]
                                                            ['classification']
                                                        .toString(),
                                                    snapshot.data['data'][i]
                                                            ['type']
                                                        .toString(),
                                                    snapshot.data['data'][i]
                                                            ['decription']
                                                        .toString());
                                              },
                                              child: Text(
                                                "اضغط هنا",
                                                style: TextStyle(
                                                    color: (i % 2 == 0)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": تفاصيل الطلب",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: (i % 2 == 0)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ]),
                                    Divider(
                                      color: (i.isEven)
                                          ? Color.fromARGB(255, 246, 246, 247)
                                          : Colors.black,
                                      height: 25,
                                      thickness: 0.5,
                                      indent: 5,
                                      endIndent: 5,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          splashColor: Colors.black12,
                                          onTap: () async {
                                          
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    showOffers(
                                                  userID: snapshot.data['data']
                                                          [i]['userId']
                                                      .toString(),
                                                  orderId: snapshot.data['data']
                                                          [i]['id']
                                                      .toString(),
                                                ),
                                                transitionDuration:
                                                    Duration(seconds: 1),
                                                transitionsBuilder: (_, a, __,
                                                        c) =>
                                                    FadeTransition(
                                                        opacity: a, child: c),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: (i.isEven)
                                                        ? Colors.white
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                              "      العروض      ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: (i.isEven)
                                                    ? Color.fromRGBO(
                                                        69, 88, 181, 1)
                                                    : Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // const Divider(
                                    //   color: Colors.black,
                                    //   height: 15,
                                    //   thickness: 0.5,
                                    //   indent: 5,
                                    // //  endIndent: 5,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                          ),
                          Positioned(
                            top: 0,
                            //  bottom: 140,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: (i.isOdd)
                                      ? Border.all(width: 0.6)
                                      : Border.all(width: 0)),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: (i.isEven)
                                    ? Color.fromARGB(255, 77, 97, 194)
                                    : Colors.white,
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image(
                                        image:
                                            Image.asset('images/i5.jpeg').image,
                                      ),
                                    )
                                    //Text("${i+1}"),
                                    ),
                              ),
                            ),
                          ),
                        ]);
                      });
                }
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        Lottie.asset("assets/Animation - 1706023859153.json"));
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
      ),
    );
  }

  Future openDialog3(
    String img,
    String name,
    String classification,
    String type,
    String discreption,
  ) =>
      showDialog(
        // barrierColor: Colors.w,

        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 69, 88, 181),
                    border: Border.all(
                      width: 2,
                      color: Color.fromARGB(255, 69, 88, 181),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: 250,
                  height: 200,
                  child: InteractiveViewer(
                    panEnabled: true,
                    clipBehavior: Clip.none,
                    child: AspectRatio(
                      aspectRatio: 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                          child: Image(
                              //  width: MediaQuery.of(context).size.width * 0.95,height:MediaQuery.of(context).size.height * 0.20 ,
                              image: (img == "https://scrap-app.online/scrap/upload/")
                                  ? Image.asset("images/i1.jpeg").image
                                  : Image.network(
                                      "${img}",
                                    ).image),
                      
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(name,style: TextStyle(color: Colors.black54,fontSize: 16),),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    ": الطلب",
                    style: TextStyle(color: Color.fromARGB(255, 69, 88, 181),fontSize: 16),
                  )
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(classification,style: TextStyle(color: Colors.black54),),
                  SizedBox(
                    width: 5,
                  ),
                  Text(": التصنيف",style: TextStyle(color: Color.fromARGB(255, 69, 88, 181),fontSize: 16 ),)
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(type,style: TextStyle(color: Colors.black54),),
                  SizedBox(
                    width: 5,
                  ),
                  Text(": النوع",style: TextStyle(color:  Color.fromARGB(255, 69, 88, 181),fontSize: 16),)
                ]),
                SizedBox(
                  height: 10,
                ),
                Text(": الوصف",style: TextStyle(color:  Color.fromARGB(255, 69, 88, 181)),),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color:  Color.fromARGB(255, 69, 88, 181),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            discreption,style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.right,
                          ),
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
      );
  Future openDialog2(
    String title,
    String token,
    String offerDiscription,
  ) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
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
                                'body': '${offerDiscription}',
                                'title': 'تم قبول عرضك',
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
}
