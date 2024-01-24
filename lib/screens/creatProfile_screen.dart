import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/widget/dark_theams.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class creatProfile extends StatefulWidget {
  final String name;
  const creatProfile({super.key, required this.name});

  @override
  State<creatProfile> createState() => _creatProfileState();
}

class _creatProfileState extends State<creatProfile> {
  Curd _curd = Curd();

  sendProfile() async {
    isLoding = true;
    setState(() {});

    var respons = await _curd.postRequstWithFile(
        linkcreat_profile,
        {
          "name": name.text.trim().toString(),
          "type": dropdownValue2.toString(),
          "user_id": sharedPref.getString("id") ?? "",
        },
        myfole!);

    if (respons["status"] == "success") {
      isLoding = true;
      setState(() {});
      sharedPref.setString("profil", "1");
      Navigator.pop(context);
    } else {
      isLoding = false;

      setState(() {});
      print(respons["status"]);
    }
  }

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController name = TextEditingController();
  File? myfole;
  String dropdownValue2 = 'الحساب';
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoding == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
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
                              backgroundImage: (myfole != null)
                                  ? Image.file(
                                      myfole!,
                                      fit: BoxFit.cover,
                                    ).image
                                  : Image.asset('images/i1.jpeg').image,
                              radius: 80,
                            ),
                          ),
                          IconButton(
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
                        ],
                      ),
                    ),
                  ),
                  Center(
                      child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formstate,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              validator: (Text) {
                                if ((Text!.length > 15) && !Text.isEmpty) {
                                  return "لايمكن ان يكون النص اكثر من ${15}";
                                }
                              },
                              controller: name,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: "الأسم",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: "ReadexPro",
                                ),
                                labelText: "ادخل الأسم",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "ReadexPro"),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: redColor.primaryColor, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: redColor.primaryColor, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90))),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              DropdownButton<String>(
                                // Step 3.
                                hint: Text(
                                  "${dropdownValue2}",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 144, 144, 144)),
                                ),
                                //  value: dropdownValue3,
                                dropdownColor: Colors.white,
                                // Step 4.

                                items: <String>[
                                  'مستخدم',
                                  'صاحب تشليح',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 144, 144, 144)),
                                    ),
                                  );
                                }).toList(),

                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue2 = newValue!;
                                  });
                                  (context as Element).reassemble();
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(": نوع الحساب")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                              color: redColor.primaryColor,
                              onPressed: () async {
                                await sendProfile();
                              
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //  Center(child: IconButton(onPressed: (){; }, icon: FaIcon(FontAwesomeIcons.upload),color: Colors.white,)),
                                  Center(
                                      child: Text("ارفع صفحتك",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: "ReadexPro",
                                          ))),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
    );
  }
}
