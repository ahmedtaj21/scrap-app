import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/allOrder_screen.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:scrap_app/screens/order_name.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'package:http/http.dart' as http;

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  File? myfole;
  TextEditingController contant = TextEditingController();
  TextEditingController name = TextEditingController();
  String dropdownValue1 = 'تصنيف القطعة';
  String dropdownValue2 = 'الشركة';
  bool isLoding = false;

  Curd _curd = Curd();
  late List listOfTokens = [];

  final String serverToken =
      'AAAA8PMN14I:APA91bHFsIavFUR81FmgzbOJMRrxhlwYbXio3EEtMOshDPsePJoaTsV0SRYgkFwLL1tiGXdFmrAoTpAWzZBNpepfwKsTkNqShUjikf7EESrYaSyvhkZ0XzV78gu1cjyNPDnyShUFhbJb';

  updatOrder(id) async {
    isLoding = true;
    setState(() {});

    var respons = await _curd.postRequstWithFile(
        linkupDate_order,
        {
          "id": id,
          "decription": contant.text.trim().toString(),
          "classification": dropdownValue1,
          "type": dropdownValue2,
          "name": name.text.trim().toString(),
        },
        myfole!);

    if (respons["status"] == "success") {
      print(respons["status"]);

      await readOrder();
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
    }
  }

  sendOrder() async {
    isLoding = true;
    setState(() {});

    var respons = await _curd.postRequstWithFile(
        linkOrder,
        {
          "userId": sharedPref.getString("id") ?? "",
          "decription": contant.text.trim().toString(),
          "classification": dropdownValue1,
          "type": dropdownValue2,
          "accept": '0',
          //"name": name.text.trim().toString(),
          "name": sharedPref.getString("part"),
          "token": sharedPref.getString("token") ?? "",
          "profailName": sharedPref.getString("profil") ?? ""
          //"name1":sharedPref.getString("profil")?? ""
        },
        myfole!);

    if (respons["status"] == "success") {
      print(respons["status"]);
      await readTokens();
      await readOrder();
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
    }
  }

  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      open();
      // showModalBottomSheet(
      //     context: context,
      //     builder: (builder) {
      //       return Container();
      //     });
    });
    super.initState();
    // setState(() {});
    // (context as Element).reassemble();
  }

  void open() async {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        builder: (BuildContext context) => Container(
              //  height: height * 0.80,
              child:
                  //   (isLoding == true)
                  // ? Center(
                  //     child: CircularProgressIndicator(
                  //       color: Colors.black,
                  //     ),
                  //   )
                  // :
                  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
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
                          child: Container(
                            height: 150,
                            width: 150,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: (myfole != null)
                                    ? Image.file(
                                        myfole!,
                                      ).image
                                    : Image.asset('images/i1.jpeg').image,
                              ),
                              //color: const Color.fromARGB(255, 182, 28, 17),
                              border: Border.all(
                                width: 2,
                                color: Color.fromRGBO(69, 88, 181, 1),
                              ),

                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            //child: Text("kjk"),
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
                          color: Color.fromRGBO(69, 88, 181, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${sharedPref.getString("part")}",
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ": اسم القطعة",
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                              //  autofocus: true,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: contant,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: "اكتب وصف واضح ومبسط للقطعة",
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  fontSize: 13,
                                  fontFamily: "ReadexPro",
                                ),
                                labelText: "وصف القطعة",
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "ReadexPro",
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(69, 88, 181, 1),
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(69, 88, 181, 1),
                                        width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton<String>(
                            // Step 3.
                            hint: Text(
                              "${dropdownValue1}",
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1)),
                            ),
                            //  value: dropdownValue3,
                            dropdownColor: Colors.white,
                            // Step 4.

                            items: <String>[
                              'قطع كهربائية',
                              'قطع ميكانيكية',
                              'ديكورات',
                              'بودي',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(69, 88, 181, 1)),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue1 = newValue!;
                                sharedPref.setString("part", '');
                              });
                              // isCosen = false;
                              // print(sharedPref.getString("part"));
                              (context as Element).reassemble();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ": التصنيف",
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton<String>(
                            // Step 3.
                            hint: Text(
                              "${dropdownValue2}",
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1)),
                            ),
                            //  value: dropdownValue3,
                            dropdownColor: Colors.white,
                            // Step 4.

                            items: <String>[
                              'تيوتا',
                              'هونداي',
                              'لكزيس',
                              'مرسيدس',
                              'شفر',
                              'جمس',
                              'بي ام',
                              'غير ذالك'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(69, 88, 181, 1)),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue2 = newValue!;
                              });
                              (context as Element).reassemble();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "  : النوع",
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            color: Color.fromRGBO(69, 88, 181, 1),
                            onPressed: () async {
                              ((sharedPref.getString("part") == '') == true)
                                  ? Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => order_name(
                                                classfication:
                                                    '${dropdownValue1}',
                                              )))
                                  : (myfole != null)
                                      ? await sendOrder()
                                      : await sendOrderWithOutImg();
                            //  await readTokens();
                            },
                            child:
                                ((sharedPref.getString("part") != '') == true)
                                    ? Text("حفظ وإرسال",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: "ReadexPro"))
                                    : Text("المتابعة لإكمال الطلب",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: "ReadexPro"))),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

