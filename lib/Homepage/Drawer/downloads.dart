import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';


 

class Downloads extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text("Downloads",style: 
      GoogleFonts.ubuntu(textStyle: 
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20, 
      // fontFamily: "Ubuntu"
      
      ),)
      
      
      ),
      centerTitle: true,
      elevation: 2,
      ),
    body: Column(children: [
      Image.asset("assets/download.png", height: 500,width: 300,),
      SizedBox(height: 4,),
      Center(
        child: Text("We are coming up with an Awesome download your favourite book feature! ", style: 
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
      
      TextStyle(fontSize: 20, color: Colors.grey)
            )
          )
        ],
      )
    );
  }
}