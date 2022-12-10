// home page of all navigation drawer



import 'package:alok/Homepage/Drawer/about.dart';
import 'package:alok/Homepage/Drawer/bookmarks.dart';
import 'package:alok/Homepage/Drawer/downloads.dart';
import 'package:alok/Homepage/Drawer/settings.dart';
import 'package:alok/Homepage/Drawer/term.dart';
import 'package:alok/introduction/userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alok/introduction/userinfo.dart';

class Drawere extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(user.displayName!, style:  GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)
                      ,), ),
                  accountEmail: Text(user.email!, style:  GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)
                      ),),
                  currentAccountPicture:
                  
                InkWell(
                  child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!),
                      ),
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Userdatainfo()));
                        },
                      ),
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [
                      Colors.blue,
                      Colors.lightBlue
                    ],
                    end: Alignment.bottomCenter,
                    ) 
                    ),
                  ),

                // Bookmark screen
                ListTile(

                      leading: Icon(Icons.bookmark_outlined,color: Colors.orange,size: 25),
                      title: Text("Bookmarks",style: 
                       GoogleFonts.ubuntu(textStyle: 
                      TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
                      ),),
                      onTap : ()
                        {
                        Navigator.of(context).pop();
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,
                  // duration:  Duration(seconds: 1), 
                  child: 
                  LoaderOverlay(child:
                  Bookmark())
                  )
                  );
                  }
                  ),

                  // downloads
                ListTile(

                      leading: Icon(Icons.download_for_offline_outlined,color: Colors.blue,size: 25),
                      title: Text("Downloads",style: 
                       GoogleFonts.ubuntu(textStyle: 
                      TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
                      ),),
                      onTap : ()
                        {
                        Navigator.of(context).pop();
                  Navigator.push(
                    context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                  // duration:  Duration(seconds: 1), 
                  child: 

                  Downloads()));}
                  ),



                // Feedback screen
                ListTile(
                  leading:const  Icon(Icons.feedback,color: Colors.green),
                  title:  Text("Feedback/Suggestion", 
                  style: 
                   GoogleFonts.ubuntu(textStyle: 
                  TextStyle(fontWeight: FontWeight.bold, 
                  fontSize: 18,
                    ))
                  ),
                  onTap : ()
                    => launch('mailto:alokj4702@gmail.com?subject=FeedBack')
                ),


                // Terms & Condition
                ListTile(
                  leading: const  Icon(Icons.privacy_tip,color: Colors.purple),
                  title: Text("Terms & Conditions", style: 
                   GoogleFonts.ubuntu(textStyle: 
                  TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18,
                      ),)
                    ),
                  onTap : ()
                      {
                        Navigator.of(context).pop();
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,
                  //  duration:  Duration(seconds: 1),
                    child: 
                    LoaderOverlay(child:
                    Term())
                    ));
                      }
                      ),
                // Connect with us screen
                ListTile(
                  leading: Icon(Icons.contact_page_sharp, color: Colors.red),
                  title: Text("Connect with us", style: 
                   GoogleFonts.ubuntu(textStyle: 
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18, 
                    ))
                  ),
                onTap : ()

                 {
                        Navigator.of(context).pop();
                   Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,
                  //  duration:  Duration(seconds: 1),
                   child: 
                   LoaderOverlay(child:
                   About())
                   )
                   );
                 }),
                  
                
                // rate the app
                ListTile(
                  leading: Icon(Icons.star_rate, color: Colors.yellow[600], size: 28,),
                  title: Text("Rate our app", style: 
                   GoogleFonts.ubuntu(textStyle: 
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                    ))
                  ),
                onTap : ()=> StoreRedirect.redirect(
                  androidAppId : "com.alok.audiobook")
                  
                ),






                SizedBox(height: 100,),


                // report bug
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ListTile(
                        leading: Icon(Icons.bug_report,color: Colors.red[700]),
                        title: Text("Report Bug", style: 
                         GoogleFonts.ubuntu(textStyle: 
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                          ))
                        ),
                      onTap: ()=>
                        launch('mailto:alokj4702@gmail.com?subject=Bug Report')





                        )
                      )
                    ),    
        ]
      ),
          )
    );          
  }
}
