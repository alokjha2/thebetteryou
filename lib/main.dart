
import 'dart:io';
import 'package:alok/Homepage/home.dart';

import 'package:alok/introduction/intro.dart';
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
  await Firebase.initializeApp();
  await Hive.initFlutter(); 
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
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
    home : isviewed != 0 ? OnBoardpage() : MainPage(),
  );
}