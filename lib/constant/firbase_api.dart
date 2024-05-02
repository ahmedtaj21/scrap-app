import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';

class FirbaseApi {
  Curd _curd = Curd();
  final _firbasemessaging = FirebaseMessaging.instance;
  Future<void> initNotfy() async {
    await _firbasemessaging.requestPermission();
    final FCMtoken = await _firbasemessaging.getToken();
    sharedPref.setString("token", FCMtoken.toString());
    print('token: $FCMtoken');
    //FirebaseMessaging.onBackgroundMessage((message) => null)
  }
Future<void> exsistProfile() async {
    // isLoding = true;
    // setState(() {});
    var respons = await _curd.postRequst(
        linkreed_creat_profile, {'id': sharedPref.getString("id") ?? ""});

    if (respons["status"] == "success") {
      sharedPref.setString("profil", respons['data']['name']);
      // print("kkkkkkkkkkkkkkkkkkkkkk");
       print(sharedPref.getString("profil"));
      // print(respons["status"]);
      // print(respons);
    //  return respons;
    } else {
        sharedPref.setString("profil", '');
    //  return null;
    }
  }

  //  Future <void> notfication() async {

  //        var respons = await _curd.postRequst("", {

  //   });
  //  // print(widget.email);
  //   if(respons["status"] == "success"){

  //      sharedPref.setString("adminToken", respons["data"][0]["token"]);

  //   }

  //  }
}
