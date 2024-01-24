import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/main.dart';

class FirbaseApi{
  Curd _curd = Curd();
  final _firbasemessaging = FirebaseMessaging.instance;
  Future <void> initNotfy() async {
    await _firbasemessaging.requestPermission();
    final FCMtoken = await _firbasemessaging.getToken();
    sharedPref.setString("token",FCMtoken.toString());
    print('token: $FCMtoken');
    //FirebaseMessaging.onBackgroundMessage((message) => null)
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