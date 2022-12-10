import 'package:alok/Homepage/home.dart';
import 'package:alok/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: 
    AppBar(
      title: Text("Notification",style: 
      
      GoogleFonts.ubuntu(textStyle: 
                
      
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20,
      ),
      )
      
      ),
      // leading: IconButton(onPressed: (){
      //   Navigator.of(context).pop(MainPage());
      // }, icon: Icon(Icons.clear)),
      centerTitle: true,
      elevation: 2,
      // toolbarHeight: 24,
    ),
    body: Column(children: [
      Image.asset("assets/soon.png"),
      SizedBox(height: 4,),

      
      Center(
        child: Text("We are coming up with an Awesome auto saving notification feature! ", style:
        
        GoogleFonts.ubuntu(textStyle: 
        
        
         TextStyle(fontSize: 20, color: Colors.grey),),),
      ),
      SizedBox(height: 4,),
      Text("But good things come to those who wait :) ", style: 
      GoogleFonts.ubuntu(textStyle: 
      
      
      TextStyle(fontSize: 20, color: Colors.grey)),),
      SizedBox(height: 4,),
      Text("Stay tuned !",style: 
      GoogleFonts.ubuntu(textStyle: 
      
      
      TextStyle(fontSize: 20, color: Colors.grey)))
    ],)
    );
  }
}