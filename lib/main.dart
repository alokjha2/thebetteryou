
import 'dart:io';
import 'package:alok/Homepage/home.dart';

import 'package:alok/introduction/intro.dart';
import 'package:alok/introduction/signpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyBQ_l40VUKpCdCEU3IJLuzhlKxh-jdImRY",
  // authDomain: "alok-2b7e5.firebaseapp.com",
  // databaseURL: "https://alok-2b7e5-default-rtdb.firebaseio.com",
  // projectId: "alok-2b7e5",
  // storageBucket: "alok-2b7e5.appspot.com",
  // messagingSenderId: "634681148755",
  // appId: "1:634681148755:web:9fd7b7fe35d2d16f304da6",
  // measurementId: "G-2STWM522Z7"

  // )
  );
  // FirebaseFirestore.instance
  //     .enablePersistence(const PersistenceSettings(synchronizeTabs: false));
  
  // await Firebase.initializeApp(
    
  // );
  await Hive.initFlutter(); 
  // Directory directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  await Hive.openBox<String>("friends");
  await Hive.openBox<String>("Favourites");
  await Hive.openBox<String>('search_history');
  
  

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white70,
      systemNavigationBarIconBrightness: Brightness.light,
      )
    );
  runApp(MyApp());
  
 
}
class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) =>
  GetMaterialApp(
    title: "The better you",
    debugShowCheckedModeBanner: false, 
    home : 
    MainPage()
    // isviewed != 0 ? 
    // OnBoardpage()
    //  : FirebaseAuth.instance.currentUser == null ? Signup() :   MainPage(),
  );
}