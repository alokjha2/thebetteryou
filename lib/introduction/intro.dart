// introduction screens



import 'package:alok/Homepage/home.dart';
import 'package:alok/introduction/signpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:alok/main.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoardpage extends StatefulWidget {


  @override
 State<OnBoardpage> createState(){
   return OnBoardpageState();
 }
}

class OnBoardpageState extends State<OnBoardpage> {
  int currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }






  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: IntroductionScreen(
        
        showNextButton: true,
        showSkipButton: true,
        skip: Text("Skip", style:
        GoogleFonts.ubuntu(textStyle: 
      
         TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),),
        next: Icon(Icons.arrow_forward, size: 25,),
        globalBackgroundColor: Colors.white,
        isProgress: true, // hide bubble
        freeze: true,// can't swipe in both direction
        // skipColor: Colors.red,  
        // doneColor: Colors.green,  
        // nextColor: Colors.blue,
        dotsDecorator: DotsDecorator(
        activeColor: Colors.blue,
        color: Color(0xFFBDBDBD),
        size: Size(8,8),
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeSize: Size(8,8),
       
  ),
      pages: [




        
        // intro
        PageViewModel(
        title: 
      
        "Listen to unlimited AudioBook",
        body: "It's Free",
        image: buildImage("assets/listenbook.png", ), 
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        // decoration: PageDecoration(t)     
        ),


        //improve yourself by books
        PageViewModel(
        title: "Improve yourself with Self Help Books ",
        body: "Our platform is addictive ",
        image: buildImage("assets/2.png"),
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        ),



        //search
        PageViewModel(
        title: "Browse Audiobooks",
        body: "Search your favourite Audiobooks",
        image: 
        Image.asset("assets/goodsearch.png", width: 200,),
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        // buildImage("assets/goodsearch.png", ),      
        ),




        //comment
        PageViewModel(
        title: "Comment down your thoughts under your favourite Audiobooks !",
        body: "very interesting feature !",
        image: 
        Image.asset("assets/good_comment.png", width: 180,),
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        // buildImage("assets/good_comment.png"),
        ),


        //dark_mode
        PageViewModel(
        title: "Use app in dark mode also",
        body: "Dark mode is available",
        image: 
        
        Image.asset("assets/dark_mode.png", width: 150,),
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        // buildImage("assets/dark_mode.png"),
        ),



        //download books
        PageViewModel(
        title: "Download Audiobooks to listen it later! ",
        body: "Upcoming feature",
        image: buildImage("assets/download.png"),
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        ),


        //welcome
        PageViewModel(
        title: "Welcome to The Better You !",
        body: "By Pasternak.co",
        image: buildImage("assets/logo.png",),
        decoration: PageDecoration(
        titleTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
        bodyTextStyle: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
        color: Colors.black
           ),)
      ),
        ),
    

      ],
      
      
      done: Text(
        
        "Let's Go!", 
        
        style: 
        
        GoogleFonts.ubuntu(textStyle: 
        
        
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),),
      onDone: (){
       
        _storeOnboardInfo();
        goToHome(context);
      },
    )
    );
  
    
  }
  void goToHome(context) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Signup()));
Widget buildImage(String path) =>
  Center(
    child: 
    
    Image.asset(path, width: 250,),
    
   
    
    );
 
}
  
  
  
  
  
  
  
  

 
