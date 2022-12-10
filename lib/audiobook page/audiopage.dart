// AudioBook page
import 'package:alok/audiobook%20page/audiofunc/button.dart';
import 'package:alok/audiobook%20page/audiofunc/common.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alok/audiobook%20page/comment.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

import 'package:share_plus/share_plus.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'comment.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class Music extends StatefulWidget {
  final String? id;
  final String? img;
  final String? name;
  final String? author;
  final String? mp3;
  final String? description;


  Music({Key? key, @required this.img, @required this.name, @required this.author, @required this.mp3, @required this.description, @required this.id}) : super(key: key);

  @override
  State<Music> createState() => _MusicState(
  );
}

class _MusicState extends State<Music> with WidgetsBindingObserver {


  final snackBar = SnackBar(
    content: Text('Added to Bookmarks!',style: GoogleFonts.ubuntu(textStyle: TextStyle(),),), backgroundColor: Colors.blue,shape: BeveledRectangleBorder(), 
    duration: Duration(
      // seconds: 1, 
      milliseconds: 500),
    // duration: 
    );


  final snackBar1 = SnackBar(
    content: Text('Already added!',style: GoogleFonts.ubuntu(textStyle: TextStyle(),),), backgroundColor: Colors.red,shape: BeveledRectangleBorder(),
    duration: Duration(
      // seconds: 1, 
      milliseconds: 500),
    );


  final _player = AudioPlayer();


  CollectionReference users = FirebaseFirestore.instance.collection('book');

  FirebaseFirestore firestore = FirebaseFirestore.instance;
// for play and pause button  
  bool playing = false;
  IconData playBtn = Icons.play_circle_filled_sharp;


  // for bookmark
  bool saved = false;
  IconData savbtn = Icons.bookmark;


  late Box<String> friendsBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    friendsBox = Hive.box<String>("friends"); //name same as openBox
    _init();
  }



  

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
        widget.mp3!
        )));
          } catch (e) {
      SnackBar(content: Text("sorry"));
      }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  
  // @override
  // void initState() {
    // TODO: implement initState
    // super.initState();
    // friendsBox = Hive.box<String>("friends"); //name same as openBox
  // }


  @override
  Widget build(BuildContext context) {
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;
    
    // final screenH = MediaQuery.of(context).size.height;
    // final screenW = MediaQuery.of(context).size.width;

  String share = "Hey Buddy! , I am increasing my curiosity and intellect by listening to this amazing book called ${widget.name } written by ${widget.author}!\n So if you also want to join me then download this amazing app!\n App link: https://www.youtube.com/c/TheBetterYou";
    
    return Scaffold(
      
            body: 
            Container(
              height: screenh,
              width: screenw,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                   colors: [
                     Colors.blue,
                     Colors.lightBlue,
                    ]
                   ),
                  ),


                   child: Padding(
                     padding: EdgeInsets.only(top: 42,),
                      child: Container(
                        child: Column(
                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                                // screenw,
                              children: [

                            IconButton(
                              iconSize: 30,
                              color: Colors.white,
                              onPressed: (){
                                Navigator.pop(context);
                                },
                              icon: Icon(Icons.arrow_back_ios_sharp)
                            ),




                            // AudioBook text
                            Text(
                              "Audiobook",style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600))),

                            Spacer(),
                            IconButton(onPressed: (){
                              // modal();
                            }, icon: Icon(Icons.more_vert_outlined), color: Colors.white,),
                            Padding(padding: EdgeInsets.only(left: 12)),]),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                              children :[
                                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: Colors.transparent,size: 30,)),
                                // Spacer(),
                                Text(
                                  "Listen to your favourite Books",style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400))),
                                Spacer(),
                              ],
                            ),


                            SizedBox(height: 24,),

                            // image
                            Center(child: Container(width: 310,height: 310,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30),image: DecorationImage(image: NetworkImage(widget.img!),fit: BoxFit.cover)))),


                            SizedBox(height: 18,),


                            Center(
                              child: 
                              Column(
                                children: [
                              // name of book
                              Text(widget.name!,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600))),

                              // author name
                              Text("By ${widget.author!}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)))
                              ])
                            ),


                        SizedBox(height: 30,),

                        Expanded(
                          
                          child: Container(
                          height: 120,
                          
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),

                        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                                
                                
                                StreamBuilder<PositionData>(
                                  stream: _positionDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 4, 30, 2),
                                      child: ProgressBar(
                                        timeLabelTextStyle: TextStyle(color: Colors.blue),
                                        progress: 

                                        
                                      
                                        positionData?.position ?? Duration.zero, 
                                        total: positionData?.duration ?? Duration(),
                                        timeLabelLocation: TimeLabelLocation.below,
                                        buffered: positionData?.bufferedPosition ?? Duration.zero,
                                        onSeek: _player.seek,
                                        ),
                                    );
                                    },
                                ),


                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [

                                  //comment
                                  IconButton(color: Colors.blue,onPressed: (){
                                      print(widget.id);
                                      // Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 2), child: CommentPage(id: widget.id!,)));
                                      Navigator.of(context).push(PageTransition(type: PageTransitionType.bottomToTop, 
                                      // duration: Duration(seconds: 1), 
                                      child: 
                                      LoaderOverlay(child:
                                      CommentPage(id: widget.id!,))));
                                      
                                }, icon: Icon(Icons.comment_rounded), iconSize: 30),

                               
                                    Spacer(),

                                    IconButton(
                                    color: Colors.blue,
                                    onPressed: (){
                                      // showAsBottomSheet();
                                      description();
                                      },
                                    icon: Icon(Icons.summarize), 
                                    iconSize: 30,
                                    ),

                                    Spacer(),
                                    //share
                                    IconButton(onPressed: (){Share.share(share,);}, icon: Icon(Icons.share),color: Colors.blue,iconSize: 30),
                                    Spacer(),
                               IconButton(
                                 onPressed: (){
                                String key = widget.name ?? "";
                                String value = widget.author?? "";  


                                if(key!=friendsBox){ 
                                friendsBox.put(key, value);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                              }
                              
      
                               }, icon: Icon(
                                 
                                 savbtn,
                                 color: Colors.blue, size: 30,))



                                ],
                                ),

                                
                                SizedBox(height: 16),

                                
                              Row(

                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               ControlButtons(_player),

                                  ],
                            ),
                           

                              SizedBox(
                                height: 2),

                                ],
                              ),
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                
              
                          )
                        )
                        )
                        
       
        );
  }

