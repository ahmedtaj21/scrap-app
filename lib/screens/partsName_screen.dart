import 'package:flutter/material.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/screens/home_screen.dart';
import 'package:scrap_app/screens/order_screen.dart';
import 'package:scrap_app/widget/dark_theams.dart';

class parts_name extends StatefulWidget {
  final String classfication;
  final String type;
  const parts_name(
      {super.key, required this.classfication, required this.type});

  @override
  State<parts_name> createState() => _parts_nameState();
}

class _parts_nameState extends State<parts_name> {
  List<Map> parts1 = [
    {"name": "ثرمستات المكيف", "isChecked": false},
    {"name": "المولد (الدينامو)", "isChecked": false},
    {
      "name": "الكمبروسر",
      "isChecked": false,
    },
    {
      "name": "الثلاجة",
      "isChecked": false,
    },
    {"name": "كمبيوتر", "isChecked": false},
    {"name": "مروحة", "isChecked": false},
    {"name": "البطارية", "isChecked": false},
    {"name": "الفيوزات", "isChecked": false},
    {"name": "الإسلاك الكهربائية", "isChecked": false},
    {"name": "المحركات الكهربائية", "isChecked": false},
    {"name": "الحساسات", "isChecked": false},
    {"name": "غير ذالك", "isChecked": false},
  ];
  List<Map> parts2 = [
    {"name": "المكينة", "isChecked": false},
    {"name": "رأس المكينة", "isChecked": false},
    {"name": "أذرع التوصيل", "isChecked": false},
    {"name": "طرمبة البنزين", "isChecked": false},
    {"name": "الرديتور", "isChecked": false},
    {"name": "حزام مروحة", "isChecked": false},
    {"name": "مضخة ماء(طرمبة الماء)", "isChecked": false},
    {
      "name": "الثروتل",
      "isChecked": false,
    },
    {"name": "عمود الكرنك", "isChecked": false},
    {"name": "المساعدات", "isChecked": false},
    {"name": "العكس", "isChecked": false},
    {"name": "نظام الفرامل", "isChecked": false},
    {"name": "غير ذالك", "isChecked": false},
  ];
  List<Map> parts3 = [
    {"name": "المراية الداخلية", "isChecked": false},
    {"name": "مفاتيح الزجاج", "isChecked": false},
    {
      "name": "الطبلون",
      "isChecked": false,
    },
    {"name": "الطارة", "isChecked": false},
    {"name": "غطاء الدرج", "isChecked": false},
    {"name": "مقعدة السائق", "isChecked": false},
    {"name": "مقعدة الراكب", "isChecked": false},
    {"name": "المقعدة الخلفية", "isChecked": false},
    {"name": "حزام الإمان", "isChecked": false},
    {"name": "مسند الرأس", "isChecked": false},
    {"name": "غير ذالك", "isChecked": false},
  ];
  List<Map> parts4 = [
    {"name": "الصدام الأمامي", "isChecked": false},
    {"name": "الغطاء الأمامي", "isChecked": false},
    {"name": "(اليمين) الرفرف الأمامي", "isChecked": false},
    {
      "name": "(اليسار) الرفرف الأمامي",
      "isChecked": false,
    },
    {"name": "السقف", "isChecked": false},
    {"name": "(اليمين) الرفرف الخلفي", "isChecked": false},
    {"name": "(اليسار) الرفرف الخلفي", "isChecked": false},
    {"name": "الشنطة", "isChecked": false},
    {"name": "الصدام الخلفي", "isChecked": false},
    {"name": "(يمين) الباب الإمامي", "isChecked": false},
    {"name": "(يسار) الباب الإمامي", "isChecked": false},
    {"name": "(يمين) الباب الخلفي", "isChecked": false},
    {"name": "(يسار) الباب الخلفي", "isChecked": false},
    {"name": "(يمين) المراية الجانبية", "isChecked": false},
    {"name": "(يسار) المراية الجانبية", "isChecked": false},
    {"name": "(يمين)  الإصطب الأمامي", "isChecked": false},
    {"name": "(يسار)  الإصطب الأمامي", "isChecked": false},
    {"name": "(يمين)  الإصطب الخلفي", "isChecked": false},
    {"name": "(يسار)  الإصطب الخلفي", "isChecked": false},
    {"name": "الجنوط", "isChecked": false},
    {"name": "مسمار العجلة", "isChecked": false},
    {"name": "غير ذالك", "isChecked": false},
  ];
  List parts = [];
  Curd _curd = Curd();
  bool isloding = false;
  updateParts() async {
    isloding = true;
    setState(() {
      
    });
    var respons = await _curd.postRequst(linkupdat_parts, {
      "user_Id": sharedPref.getString("id") ?? "",
      "classification": widget.classfication,
      "type": widget.type,
      "parts": parts.toString().replaceAll('[', '').replaceAll(']', ''),
    });
    if (respons["status"] == "success") {
          isloding = false;
    setState(() {
      
    });
      Navigator.pop(context);
    } else {
            isloding = false;
    setState(() {
      
    });
    }
    //  print(respons["status"]);
  }

