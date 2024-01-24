import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrap_app/constant/firbase_api.dart';
import 'package:scrap_app/screens/chatRome_screen.dart';
import 'package:scrap_app/screens/home_screen.dart';
import 'package:scrap_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';



late SharedPreferences sharedPref;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
 await Firebase.initializeApp(
   //options: DefaultF
  );
  await FirbaseApi().initNotfy();

  //await FirbaseApi().notfication();

  runApp(const MyApp());
}
// void main() {
//   runApp(const MyApp());
//}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    //  title: 'Flutter Demo',
      theme: ThemeData(
      // colorScheme: ColorScheme.fromSwatch()
      //         .copyWith(secondary: Colors.white),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:AnimatedSplashScreen(
        
      splash:
             Lottie.asset(
                                    "assets/Animation - 1705936500635.json"),
        
                               nextScreen: home(),
      // Image.asset("images/i22.png"),
      
      duration:3000 ,
      //backgroundColor: Colors.white,

     splashTransition: SplashTransition.scaleTransition,
     
      
      
       
  
      ),
      //chatRome()
       //home(),
    );
  }
}
