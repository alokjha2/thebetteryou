
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
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';


int? isviewed;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  runApp(
    // ConnectivityWidget(child:
   MyApp()
  //  )
   );
  
 
}
class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Set up the background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission for notifications
    _firebaseMessaging.requestPermission();

    // Handle incoming FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Handle the notification when the app is in the foreground.
      print("Notification received while the app is in the foreground.");
      // Save the notification data to local storage
      await saveNotificationDataToLocal(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Handle the notification when the app is opened from a terminated state.
      print("Notification opened while the app was terminated.");
      // Save the notification data to local storage
      await saveNotificationDataToLocal(message.data);
    });
  }

  Future<void> saveNotificationDataToLocal(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Store the notification data as a string in local storage
    String notificationData = data.toString();
    await prefs.setString('notificationData', notificationData);
  }

  // Define the background message handler function
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle the message here, e.g., by saving it to local storage
    await saveNotificationDataToLocal(message.data);
  }

  @override
  Widget build(BuildContext context) =>
  GetMaterialApp(
    title: "Better you",
    debugShowCheckedModeBanner: false, 
    home : 
    // CheckConnectionPage()
    // MainPage()
    isviewed != 0 ? 
    OnBoardpage()
     : FirebaseAuth.instance.currentUser == null ? Signup() :   MainPage(),
  );
}
