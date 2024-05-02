import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scrap_app/screens/chatRome_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';

class profilePage extends StatefulWidget {
  final String id;
  const profilePage({super.key, required this.id});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Curd _curd = Curd();
  bool isLoding = false;
  late double rat;
  bool _isButtonDisabled = false;
  late List respon = [];
  bool nell = false;
  addRating() async {
    var respons = await _curd.postRequst(linkadd_rating, {
      "id": widget.id,
      "rating": rat.toString(),
      "user_id": sharedPref.getString("id") ?? ""
    });
    if (respons["status"] == "success") {
      await getData();
      //Navigator.pop(context);
    } else {
      openDialog7("سبق التقييم", "قد قمت بتقييم هذا الحساب سابقا");
    }
    //  print(respons["status"]);
  }

  getData() async {
    // isLoding = false;
    // setState(() {});
    var respons = await _curd.postRequst(linkrating, {
      "id": widget.id.toString(),

      // "note_title":"q"
    });

    if (respons["status"] == "success") {
      // result=double.parse(respons["result"]);
      // count=int.parse(respons["count"]) ;
      // result=respons["result"];
      // count=respons["count"] ;
      respon.add(respons["count"]);
      respon.add(respons["result"]);
      // print(respons["count"]);
      // print(respons["result"]);
      // print(count);

      // ignore: invalid_use_of_protected_member
      (context as Element).reassemble();
      //return respons;
    } else {
      nell = true;
    }
  }

  readProfile() async {
    var respons = await _curd
        .postRequst(linkread_profile, {'userId': widget.id.toString()});

    if (respons["status"] == "success") {
      return respons;
    } else {
      return null;
    }
  }

  read_from_Inventory() async {
    var respons = await _curd.postRequst(linkread_Inventory, {
      "userId": widget.id.toString(),
    });

    if (respons["status"] == "success") {
      return respons;
    } else {
      return null;
    }
  }

  void initState() {
    super.initState();

    getData();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            FutureBuilder(
                future: readProfile(),
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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 69, 88, 181),
                                        radius: 85,
                                        child: CircleAvatar(
                                          backgroundImage: (snapshot
                                                      .data['data'][i]['img']
                                                      .toString() !=
                                                  "")
                                              ? Image.network(
                                                  "${linkServerName}/upload/${snapshot.data['data'][i]['img'].toString()}",
                                                  fit: BoxFit.cover,
                                                ).image
                                              : Image.asset('images/i1.jpeg')
                                                  .image,
                                          radius: 80,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                        child: Text(
                                      "${snapshot.data['data'][i]['name'].toString()}",
                                      style: TextStyle(
                                          fontFamily: AutofillHints.familyName,
                                          color:
                                              Color.fromARGB(255, 69, 88, 181),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23),
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    isLoding == true
                                        ? CircularProgressIndicator()
                                        : (respon.isEmpty == true)
                                            ? RatingBarr(
                                                rating: 0, ratingCount: 0)
                                            : RatingBarr(
                                                rating: respon[1] / 1.0,
                                                ratingCount: respon[0],
                                              ),
                                    (_isButtonDisabled == false)
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90.0),
                                                  side: BorderSide(
                                                      color: Colors.white)),
                                              color: Color.fromARGB(
                                                  255, 69, 88, 181),
                                              onPressed: () {
                                                openDialog1("! تقيمك");
                                              },
                                              child: Text(
                                                "تقييم",
                                                style: TextStyle(
                                                    fontFamily: "ReadexPro",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            "تم التقييم",
                                            style: TextStyle(
                                                color: redColor.primaryColor,
                                                fontSize: 14,
                                                fontFamily: "ReadexPro"),
                                            textAlign: TextAlign.center,
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(90.0),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 69, 88, 181))),
                                        color: Colors.white,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      chatRome(
                                                        senderId: sharedPref
                                                                .getString(
                                                                    "id") ??
                                                            "",
                                                        receiverId: snapshot
                                                            .data['data'][i]
                                                                ['user_Id']
                                                            .toString(),
                                                        receiverName: snapshot
                                                            .data['data'][i]
                                                                ['name']
                                                            .toString(),
                                                        senderName: '',
                                                      )));
                                        },
                                        child: Text(
                                          "دردشة",
                                          style: TextStyle(
                                              fontFamily: "ReadexPro",
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 69, 88, 181),
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 69, 88, 181),
                                      height: 25,
                                      thickness: 2,
                                      indent: 5,
                                      endIndent: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          ": المخزون",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 69, 88, 181)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                    FutureBuilder(
                                        future: read_from_Inventory(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data != null) {
                                              return ListView.builder(
                                                  itemCount: snapshot
                                                      .data['data'].length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, i) {
                                                    return Stack(children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            //  color: Colors.white,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          69,
                                                                          88,
                                                                          181),
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          )),
                                                      Positioned(
                                                        top: 20,
                                                        right: 50,
                                                        child: Container(
                                                          width: 100,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                ": النوع",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            69,
                                                                            88,
                                                                            181),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                snapshot.data[
                                                                        'data']
                                                                        [i]
                                                                        ['type']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 20,
                                                        left: 60,
                                                        child: Container(
                                                          width: 150,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                ": التصنيف",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            69,
                                                                            88,
                                                                            181),
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                snapshot.data[
                                                                        'data']
                                                                        [i][
                                                                        'classification']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ]);
                                                  });
                                            }
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                      child: Lottie.asset(
                          "assets/Animation - 1706023859153.json"));
                                          }
                                          return Center(
                                            child: Text(
                                              "لايوجد",
                                              style: TextStyle(
                                                  color:  Color.fromARGB(255, 69, 88, 181)),
                                            ),
                                          );
                                        }),
                                  ]),
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
                }),
          ],
        ),
      ),
    );
  }

  Future openDialog1(
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
                width: 300,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 69, 88, 181),
                          size: 20,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            rat = rating;
                          });
                          //print(rat);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "إلغاء",
                              style: TextStyle(
                                  fontFamily: "ReadexPro",
                                  fontWeight: FontWeight.bold,
                                  color: redColor.primaryColor,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () async {
                              await addRating();
                              _isButtonDisabled = true;
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text(
                              "حفظ",
                              style: TextStyle(
                                  fontFamily: "ReadexPro",
                                  fontWeight: FontWeight.bold,
                                  color: redColor.primaryColor,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ])))),
      );
  Future openDialog7(String title, String object) => showDialog(
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
                    height: 10,
                  ),
                  Text("${object}",
                      style: TextStyle(
                        fontFamily: "ReadexPro",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right),
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

class RatingBarr extends StatelessWidget {
  final double rating;
  final double size;
  final int ratingCount;
  RatingBarr({required this.rating, required this.ratingCount, this.size = 30});

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        _starList.add(Icon(Icons.star,
            color: Color.fromARGB(255, 69, 88, 181), size: size));
      } else if (i == realNumber) {
        _starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star,
                  color: Color.fromARGB(255, 69, 88, 181), size: size),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star, color: Colors.grey, size: size),
              )
            ],
          ),
        ));
      } else {
        _starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }
    // ignore: unnecessary_null_comparison
    ratingCount != null
        ? _starList.add(
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('($ratingCount)',
                    style: TextStyle(
                        fontSize: size * 0.8,
                        color: Color.fromARGB(255, 167, 161, 161)))),
          )
        : SizedBox();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
