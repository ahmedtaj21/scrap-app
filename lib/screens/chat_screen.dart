import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/chatRome_screen.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Curd _curd = Curd();
  //late List chatInfo = [];
  readChatInfo() async {
    var respons = await _curd.postRequst(linkread_chat_info, {
      "id": sharedPref.getString("id") ?? "",
    });
    if (respons["status"] == "success") {
      print(respons["status"]);
      print(sharedPref.getString("id"));
      // chatInfo.add(respons["data"]);
      // //print(chatInfo);
      return respons;
    } else {}
    print(respons["status"]);
  }

  void initState() {
    super.initState();
  //  chatInfo.clear();
    //readChatInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor:Color.fromARGB(255, 140, 169, 193)
        body: FutureBuilder(
            future: readChatInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                    //  physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                // (snapshot.data['data'][i]['Sender'] ==
                                //         sharedPref.getString("id"))  ?
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => chatRome(
                                          senderId: snapshot.data['data'][i]
                                                  ['Sender']
                                              .toString(),
                                          receiverId: snapshot.data['data'][i]
                                                  ['Receiver']
                                              .toString(),
                                          receiverName: snapshot.data['data'][i]
                                                  ['receiverName']
                                              .toString(), senderName: snapshot.data['data'][i]
                                                  ['senderName'],
                                        )));
                                // : Navigator.of(context)
                                //     .push(MaterialPageRoute(
                                //         builder: (context) => chatRome(
                                //               senderId: snapshot.data['data'][i]
                                //                       ['Sender']
                                //                   .toString(), receiverId: snapshot.data['data'][i]
                                //                       ['Receiver']
                                //                   .toString(), receiverName:snapshot.data['data'][i]
                                //                       ['receiverName']
                                //                   .toString(),
                                //             )));
                              },
                              child: Container(
                                //  color: Colors.white,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(86, 207, 204, 204),
                                  // border: Border.all(
                                  //     color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50)),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Center(
                                        child: Text(
                                          (snapshot.data['data'][i]['Sender'].toString() ==
                                                  sharedPref.getString("id"))
                                              ?snapshot.data['data'][i]
                                                      ['receiverName']
                                                  .toString(): snapshot.data['data'][i]
                                                      ['senderName']
                                                  .toString(),
                                              
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      CircleAvatar(
                                      backgroundColor: Color.fromARGB(255, 69, 88, 181),
                                      child:(snapshot.data['data'][i]['Sender'].toString() ==
                                                  sharedPref.getString("id"))
                                              ?Text("${snapshot.data['data'][i]
                                                      ['receiverName'][0].toString().toUpperCase()}",style: TextStyle(color: Colors.white,fontSize: 25),) :Text("${snapshot.data['data'][i]
                                                      ['senderName'][0].toString().toUpperCase()}",style: TextStyle(color: Colors.white,fontSize: 25),),
                                        radius: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      });
                }
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return 
                   Center(
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
        backgroundColor: Colors.white);
  }
}
