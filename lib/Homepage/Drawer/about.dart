import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;








class About extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return AboutState();
  }
}

class AboutState extends State<About>{
  
  // String data = "";
  // String about = "";
  String story_of_channel= "One day randomly I got an opportunity to read 'Mein Krishna Hoon'  By  'Deep trivedi' and after completing that series of book, the prespective of mine towards life got completely changed! I can relate with what Krishna is saying in that book. Because of that book i fell in love with books, then I start reading more books related to finance management, wealth creation, philosophy, physchology, technology and many more! Then one day I made a video with simple voice and black screen and uploaded on youtube and that video didn't got good attention from people but I found my love so i started making more videos and many more! This loop happened for months and then turning point of my journey happened because of my favourite book : Mein Krishna hoon , and my channel crossed milestones ||";
  String story_of_app = "I want to improve my content and one of my viewer who is my friend now known as bunny aka Alok suggested me some changes for channel either good animated video or app , so I choosed app and he coded and designed the first version of app with some basic feature ||";

  String link = " Email: alokj4702@gmail.com\n Instagram: @peckish_human\n Twitter: @peckish_human\n Youtube: The Better You";
  String connect = "Explore our social media channels to read about sweden's latest insight and our decisions, our unique culture and our differentiated approach to serving users and achieving enduring results. ";
  String dropping = "Here below we are dropping our social link e.g : Youtube, Telegram, Instagram, Twitter, Gmail || Go! and check out them also ||";




  // fetchFileData() async{
  //   String responseText;
  //   responseText = await rootBundle.loadString('assets/text-files/aboutus.txt');
  //   setState((){
  //     data = responseText;
  //   });
  // }
  // @override
  // void initState(){
  // fetchFileData();
  // super.initState();
  // }





  @override
  Widget build(BuildContext context ){
    return Scaffold(
      appBar: AppBar(title: Text("About us",style: 
      
      GoogleFonts.ubuntu(textStyle: 
                
      
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20, 
      // fontFamily: "Ubuntu"
      
      ),)
      
      
      ),
      centerTitle: true,
      elevation: 2,
      // toolbarHeight: 24,
      ),
      


      body: 
      Container(
        padding: EdgeInsets.fromLTRB(10, 4, 10, 2),
        child: SingleChildScrollView(
          child: 
            Column(
              children: 
              [




                // headline
                Text("Story behind our channel ! ", 
                
                
                style:
                GoogleFonts.ubuntu(textStyle: 
                 TextStyle(fontSize: 20, fontWeight: FontWeight.w600, 
                // fontFamily: "Ubuntu"
                ),
                // textAlign: TextAlign.center,
                ),),
      
      
                SizedBox(height: 4,),
                Divider(color: Colors.grey,thickness: 1,height: 1,endIndent: 3,),
                SizedBox(height: 6,),





                // story of channel
                Text(story_of_channel, style: 
                
                GoogleFonts.ubuntu(textStyle: 
                
                TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey ),),),
                SizedBox(height: 4,),
                // Divider(color: Colors.grey,thickness: 1,height: 1,endIndent: 3,),
                // SizedBox(height: 18,),





                Text("Story behind this Application! ", 
                
                
                
                style: 
                GoogleFonts.ubuntu(textStyle: 
                
                
                TextStyle(fontSize: 20, fontWeight: FontWeight.w600, 
                // fontFamily: "Ubuntu"
                ),
                // textAlign: TextAlign.center,
                ),),
      
      
                SizedBox(height: 4,),
                Divider(color: Colors.grey,thickness: 1,height: 1,endIndent: 4,),
                SizedBox(height: 6,),





                // story of app
                Text(story_of_app, style: 
                
                
                GoogleFonts.ubuntu(textStyle: 
                
                TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey ),),),


                Text("Connect With Us ", 
                
                
                
                style: 
                
                
                GoogleFonts.ubuntu(textStyle: 
                TextStyle(fontSize: 20, fontWeight: FontWeight.w700, ),),),
                SizedBox(height: 4,),
                Divider(color: Colors.grey,thickness: 1,endIndent: 3,indent: 6,),
                // Divider(color: Colors.grey,thickness: 1,endIndent: 3,indent: 6,),
                SizedBox(height: 4,),
                Text(connect, style: 
                
                GoogleFonts.ubuntu(textStyle: 
                
                
                TextStyle(fontSize: 18, fontWeight: FontWeight.w400, )),),
                SizedBox(height: 4,),
                Text(dropping, style: 
                
                
                GoogleFonts.ubuntu(textStyle: 
                
                TextStyle(fontSize: 16, fontWeight: FontWeight.w300, )),),
                SizedBox(height: 4,),
                Divider(color: Colors.grey,thickness: 1,endIndent: 3,indent: 6,),
                
      
                Text(link, style: 
                
                
                GoogleFonts.ubuntu(textStyle: 
                
                
                TextStyle(fontSize: 16, fontWeight: FontWeight.w300, )),textAlign: TextAlign.left,),
                SizedBox(height: 12,),
      
      
      
      
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
      
                    Spacer(),
                InkWell(child: 
                Image.asset("assets/youtube.png",height: 30,width:  40,fit: BoxFit.cover,),
                onTap: (){
                  launch("https://www.youtube.com/c/TheBetterYou");
                
      
                },
                
                ),
                    Spacer(),
                InkWell(child: 
                Image.asset("assets/telegram.png",height: 40,width:  40,fit: BoxFit.cover,),
                onTap: (){
                  launch("https://t.me/thebetteryouaudiobooks");
      
                },
                
                ),
                    Spacer(),
                InkWell(child: 
                Image.asset("assets/instagram.png",height: 40,width:  40,fit: BoxFit.cover,),
                onTap: (){
                  launch("https://www.instagram.com/peckish_human/");
                },
                
                ),
                    Spacer(),
                InkWell(child: 
                Image.asset("assets/twitter1.png",height: 32,width:  40,fit: BoxFit.cover,),
                onTap: (){
                  launch("https://twitter.com/peckish_human");
                },
                
                ),
                    Spacer(),
                InkWell(child: 
                Image.asset("assets/gmail_icon.png",height: 30,width:  40,fit: BoxFit.cover,),
                onTap: (){
                  launch('mailto:alokj4702@gmail.com?subject=Business');
                },
                ),
                    Spacer(),
                
                
      
                    ]
                    ),
      
                    SizedBox(height: 4,),
                    Divider(color: Colors.grey,thickness: 1,endIndent: 3,indent: 6,),
                    
      
                    Text("Sweden", style: 
                    GoogleFonts.ubuntu(textStyle: 
                
                    
                    
                    TextStyle(fontSize: 80, color: Colors.grey, fontWeight: FontWeight.w800),),),
                    Text("2022-present", style: 
                    
                    GoogleFonts.ubuntu(textStyle: 
                
                    
                    TextStyle(fontSize: 17, color: Colors.black),),),
                    SizedBox(height: 14,),
                    ]
                    )
                    )
                    )
      
    );
}
}















    