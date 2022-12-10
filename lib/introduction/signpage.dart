import 'package:avatar_glow/avatar_glow.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:alok/Homepage/home.dart';
import 'package:loader_overlay/loader_overlay.dart';


class Signup extends StatelessWidget{


  late AuthCredential credential;
  
  @override
  Widget build(BuildContext context){
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;
    // final padding1= EdgeInsets.all(10);
    return 
    
    
          
          Material(
            child: Container(
              height: screenh,
              width: screenw,
              // padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.lightBlue,
                    Colors.purple,
          
                    Colors.deepPurple,
               
          
              ]
              )
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Hello Friend,",
                        style: 
                        GoogleFonts.ubuntu(textStyle: 
                        TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),)
                      ),
                      SizedBox(height: 5,),
                      
                    
                      Text("Glad to see you!", style: 
                      
                      GoogleFonts.ubuntu(textStyle: 
                  
                      
                      TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),),
                      SizedBox(height: 6,),
                      Text("Thank's for selecting us.", style: 
                      
                      GoogleFonts.ubuntu(textStyle: 
                  
                      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),),
                      SizedBox(height: 10,),
          
                      AvatarGlow(
                        endRadius: 200.0,
                        duration: Duration(milliseconds: 2000),
                        glowColor: Colors.white,
                        repeat: true,
                        showTwoGlows: true,
                        animate: true,
                        curve: Curves.fastOutSlowIn,
                        repeatPauseDuration: Duration(milliseconds: 10),
                        
                          child: Image.asset("assets/hello.png")
                          ),
                SizedBox(height: 15,),
          
                TextButton(
                  
                  onPressed: 
                  ()=> googleSignIn().then((user)=>{
                    if(user != null){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) =>
                           LoaderOverlay(
                             
                  overlayWidget: CircularProgressIndicator(strokeWidth: 3,),
                  child:
                
                          MainPage()
                  )

                      ),
                  )}
                      }
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                          Image.asset('assets/google.png', height: 60, width: 50,),
                          Text(
                            "Login with Google",
                            style: 
                            GoogleFonts.ubuntu(textStyle: 
                  
                            
                            TextStyle(
                              fontSize: 25,
                              color: Colors.white
          
                                ),)
                              ),
                          
                            ]
                          ),
            )
          
                
                ]
                )
                
            
          )
      ),
    );
  }}



// logic for signup 

Future googleSignIn() async{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();


  var _authentication = await _googleSignInAccount?.authentication;

  var _credential = GoogleAuthProvider.credential(
    idToken: _authentication!.idToken,
    accessToken: _authentication.accessToken
  );
  User user = (await _auth.signInWithCredential(_credential)).user!;
  String uid = user.uid;

  return user;
}






// signout
Future googleSignOut(BuildContext context) async{
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  await _googleSignIn.signOut().then((value) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> 
    LoaderOverlay(
      overlayWidget: CircularProgressIndicator(strokeWidth: 3,),
      child:
    
    Signup())));
  
  });



  Future delete(BuildContext context)async{
    final user = await FirebaseAuth.instance.currentUser!;
    user.delete();
  }
// Future delete(BuildContext context)async{
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   var user = FirebaseAuth.auth().currentUser;

// user.delete().then(function() {
//   // User deleted.
// }).catch(function(error) {
//   // An error happened.
// // });

// //   final GoogleSignInAccount? googleUser1 = await GoogleSignIn().disconnect();
// }
}