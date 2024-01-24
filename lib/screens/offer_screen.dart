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
  readOffer(orderId) async {
    setState(() {});
    var respons = await _curd.postRequst(linkread_allOffer, {
      //      'userId': id,
      //'orderId': orderId.toString()
      'orderId': "10"
    });

    if (respons["status"] == "success") {
      print("******************");
      print(respons["status"]);
      return respons;
    } else {
      print("******************");
      print(respons["status"]);
      return null;
    }
  }

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
        child: 
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
                              padding: const EdgeInsets.all(0.0),
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
                                      color: (i%2!=0)?Color.fromARGB(255, 246, 246, 247): Colors.white,
                                      // (snapshot.data['data'][i]['accept'] ==
                                      //         '1')
                                      //     ? Color.fromARGB(86, 207, 204, 204)
                                      //     : Color.fromARGB(85, 236, 233, 233),
                                      //color:(snapshot.data[i]=='0')? Color.fromARGB(87, 240, 9, 9):Color.fromARGB(255, 111, 223, 13)
                                      // borderRadius: BorderRadius.circular(10.0),
                                      border: Border(bottom: BorderSide(width: 0.5))
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
                                                  // await openDialog3(
                                                  //     "${linkServerName}/upload/${snapshot.data['data'][i]['img'].toString()}",
                                                  //     snapshot.data['data'][i]
                                                  //             ['name']
                                                  //         .toString(),
                                                  //     snapshot.data['data'][i]
                                                  //             ['classification']
                                                  //         .toString(),
                                                  //     snapshot.data['data'][i]
                                                  //             ['type']
                                                  //         .toString(),
                                                  //     snapshot.data['data'][i]
                                                  //             ['decription']
                                                  //         .toString());
                                                  await readOffer(snapshot
                                                      .data['data'][i]['id']
                                                      .toString());
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
                                              ": تفاصيل الطلب",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ]),
                                      const Divider(
                                        color: Colors.black,
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
                                              //await showModalBottomSheet1();
                                                       Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (_, __, ___) => showOffers(userID:
                                                          snapshot.data['data'][i]['userId'].toString(), orderId:snapshot.data['data'][i]['id'].toString(),),
                                                          transitionDuration: Duration(seconds: 1),
                                                          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                                        ),
                                                        );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text(
                                                "      العروض      ",
                                                style: TextStyle(fontSize: 18),
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
                            );
                            //     card(name: '${snapshot.data['data'][i]['note_title'].toString()}', image: '${snapshot.data['data'][i]['note_image'].toString()}', price: '${snapshot.data['data'][i]['price'].toString()}', id: '${snapshot.data['data'][i]['note_id'].toString()}', description: '${snapshot.data['data'][i]['note_content'].toString()}', phone: '${snapshot.data['data'][i]['phone'].toString()}', location: '${snapshot.data['data'][i]['location'].toString()}', username: '${snapshot.data['data'][i]['username'].toString()}', locationText: '${snapshot.data['data'][i]['locationText'].toString()}', email: '${snapshot.data['data'][i]['email'].toString()}', token: '${snapshot.data['data'][i]['token'].toString()}' , );
                          });
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return   Center(
                          child: Lottie.asset(
                              "assets/Animation - 1706023859153.json"));
                  }
                  return Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        child: Image(
                          image: Image.asset('images/i2.jpg').image,
                        )),
                        Center(
                          child: Text("لاتوجد بيانات حاليا",style: TextStyle(fontSize: 18 ,color: Color.fromARGB(255, 69, 88, 181),),),
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
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
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
                            image: Image.network(
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
                  Text(name),
                  SizedBox(
                    width: 5,
                  ),
                  Text(": الطلب")
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(classification),
                  SizedBox(
                    width: 5,
                  ),
                  Text(": التصنيف")
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(type),
                  SizedBox(
                    width: 5,
                  ),
                  Text(": النوع")
                ]),
                SizedBox(
                  height: 10,
                ),
                Text(": الوصف"),
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
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            discreption,
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
  Future showModalBottomSheet1() {
    return showModalBottomSheet(
        context: context,

        builder: (BuildContext context) => Container(
              child:
              
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
                                return Text("");

                                //   card(name: '${snapshot.data['data'][i]['note_title'].toString()}', image: '${snapshot.data['data'][i]['note_image'].toString()}', price: '${snapshot.data['data'][i]['price'].toString()}', id: '${snapshot.data['data'][i]['note_id'].toString()}', description: '${snapshot.data['data'][i]['note_content'].toString()}', phone: '${snapshot.data['data'][i]['phone'].toString()}', location: '${snapshot.data['data'][i]['location'].toString()}', username: '${snapshot.data['data'][i]['username'].toString()}', locationText: '${snapshot.data['data'][i]['locationText'].toString()}', email: '${snapshot.data['data'][i]['email'].toString()}', token: '${snapshot.data['data'][i]['token'].toString()}' , );
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
                                  color:
                                      sharedPref.getBool("mode") ?? "" == true
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
              // ]),
              //     Navigator.push(
              // context,
              // PageRouteBuilder(
              //   pageBuilder: (_, __, ___) => showOffers(userID:
              //   snapshot.data['data'][i]['userId'].toString(), orderId:snapshot.data['data'][i]['id'].toString(),),
              //   transitionDuration: Duration(seconds: 1),
              //   transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              // ),
              //  );
            ));
  }
}