  @override
  Widget build(BuildContext context) {
    return
        //  WillPopScope(
        //   onWillPop: () async {
        //     return
        //          sharedPref.setString("part", '');

        //   },
        //   child:
        Scaffold(
      appBar: AppBar(),
      body:(isloding==true)?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text(
              ': اختر القطعة',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            // The checkboxes will be here
            (widget.classfication == 'قطع كهربائية')
                ? Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: parts1.map((element) {
                    return CheckboxListTile(
                        activeColor: redColor.primaryColor,
                        value: element["isChecked"],
                        title: Text(element["name"]),
                        onChanged: (newValue) {
                          setState(() {
                            // print(newValue);
                            // for (var element in parts1) {
                            //   element["isChecked"] = false;
                            // }
                            element["isChecked"] = newValue;
                            if (element["isChecked"] == true) {
                              parts.add(element["name"]);
                              print(element["name"]);
                            } else {
                              print(parts);
                              parts.remove(element["name"]);
                            }
                          });
                        });
                  }).toList())
                : (widget.classfication == 'قطع ميكانيكية')
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: parts2.map((element) {
                        return CheckboxListTile(
                            activeColor: redColor.primaryColor,
                            value: element["isChecked"],
                            title: Text(element["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                print(newValue);

                                element["isChecked"] = newValue;
                                if (element["isChecked"] == true) {
                                  parts.add(element["name"]);
                                  print(element["name"]);
                                } else {
                                  print(parts);
                                  parts.remove(element["name"]);
                                }
                              });
                            });
                      }).toList())
                    : (widget.classfication == 'ديكورات')
                        ? Column(
                            children: parts3.map((element) {
                            return CheckboxListTile(
                                activeColor: redColor.primaryColor,
                                value: element["isChecked"],
                                title: Text(element["name"]),
                                onChanged: (newValue) {
                                  setState(() {
                                    element["isChecked"] = newValue;
                                    if (element["isChecked"] == true) {
                                      parts.add(element["name"]);
                                      print(element["name"]);
                                    } else {
                                      print(parts);
                                      parts.remove(element["name"]);
                                    }
                                  });
                                });
                          }).toList())
                        : Column(
                            children: parts4.map((element) {
                            return CheckboxListTile(
                                activeColor: redColor.primaryColor,
                                value: element["isChecked"],
                                title: Text(element["name"]),
                                onChanged: (newValue) {
                                  setState(() {
                                    element["isChecked"] = newValue;
                                    //  print(  element["name"]);
                                    if (element["isChecked"] == true) {
                                      parts.add(element["name"]);
                                      print(element["name"]);
                                    } else {
                                      print(parts);
                                      parts.remove(element["name"]);
                                    }
                                    // for (var element in parts1) {
                                    //   if (element["isChecked"] == true) {
                                    //     parts.add(element["name"]);
                                    //     print(element["name"]);
                                    //   } else {
                                    //     print(parts);
                                    //   }
                                    // }
                                  });
                                });
                          }).toList()),

            // Display the result here
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ":  القطعة المختارة",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                (widget.classfication == 'قطع كهربائية')
                    ? Wrap(
                        // crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.end,
                        children: parts1.map((hobby) {
                          if (hobby["isChecked"] == true) {
                            return Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: redColor.primaryColor,
                                        width: 0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    hobby["name"],
                                    style:
                                        TextStyle(color: redColor.primaryColor),
                                  ),
                                ),
                              ),
                            );
                          }

                          return Container();
                        }).toList(),
                      )
                    : (widget.classfication == 'قطع ميكانيكية')
                        ? Wrap(
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.end,
                            children: parts2.map((hobby) {
                              if (hobby["isChecked"] == true) {
                                return Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: redColor.primaryColor,
                                            width: 0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        hobby["name"],
                                        style: TextStyle(
                                            color: redColor.primaryColor),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return Container();
                            }).toList(),
                          )
                        : (widget.classfication == 'ديكورات')
                            ? Wrap(
                                // crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.end,
                                children: parts3.map((hobby) {
                                  if (hobby["isChecked"] == true) {
                                    return Card(
                                      elevation: 3,
                                      color: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: redColor.primaryColor,
                                                width: 0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            hobby["name"],
                                            style: TextStyle(
                                                color: redColor.primaryColor),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return Container();
                                }).toList(),
                              )
                            : Wrap(
                                // crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.end,
                                children: parts4.map((hobby) {
                                  if (hobby["isChecked"] == true) {
                                    return Card(
                                      elevation: 3,
                                      color: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: redColor.primaryColor,
                                                width: 0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            hobby["name"],
                                            style: TextStyle(
                                                color: redColor.primaryColor),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return Container();
                                }).toList(),
                              ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: MaterialButton(
                    height: 40,
                    child: Text(
                      "حفظ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    onPressed: () async {
                      await updateParts();
                      // print(sharedPref.getString("id") ?? "");
                      // print(widget.classfication);
                      // print(widget.type);
                      //  Navigator.pop(context);
                    },
                    color: redColor.primaryColor,
                  ),
                )
              ],
            )
          ]),
        ),
      ),
      //    ),
    );
  }
}
