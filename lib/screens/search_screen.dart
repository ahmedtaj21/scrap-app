import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/home_screen.dart';
import 'package:scrap_app/screens/profile_page.dart';
import 'package:scrap_app/screens/profile_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  bool isLoding = false;
  Curd _curd = Curd();

  read_allAcount() async {
    var respons =
        await _curd.postRequst(linkread_allAcount, {"name": result.toString()});

    if (respons["status"] == "success") {
      return respons;
    } else {
      return null;
    }
  }

  // readProfile() async {
  //   var respons = await _curd.postRequst(
  //       linkreed_creat_profile, {'id': sharedPref.getString("id") ?? ""});

  //   if (respons["status"] == "success") {

  //     sharedPref.setBool("profil", true);

  //     return respons;
  //   } else {

  //     return null;
  //   }
  // }

  void initState() {
    super.initState();
    //readProfile();
    result = '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (isLoding == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: read_allAcount(),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => profilePage(
                                            id: snapshot.data['data'][i]
                                                    ['user_Id']
                                                .toString(),
                                          )));
                              
                                },
                                child: Container(
                                  //  color: Colors.white,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 77, 97, 194),

                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        //      colors:[Colors.white,Color.fromARGB(255, 141, 157, 235),Color.fromARGB(255, 69, 88, 181),] ),
                                        colors: [
                                          Colors.white,
                                          Color.fromARGB(255, 141, 157, 235),
                                          Color.fromARGB(255, 77, 97, 194),
                                        ]),

                                    // border: Border.all(
                                    //     color: Colors.black, width: 1.5),
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
                                            snapshot.data['data'][i]['name']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 88,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
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
                                          radius: 30,
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
                      // Padding(
                      //   padding: const EdgeInsets.all(18.0),
                      //   child:
                      Center(
                          child: Lottie.asset(
                              "assets/Animation - 1706023859153.json"));

                  // );
                }
                return Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        child: Image(
                          image: Image.asset('images/i2.jpg').image,
                        )),
                    Center(
                      child: Text("لاتوجد بيانات حاليا",
                          style: TextStyle(
                              color: Color.fromARGB(255, 69, 88, 181),
                              fontSize: 18)),
                    )
                  ],
                );
                //  Center(
                //   child: Text(
                //     "لايوجد",
                //     style: TextStyle(color: Colors.black54),
                //   ),
                // );
              }),
    );
  }
}
