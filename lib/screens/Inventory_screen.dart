import 'package:flutter/material.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';
import 'package:scrap_app/widget/dark_theams.dart';

class Inventory extends StatefulWidget {
  final String name;
  const Inventory({super.key, required this.name});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  String dropdownValue1 = 'تصنيف القطعة';
  String dropdownValue2 = 'الشركة';
  Curd _curd = Curd();
  bool isLoding = false;

  add_to_Inventory() async {
      isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(linkInventory, {
      "userId": sharedPref.getString("id") ?? "",
      "classification": dropdownValue1,
      "type": dropdownValue2,
      "name": widget.name.toString(),
      "token": sharedPref.getString("token") ?? "",
    });

    if (respons["exsist"] == "yes") {
      await openDialog3("سبق لك ان قمت بإضافة هذا العنصر لمخزونك");
    } else {
      if (respons["status"] == "success") {
          isLoding = false;
        await read_from_Inventory();
        setState(() {});
      } else {
          isLoding = true;
    setState(() {});
      }
    }
  }

  deletOrder(id) async {
    isLoding = true;
    setState(() {});
    var respons = await _curd.postRequst(linkdelet_from_Inventory, {
      'id': id.toString(),
    });

    if (respons["status"] == "success") {
      await read_from_Inventory();
      isLoding = false;
      setState(() {});
    } else {
        isLoding = false;
      setState(() {});
    }
  }

  read_from_Inventory() async {
    var respons = await _curd.postRequst(linkread_Inventory, {
      "userId": sharedPref.getString("id") ?? "",
    });

    if (respons["status"] == "success") {
      return respons;
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.white)),
                  color: Colors.white,
                  onPressed: () async {
                    await add_to_Inventory();
                  },
                  child: Text("إضافة",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "ReadexPro"))),
              //  SizedBox(width: 10,),
              // VerticalDivider(
              //   color: Colors.white,
              //   thickness: 2,
              //   indent: 5,
              //   endIndent: 5,
              // ),
              DropdownButton<String>(
                // Step 3.
                hint: Text(
                  "${dropdownValue1}",
                  style: TextStyle(color: Colors.white),
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
                          color: Color.fromARGB(255, 144, 144, 144)),
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

              VerticalDivider(
                color: Colors.white,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              DropdownButton<String>(
                // Step 3.
                hint: Text(
                  "${dropdownValue2}",
                  style: TextStyle(color: Colors.white),
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
                          color: Color.fromARGB(255, 144, 144, 144)),
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
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(240, 236, 233, 233),
      body:(isLoding==true)?Center(child: CircularProgressIndicator(),) : FutureBuilder(
          future: read_from_Inventory(),
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
                            //  color: Colors.white,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await deletOrder(
                                          snapshot.data['data'][i]['id']
                                              .toString(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        ": التصنيف",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data['data'][i]
                                                ['classification']
                                            .toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        ": النوع",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data['data'][i]['type']
                                            .toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
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
    );
  }

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
