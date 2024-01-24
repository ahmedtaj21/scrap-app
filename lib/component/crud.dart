import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class Curd{
  getRequst(String url)async{
    try{
     var respons= await http.get(Uri.parse(url));
     if(respons.statusCode == 200){
        var responsBody = jsonDecode(respons.body);
        return responsBody;
     }
     else{
      print("Error ${respons.statusCode}");
     }
    }catch(e){
        print("error catch {$e}");
    }
  }


  postRequst(String url,Map data)async{
  //  await Future.delayed(Duration(seconds: 2));
    try{
     var respons= await http.post(Uri.parse(url),body: data);
     if(respons.statusCode == 200){
        var responsBody = jsonDecode(respons.body);
        return responsBody;
     }
     else{
      print("Error ${respons.statusCode}");
     }
    }catch(e){
        print("error55 catch $e");
    }
  }
  postRequstWithFile(String url,Map data,File file)async{
    
   // await Future.delayed(Duration(seconds: 2));
  var request = http.MultipartRequest("POST",Uri.parse(url));
  var lenth =await file.length();
  var streem=http.ByteStream((file.openRead()) );
  var multiPartFile =http.MultipartFile("file", streem, lenth,filename:basename(file.path) );
  request.files.add(multiPartFile);
  data.forEach((key, value) {
    request.fields[key]=value;
   });
       var  myrQuest=await request.send();
       var  respons =await http.Response.fromStream(myrQuest);
       if(myrQuest.statusCode==200){
          return jsonDecode(respons.body);
       }else{
        print("error ${myrQuest.statusCode}");
       }

  }

//  fetch(String url) async {
// //String apiurl = "";
// var response = await http.post(Uri.parse(url), body: {
//  // 'username': email //get the username text
// });

// if(response.statusCode==200) //as wish wish check your response
// {
//    List<Model> model =  jsonDecode(response.body).map((item) => item).toList();
//      return model
//    }

//     } 





  // verfiyCode(String url,Map data) async {
  //   await Future.delayed(Duration(seconds: 2));
  //   try{
  //    var respons= await http.post(Uri.parse(url),body: data);
  //    if(respons.statusCode == 200){
  //       var responsBody = jsonDecode(respons.body);
  //       return responsBody;
  //    }
  //    else{
  //     print("Error ${respons.statusCode}");
  //    }
  //   }catch(e){
  //       print("error55 catch $e");
  //   }
  // }
}