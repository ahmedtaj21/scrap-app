import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'package:http/http.dart' as http;

class showOffers extends StatefulWidget {
  final String userID;
  final String orderId;
  const showOffers({super.key, required this.userID, required this.orderId});

  @override
  State<showOffers> createState() => _showOffersState();
}

class _showOffersState extends State<showOffers> {
  Curd _curd = Curd();
  bool isLoding = false;
  final String serverToken =
      'AAAA8PMN14I:APA91bHFsIavFUR81FmgzbOJMRrxhlwYbXio3EEtMOshDPsePJoaTsV0SRYgkFwLL1tiGXdFmrAoTpAWzZBNpepfwKsTkNqShUjikf7EESrYaSyvhkZ0XzV78gu1cjyNPDnyShUFhbJb';

  readOffer(orderId) async {
    setState(() {});
    var respons = await _curd.postRequst(linkread_allOffer, {
      //      'userId': id,
      'orderId': orderId.toString()
    });

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
      await readOffer(widget.orderId);
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

  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //  gradient: LinearGradient(
      //                               begin: Alignment.topLeft,
      //                               end: Alignment.bottomRight,
      //                               colors:[Color.fromARGB(255, 246, 246, 247),Color.fromARGB(255, 181, 176, 176)] )
      //  ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 247),
      //  backgroundColor: Colors.transparent,
        body: (isLoding == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: readOffer(widget.orderId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                   decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                     
                                  //   gradient: LinearGradient(
                                  //   begin: Alignment.topCenter,
                                  //   end: Alignment.bottomRight,
                                  //   colors:[Color.fromARGB(255, 246, 246, 247),Color.fromARGB(255, 164, 160, 160)] )
                                    color: Color.fromARGB(255, 246, 246, 247),
                                  ),
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () async {
                                                    //  print(offer);
                                                  },
                                                  child: Text(
                                                    "${snapshot.data['data'][i]['offer_description'].toString()}",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16),
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                ": تفاصيل العرض",
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
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MaterialButton(
                                                  height: 30,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      side: BorderSide(
                                                          color: Colors.white)),
                                                  color: Colors.white,
                                                  onPressed: () async {
                                                    await deletOffer(snapshot
                                                        .data['data'][i]['id']
                                                        .toString());
                                                  },
                                                  child: Text("رفض",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "ReadexPro"))),
                                              SizedBox(width: 30),
                                              MaterialButton(
                                                  height: 30,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      side: BorderSide(
                                                          color: Colors.white)),
                                                  color: Colors.white,
                                                  onPressed: () async {
                                                    (snapshot.data['data'][i]
                                                                    ['accept']
                                                                .toString() ==
                                                            '0')
                                                        ? await acceptOffer(
                                                            snapshot.data['data'][i]
                                                                    ['id']
                                                                .toString(),
                                                            snapshot.data['data'][i]
                                                                    ['token']
                                                                .toString(),
                                                            snapshot.data['data'][i]
                                                                    [
                                                                    'offer_description']
                                                                .toString())
                                                        : '';
                                                  },
                                                  child: (snapshot.data['data'][i]
                                                                  ['accept']
                                                              .toString() ==
                                                          '0')
                                                      ? Text("قبول",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "ReadexPro"))
                                                      : Text("تم القبول",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "ReadexPro"))),
                                            ]),
                                        // SizedBox(
                                        //   height: 50,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ));
                          });
                    }
                  }
      
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Center(
                    child: Text(
                      "لايوجد",
                      style: TextStyle(
                          color: sharedPref.getBool("mode") ?? "" == true
                              ? Colors.white
                              : Colors.black54),
                    ),
                  );
                }),
      ),
    );
  }

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
}