// more features on pressed
// modal({required BuildContext context}){
//   showAdaptiveActionSheet(
//   isDismissible: true,
//   context: context,
//   title: Text('More Features!', style: GoogleFonts.ubuntu(textStyle: TextStyle())),
//   androidBorderRadius: 30,
//   actions: <BottomSheetAction>[
//     BottomSheetAction(
//       title:  Text('Details', style: GoogleFonts.ubuntu(textStyle: TextStyle())), 
//       onPressed: (){
//         // CoolAlert.show(context: context, type: CoolAlertType.loading, title: "Coming Soon",text: "We'r working on this feature",);
//         },
//   ),

//     BottomSheetAction(
//       title:  Text('Sleep timer', style: GoogleFonts.ubuntu(textStyle: TextStyle())), 
//       onPressed: (){
//         // CoolAlert.show(context: context, type: CoolAlertType.loading, title: "Coming Soon",text: "We'r working on this feature",);
        
//               },
//   ),


//     BottomSheetAction(
//       title:  Text('Download', style: GoogleFonts.ubuntu(textStyle: TextStyle())), 
//       onPressed: (){
//         // CoolAlert.show(context: context, type: CoolAlertType.loading, title: "Coming Soon",text: "We'r working on this feature",);
        
//               },
//   )],
// cancelAction: CancelAction(title: Text('Cancel', style: GoogleFonts.ubuntu(textStyle: TextStyle())),),);
// }



// description
description(){
  showModalBottomSheet(
    
    shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight:Radius.circular(20) )
       ),
    constraints: BoxConstraints(),
    enableDrag: true,
    // shape: ,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Container(
        height: 650,
        child: ListView(
          padding: EdgeInsets.fromLTRB(3, 8, 3, 2),
          scrollDirection: Axis.vertical,
          children: [
          Text("description", 
            style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),textAlign: TextAlign.center,),
          Divider(endIndent: 4,indent: 4,),
          SizedBox(height: 6,),
          Text(widget.description!,
          style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),)
          ]
          )
          
      );
    });
}
}