// you need to edit on back end in this function
  sendOrderWithOutImg() async {
    isLoding = true;
    setState(() {});

    var respons = await _curd.postRequst(
      linkWithOutOrder,
      {
        "userId": sharedPref.getString("id") ?? "",
        "decription": contant.text.trim().toString(),
        "classification": dropdownValue1,
        "type": dropdownValue2,
        "accept": '0',
        "name": sharedPref.getString("part"),
        // "name": name.text.trim().toString(),
        "token": sharedPref.getString("token") ?? "",
        "profailName": sharedPref.getString("profil") ?? ""
      },
    );

    if (respons["status"] == "success") {
      await readTokens();
      await readOrder();
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
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

  deletOrder(id, imageName) async {
    setState(() {});
    var respons = await _curd.postRequst(linkdelet_order,
        {'id': id.toString(), 'imageName': imageName.toString()});

    if (respons["status"] == "success") {
      await readOrder();
    } else {
      print(respons["status"]);
    }
  }

  readTokens() async {
    var respons = await _curd.postRequst(linkReadTokens, {
      "classification": dropdownValue1,
      "type": dropdownValue2,
       
    });

    if (respons["status"] == "success") {
      listOfTokens = respons["data"];

      await openDialog2("تم رفع طلبك سيتم التواصل معك لإعتماد طلبك وعرضة");

      return respons;
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    //  double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      //  backgroundColor: Color.fromARGB(255, 246, 246, 247),
      body: Container(
          child: FutureBuilder(
              future: readOrder(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        //      physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  // maxHeight: 360,

                                  minHeight: 50),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: (i % 2 == 0)
                                        ? Color.fromARGB(255, 246, 246, 247)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(0.0),
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 0.5,
                                            color: Color.fromRGBO(
                                                69, 88, 181, 1)))),
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
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Color.fromRGBO(
                                                    69, 88, 181, 1)),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الطلب",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Color.fromRGBO(
                                                    69, 88, 181, 1)),
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
                                                    color: Color.fromRGBO(
                                                        69, 88, 181, 1),
                                                    fontSize: 16),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": صورة القطعة",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${snapshot.data['data'][i]['classification'].toString()}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black45),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": تصنيف القطعة",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 10,
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
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الشركة",
                                            style: TextStyle(fontSize: 16),
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
                                                await openDialog1(
                                                    "${snapshot.data['data'][i]['decription'].toString()}");
                                              },
                                              child: Text(
                                                "اضغط هنا",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        69, 88, 181, 1)),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            ": الوصف",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
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
                                              color: Color.fromRGBO(
                                                  69, 88, 181, 1),
                                              onPressed: () async {
                                                await deletOrder(
                                                    snapshot.data['data'][i]
                                                        ['id'],
                                                    snapshot.data['data'][i]
                                                        ['img']);
                                              },
                                              child: Text("حذف",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily:
                                                          "ReadexPro"))),
                                          SizedBox(width: 10),
                                          MaterialButton(
                                              height: 30,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  side: BorderSide(
                                                      color: Colors.white)),
                                              color: Color.fromRGBO(
                                                  69, 88, 181, 1),
                                              onPressed: () async {
                                                await openDialog3(snapshot
                                                    .data['data'][i]['id']
                                                    .toString());
                                              },
                                              child: Text("تعديل",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily:
                                                          "ReadexPro"))),
                                        ]),
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
                  return Center(
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
              })),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            bottom: 50,
            //      right: 150,
            left: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                backgroundColor: const Color.fromARGB(208, 255, 255, 255),
                child: Icon(Icons.add, color: Color.fromRGBO(69, 88, 181, 1)),
                onPressed: () {
                  (sharedPref.getString("id") == null)
                      ? openDialog0("يجب عليك تسجيل الدخول اولا")
                      : open();
                  // showModalBottomSheet(
                  //     backgroundColor: Colors.white,
                  //     context: context,
                  //     isScrollControlled: true,
                  //     shape: const RoundedRectangleBorder(
                  //       // <-- SEE HERE
                  //       borderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(30.0),
                  //       ),
                  //     ),
                  //     builder: (BuildContext context) => Container(
                  //           height: height * 0.80,
                  //           child:
                  //               //   (isLoding == true)
                  //               // ? Center(
                  //               //     child: CircularProgressIndicator(
                  //               //       color: Colors.black,
                  //               //     ),
                  //               //   )
                  //               // :
                  //               SingleChildScrollView(
                  //             scrollDirection: Axis.vertical,
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.only(
                  //                       topLeft: Radius.circular(30),
                  //                       topRight: Radius.circular(30))),
                  //               child: Column(
                  //                 children: [
                  //                   SizedBox(
                  //                     height: 20,
                  //                   ),
                  //                   Center(
                  //                     child: InkWell(
                  //                       onTap: () async {
                  //                         XFile? xFile =
                  //                             await ImagePicker().pickImage(
                  //                           source: ImageSource.gallery,
                  //                           maxWidth: 512,
                  //                           maxHeight: 512,
                  //                         );
                  //                         myfole = File(xFile!.path);
                  //                         (context as Element).reassemble();
                  //                       },
                  //                       child: Container(
                  //                         height: 150,
                  //                         width: 150,

                  //                         decoration: BoxDecoration(
                  //                           image: DecorationImage(
                  //                             image: (myfole != null)
                  //                                 ? Image.file(
                  //                                     myfole!,
                  //                                   ).image
                  //                                 : Image.asset(
                  //                                         'images/i1.jpeg')
                  //                                     .image,
                  //                           ),
                  //                           //color: const Color.fromARGB(255, 182, 28, 17),
                  //                           border: Border.all(
                  //                             width: 2,
                  //                             color: Color.fromRGBO(
                  //                                 69, 88, 181, 1),
                  //                           ),

                  //                           borderRadius:
                  //                               BorderRadius.circular(30.0),
                  //                         ),
                  //                         //child: Text("kjk"),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Center(
                  //                     child: IconButton(
                  //                       onPressed: () async {
                  //                         XFile? xFile =
                  //                             await ImagePicker().pickImage(
                  //                           source: ImageSource.camera,
                  //                           maxWidth: 512,
                  //                           maxHeight: 512,
                  //                         );
                  //                         myfole = File(xFile!.path);
                  //                         (context as Element).reassemble();
                  //                       },
                  //                       icon: Icon(Icons.camera),
                  //                       color:
                  //                           Color.fromRGBO(69, 88, 181, 1),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.end,
                  //                       children: [
                  //                         Text(
                  //                             "${sharedPref.getString("part")}"),
                  //                         SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         Text(": اسم القطعة"),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Directionality(
                  //                       textDirection: TextDirection.rtl,
                  //                       child: TextField(
                  //                           //  autofocus: true,
                  //                           style: TextStyle(
                  //                             color: Colors.black,
                  //                           ),
                  //                           controller: contant,
                  //                           keyboardType:
                  //                               TextInputType.multiline,
                  //                           maxLines: null,
                  //                           textAlign: TextAlign.right,
                  //                           decoration: InputDecoration(
                  //                             hintText:
                  //                                 "اكتب وصف واضح ومبسط للقطعة",
                  //                             hintStyle: TextStyle(
                  //                               color: Color.fromRGBO(
                  //                                   69, 88, 181, 1),
                  //                               fontSize: 13,
                  //                               fontFamily: "ReadexPro",
                  //                             ),
                  //                             labelText: "وصف القطعة",
                  //                             labelStyle: TextStyle(
                  //                               color: Color.fromRGBO(
                  //                                   69, 88, 181, 1),
                  //                               fontSize: 15,
                  //                               fontWeight:
                  //                                   FontWeight.normal,
                  //                               fontFamily: "ReadexPro",
                  //                             ),
                  //                             border: OutlineInputBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.all(
                  //                                       Radius.circular(
                  //                                           10)),
                  //                             ),
                  //                             enabledBorder:
                  //                                 OutlineInputBorder(
                  //                                     borderSide: BorderSide(
                  //                                         color:
                  //                                             Color
                  //                                                 .fromRGBO(
                  //                                                     69,
                  //                                                     88,
                  //                                                     181,
                  //                                                     1),
                  //                                         width: 1),
                  //                                     borderRadius:
                  //                                         BorderRadius.all(
                  //                                             Radius
                  //                                                 .circular(
                  //                                                     10))),
                  //                             focusedBorder:
                  //                                 OutlineInputBorder(
                  //                                     borderSide: BorderSide(
                  //                                         color:
                  //                                             Color
                  //                                                 .fromRGBO(
                  //                                                     69,
                  //                                                     88,
                  //                                                     181,
                  //                                                     1),
                  //                                         width: 2),
                  //                                     borderRadius:
                  //                                         BorderRadius.all(
                  //                                             Radius
                  //                                                 .circular(
                  //                                                     10))),
                  //                           )),
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.end,
                  //                     children: [
                  //                       DropdownButton<String>(
                  //                         // Step 3.
                  //                         hint: Text(
                  //                           "${dropdownValue1}",
                  //                           style: TextStyle(
                  //                               color: Color.fromRGBO(
                  //                                   69, 88, 181, 1)),
                  //                         ),
                  //                         //  value: dropdownValue3,
                  //                         dropdownColor: Colors.white,
                  //                         // Step 4.

                  //                         items: <String>[
                  //                           'قطع كهربائية',
                  //                           'قطع ميكانيكية',
                  //                           'ديكورات',
                  //                           'بودي',
                  //                           'غير ذالك'
                  //                         ].map<DropdownMenuItem<String>>(
                  //                             (String value) {
                  //                           return DropdownMenuItem<String>(
                  //                             value: value,
                  //                             child: Text(
                  //                               value,
                  //                               style: TextStyle(
                  //                                   fontSize: 15,
                  //                                   color: Color.fromRGBO(
                  //                                       69, 88, 181, 1)),
                  //                             ),
                  //                           );
                  //                         }).toList(),
                  //                         // Step 5.
                  //                         onChanged: (String? newValue) {
                  //                           setState(() {
                  //                             dropdownValue1 = newValue!;
                  //                             sharedPref.setString(
                  //                                 "part", '');
                  //                           });
                  //                           // isCosen = false;
                  //                           // print(sharedPref.getString("part"));
                  //                           (context as Element)
                  //                               .reassemble();
                  //                         },
                  //                       ),
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text(
                  //                           ": التصنيف",
                  //                           style: TextStyle(
                  //                               color: Color.fromRGBO(
                  //                                   69, 88, 181, 1),
                  //                               fontSize: 18),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(
                  //                     width: 5,
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.end,
                  //                     children: [
                  //                       DropdownButton<String>(
                  //                         // Step 3.
                  //                         hint: Text(
                  //                           "${dropdownValue2}",
                  //                           style: TextStyle(
                  //                               color: Color.fromRGBO(
                  //                                   69, 88, 181, 1)),
                  //                         ),
                  //                         //  value: dropdownValue3,
                  //                         dropdownColor: Colors.white,
                  //                         // Step 4.

                  //                         items: <String>[
                  //                           'تيوتا',
                  //                           'هونداي',
                  //                           'لكزيس',
                  //                           'مرسيدس',
                  //                           'شفر',
                  //                           'جمس',
                  //                           'بي ام',
                  //                           'غير ذالك'
                  //                         ].map<DropdownMenuItem<String>>(
                  //                             (String value) {
                  //                           return DropdownMenuItem<String>(
                  //                             value: value,
                  //                             child: Text(
                  //                               value,
                  //                               style: TextStyle(
                  //                                   fontSize: 15,
                  //                                   color: Color.fromRGBO(
                  //                                       69, 88, 181, 1)),
                  //                             ),
                  //                           );
                  //                         }).toList(),
                  //                         // Step 5.
                  //                         onChanged: (String? newValue) {
                  //                           setState(() {
                  //                             dropdownValue2 = newValue!;
                  //                           });
                  //                           (context as Element)
                  //                               .reassemble();
                  //                         },
                  //                       ),
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text(
                  //                           "  : النوع",
                  //                           style: TextStyle(
                  //                               color: Color.fromRGBO(
                  //                                   69, 88, 181, 1),
                  //                               fontSize: 18),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   SizedBox(
                  //                     height: 20,
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(13.0),
                  //                     child: MaterialButton(
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: 100,
                  //                             vertical: 14),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(
                  //                                     18.0),
                  //                             side: BorderSide(
                  //                                 color: Colors.white)),
                  //                         color: Color.fromRGBO(
                  //                             69, 88, 181, 1),
                  //                         onPressed: () async {
                  //                           ((sharedPref.getString(
                  //                                           "part") ==
                  //                                       '') ==
                  //                                   true)
                  //                               ? Navigator.of(context)
                  //                                   .push(MaterialPageRoute(
                  //                                       builder:
                  //                                           (context) =>
                  //                                               order_name(
                  //                                                 classfication:
                  //                                                     '${dropdownValue1}',
                  //                                               )))
                  //                               : (myfole != null)
                  //                                   ? await sendOrder()
                  //                                   : await sendOrderWithOutImg();
                  //                         },
                  //                         child: ((sharedPref.getString("part") !=
                  //                                     '') ==
                  //                                 true)
                  //                             ? Text("حفظ وإرسال",
                  //                                 style: TextStyle(
                  //                                     color: Colors.white,
                  //                                     fontWeight:
                  //                                         FontWeight.bold,
                  //                                     fontSize: 16,
                  //                                     fontFamily:
                  //                                         "ReadexPro"))
                  //                             : Text(
                  //                                 "المتابعة لإكمال الطلب",
                  //                                 style: TextStyle(
                  //                                     color: Colors.white,
                  //                                     fontWeight:
                  //                                         FontWeight.bold,
                  //                                     fontSize: 16,
                  //                                     fontFamily:
                  //                                         "ReadexPro"))),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 50,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ));
                }),
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
                              image: (object ==
                                      "https://scrap-app.online/scrap/upload/")
                                  ? Image.asset("images/i1.jpeg").image
                                  : Image.network(
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
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Column(
            children: [
              Center(
                child: Text(
                  "الوصف",
                  style: TextStyle(
                    fontFamily: "ReadexPro",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 69, 88, 181),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 69, 88, 181),
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
            ],
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 69, 88, 181),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${title}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  Future openDialog3(
    String id,
  ) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            // title: Center(
            //   child: Text(
            //     "${title}",
            //     style: TextStyle(
            //         color: Colors.black54,
            //         fontFamily: "ReadexPro",
            //         fontWeight: FontWeight.bold),
            //     textAlign: TextAlign.right,
            //   ),
            // ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                //  key: formstate,
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
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Color.fromRGBO(69, 88, 181, 1),
                          child: CircleAvatar(
                            backgroundImage: (myfole != null)
                                ? Image.file(
                                    myfole!,
                                    fit: BoxFit.cover,
                                  ).image
                                : Image.asset('images/i1.jpeg').image,
                            radius: 78,
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
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: "اسم القطعة",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(69, 88, 181, 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  //sharedPref.getBool("mode") ?? ""==true?const Color.fromARGB(255, 233, 60, 60): redColor.primaryColor,
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(69, 88, 181, 1),
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: "اسم القطعة",
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(69, 88, 181, 1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                        controller: contant,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "اكتب وصف مبسط عن القطعة    ",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(69, 88, 181, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ReadexPro",
                          ),
                          labelText: " سيعرض هذا الجزء في وصف الطلب   ",
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(69, 88, 181, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              fontFamily: "ReadexPro"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          // Step 3.
                          hint: Text(
                            "${dropdownValue1}",
                            style: TextStyle(
                                color: Color.fromRGBO(69, 88, 181, 1)),
                          ),
                          //  value: dropdownValue3,
                          dropdownColor: Colors.white,
                          // Step 4.

                          items: <String>[
                            'قطع كهربائية',
                            'قطع ميكانيكية',
                            'ديكورات',
                            'بودي',
                            'غير ذالك'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(69, 88, 181, 1)),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue1 = newValue!;
                            });

                            (context as Element).reassemble();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ": التصنيف",
                            style: TextStyle(
                                color: Color.fromRGBO(69, 88, 181, 1),
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          // Step 3.
                          hint: Text(
                            "${dropdownValue2}",
                            style: TextStyle(
                                color: Color.fromRGBO(69, 88, 181, 1)),
                          ),
                          //  value: dropdownValue3,
                          dropdownColor: Colors.white,
                          // Step 4.

                          items: <String>[
                            'تيوتا',
                            'هونداي',
                            'لكزيس',
                            'مرسيدس',
                            'شفر',
                            'جمس',
                            'بي ام',
                            'غير ذالك'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(69, 88, 181, 1)),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue2 = newValue!;
                            });
                            (context as Element).reassemble();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "  : النوع",
                            style: TextStyle(
                                color: Color.fromRGBO(69, 88, 181, 1),
                                fontSize: 18),
                          ),
                        ),
                      ],
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
                          await updatOrder(id);
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
  Future openDialog2(
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
                        Navigator.pop(context);
                        (context as Element).reassemble();
                        for (var i = 0; i < listOfTokens.length; i++) {
                          await http.post(
                            Uri.parse('https://fcm.googleapis.com/fcm/send'),
                            headers: <String, String>{
                              'Content-Type': 'application/json',
                              'Authorization': 'key=$serverToken',
                            },
                            body: jsonEncode(
                              <String, dynamic>{
                                'notification': <String, dynamic>{
                                  'body': '${dropdownValue1},${dropdownValue2}',
                                  'title': 'تم طلب قطعة موجودة لديك'
                                },
                                'priority': 'high',
                                'data': <String, dynamic>{
                                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                  //  'id': '1',
                                  //  'status': 'done'
                                },
                                'to': listOfTokens[i]
                                    .toString()
                                    .replaceAll('token: ', '')
                                    .replaceAll('{', '')
                                    .replaceAll('}', ''),
                                //  'to': "f3S-CeiETk6GOP46d3jy2A:APA91bGe3kuNYIVj4_OVU0A4CXpzqoomjKDtxshsML5WGnW2bTvIAO3194VZgaf-0mA2VZqlRY8Gjk7ogKQ_c1c-jcrav839KGPf8rNELDqLvftkhmZBM6Xlpo7tvYiHQ1W-6fd8NkHD",
                              },
                            ),
                          );
                        }
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
