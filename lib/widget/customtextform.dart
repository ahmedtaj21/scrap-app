import 'package:flutter/material.dart';
// ignore: implementation_imports, unused_import
import 'package:flutter/src/widgets/container.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:scrap_app/main.dart';
// import 'package:flutter_noteapp_1/main.dart';
// import 'package:flutter_noteapp_1/widget/dark_theams.dart';

class customTextform extends StatefulWidget {
  final String hint;
  final String labelText;
  final int maxLength;
  final int formChoose;
  
  final bool obscure;
  final TextEditingController myControl;
  const customTextform({super.key, required this.hint, required this.myControl, required this.obscure, required this.maxLength, required this.formChoose, required this.labelText});

  @override
  State<customTextform> createState() => _customTextformState();
}

class _customTextformState extends State<customTextform> {
  bool obscure1=true;
   
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        enableInteractiveSelection: true,
        textAlign: TextAlign.right,
  
        style: TextStyle(color:
        sharedPref.getBool("mode") ?? ""==true? Colors.white: 
        Colors.black,),
           validator:
           (Text) {
       
             if(Text!.length<widget.maxLength && (widget.formChoose==1 || widget.formChoose==0) && !Text.contains('/') && !Text.contains('#') ){
              return "لايمكن ان يكون النص اقل من ${widget.maxLength}";
             }if((Text.length>10||Text.length<10||!Text.startsWith("05")) &&widget.formChoose==2 && !Text.contains('/') && !Text.contains('#')){
               return "لايمكن ان لا يكون الرقم اقل او اكثر من ${widget.maxLength}";
             }
             if(!(Text.contains("@gmail.com")||Text.contains("@hotmail.com")||Text.contains("@outlok.com"))&&(widget.formChoose==3) && !Text.contains('/') && !Text.contains('#')){
               return"البريد الالكتروني غير صحيح";
             }
             return null;
           },
           
          textDirection: TextDirection.rtl,
         keyboardType:(widget.formChoose==1||widget.formChoose==0)? TextInputType.text:(widget.formChoose==2)?TextInputType.number:(widget.formChoose==3)?TextInputType.emailAddress:TextInputType.text,
        
        obscureText:(widget.formChoose==1||widget.formChoose==4)?obscure1: widget.obscure,
        controller:widget.myControl,
         decoration: InputDecoration(
         prefixIcon:
            (widget.formChoose==0)?
             Icon(Icons.person_2_outlined,color:
             sharedPref.getBool("mode") ?? ""==true?Colors.white:
              Colors.black45,)
          :(widget.formChoose==1||widget.formChoose==4)?InkWell(
            onTap: () {
                if(obscure1==true){
                         obscure1=false;
            setState(() {
              
            });  
            
                }else{
                          obscure1=true;
            setState(() {
              
            });
                }
          
              //print(obscure1);
            },
            child: Icon((obscure1==true)?Icons.visibility_off:Icons.visibility,
            color:
           sharedPref.getBool("mode") ?? ""==true?Colors.white:
             Colors.black45,)):(widget.formChoose==3)?Icon(Icons.email_outlined,
             color:
             sharedPref.getBool("mode") ?? ""==true?Colors.white:
              Colors.black45,):Icon(Icons.phone,color:
              sharedPref.getBool("mode") ?? ""==true?Colors.white:
               Colors.black45,),
          
          
          // suffixIcon: GestureDetector(
          //   onTap: () {
              
          //   },
          //   child: Icon(Icons.visibility_off),
          // ),
          labelText:widget.labelText ,
         labelStyle:  TextStyle(
        color:
         sharedPref.getBool("mode") ?? ""==true?Colors.white:
         Colors.black ,
        fontFamily: "ReadexPro",
        
        fontWeight: FontWeight.bold
             ),
          hintText:widget.hint,
          hintStyle: TextStyle(color:
            sharedPref.getBool("mode") ?? ""==true? Colors.white:
            Colors.black),
          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(90))
            
            ),
             enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          //sharedPref.getBool("mode") ?? ""==true?const Color.fromARGB(255, 233, 60, 60): redColor.primaryColor, 
                          width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:Colors.black,
//sharedPref.getBool("mode") ?? ""==true?const Color.fromARGB(255, 233, 60, 60): redColor.primaryColor,
                           width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                           
         ),
      ),
    
        
      
    );
  }
}