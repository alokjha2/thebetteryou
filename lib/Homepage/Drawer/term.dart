import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart' show rootBundle;



class Term extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return TermState();
  }
}

class TermState extends State<Term>{
  String data = '';

  fetchFileData() async{
    String responseText;
    responseText = await rootBundle.loadString('assets/text-files/terms.txt');

    setState((){
      data = responseText;

    });
  }
  @override
  void initState(){
  fetchFileData();
  super.initState();
  }
  @override
  Widget build(BuildContext context ){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms and Conditions"
          ,style: 
      
      GoogleFonts.ubuntu(textStyle: 
                
      
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20, 
      // fontFamily: "Ubuntu"
      
      ),)
      
      
      ),
      centerTitle: true,
      elevation: 2,
      // toolbarHeight: 24,  ),),)
            ),
      
      
      // body: Center(child: Text(data, style: TextStyle(fontSize: 30),),)
      
      body: 
      Container(
        child: SingleChildScrollView(
          child: 
      
      
      Text(
        data,
        style: 
        
        GoogleFonts.ubuntu(textStyle: 
        TextStyle(
          color: Colors.grey,
          fontSize: 16, 
      // Divider(),
          // fontStyle: FontStyle.italic,
          decorationColor: Colors.grey),)))
    ));
}
}







