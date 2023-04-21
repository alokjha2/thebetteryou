
import 'package:alok/Homepage/Drawer/settings.dart';
import 'package:alok/Homepage/content.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

import 'package:alok/Homepage/Drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:alok/introduction/signpage.dart';
import 'package:alok/Homepage/Appbar/notification.dart';
import 'package:alok/Homepage/Appbar/search.dart';
import 'package:firebase_auth/firebase_auth.dart';





class MainPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState(){
    return MainPageState();
  }
}

class MainPageState extends State<MainPage>{
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    // if(_auth.currentUser != null) {}else {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));}
  
  
  }




  @override
  Widget build(BuildContext context){
    

    return Scaffold(
      appBar: AppBar(
        title: 
        
        
        
        Text("Sweden"
          ,style: 
      
      GoogleFonts.ubuntu(textStyle: 
                
      
      TextStyle(fontWeight: FontWeight.w600, 
      ),
      
      
      ),
     ),
     elevation: 10,
      actions: [

          // search

          IconButton(
            onPressed:(){
            showSearch(context: context, delegate: DataSearch());
           
             } , 
          icon: Icon(Icons.search),
          
          ),


          // notifications
          IconButton(
            onPressed: ()
                      => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Notifications()
                      )
                      ),
                      icon: 
                      // Badge(
                      //   child: 
                        Icon(Icons.notifications_outlined),),
                      // badgeColor: Colors.transparent,
                      // badgeContent: Text("0", style: TextStyle(color: Colors.white),),),
                      // ),
                      
                      
                      





          



          
          

          PopupMenuButton<int>(
            // color: Colors.lightBlue,
            onSelected: (item)=> onSelected(context, item),

            itemBuilder: (context)=> [


            // PopupMenuItem(child: 
            //   Row(
            //       children: [
            //     // dark theme
            //     Icon(Icons.dark_mode, 
            //     color: Colors.blue,
            //     ),
            //     SizedBox(width: 8,),

            
            // Text("Dark/Light", 
            // style: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w400)
            //   ),),]),
            // value: 0,
            // ),

                // share button
            PopupMenuItem(child: Row(children: [
              
                Icon(Icons.share,
                color: Colors.blue,
                ),
                SizedBox(width: 8,),
                Text("Share", style: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w400)
              ))
                ]
                ),
                value: 1,
              ),

              // PopupMenuItem(child: Row(children: [
              //   Icon(Icons.settings, color: Colors.lightBlue,),
              //   SizedBox(width: 8,),
              //   Text("Settings", style: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w400)
              //   ))
              // ],),
              // value: 2,),

            
              //Signout
            PopupMenuDivider(height: 2,),
            // Divider(height: 2,),
            PopupMenuItem(
              child: Row(children: [
                Icon(Icons.logout, 
                color: Colors.blue,
                ),
                SizedBox(width: 8,),

              Text("Sign out",style: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w400)
              )),],),
              
              
            value: 3,
            )
          ])

    ],),


         body : 
        //  result !=  true?
          Content() ,
          // : settings(),
        // Offline(),
        
        drawer: Drawere(),
      );
    }
    
      void onSelected(BuildContext context, int item, ){
        switch (item){
                // dark theme
          // case 0:
          // Get.isDarkMode?
          //     Get.changeTheme(ThemeData.light()):
          //     Get.changeTheme(ThemeData.dark(
                
          //     ));
              
          //   break;



          // share button      
          case 1:
          Share.share('https://www.youtube.com/channel/UCg5n1J9p-Ring35J0grRYDQ', 
          subject: "India's first platform to listen unlimited audiobooks for free "
          );
            break;


            // case 2:
            // Navigator.of(context).pop();
            // Navigator.push(
            //         context, PageTransition(
            //           type: PageTransitionType.rightToLeft,
            //       // duration:  Duration(seconds: 1), 
            //       child: 

            //       settings()));
            // break;


          //Signout
          case 3:

          CoolAlert.show(
            context: context, 
          type: CoolAlertType.confirm, 
          title: "Signout", 
          text: "Are you sure you want to signout ?",
          onConfirmBtnTap: (){googleSignOut(context);}, 
          onCancelBtnTap: (){Navigator.of(context).pop();});
          // googleSignOut(context);
            break;
        }
      }
    }

   