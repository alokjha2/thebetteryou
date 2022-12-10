
// import 'package:hive/hive.dart';
import 'package:alok/Homepage/home.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:alok/audiobook%20page/audiopage.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';



class Content extends StatefulWidget {
    @override
  _ContentState createState() => _ContentState();

}



class _ContentState extends State<Content> {
FirebaseFirestore firestore = FirebaseFirestore.instance;  
final Stream <QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('book').snapshots();
final player = AudioPlayer();
CollectionReference users = FirebaseFirestore.instance.collection('book');


late Box<String> friendsBox;
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    friendsBox = Hive.box<String>("friends"); //name same as openBox
  }

  @override

 
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(

      stream: _usersStream,

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
        
        
        if (snapshot.hasError) {

          return 
          Card(child: Text("Sorry, you are offline"),);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return 
          
          
          Center(child: 
          CircularProgressIndicator(color: Colors.blue,strokeWidth: 4,));
        }
        

        return 
        
        GridView(
          addRepaintBoundaries: true,
          scrollDirection: Axis.vertical,

          
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 6.0,
              ),
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document){
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            // String alok = Data();
            String img = data["img"];
            String name = data["name"];
            String id = data['id'] ?? "";
            String author = data["author"];
            String mp3 = data["mp3"];            
            String description = data["description"];
            
           
               

            return 
            InkWell(


              child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              // height: ,
                              child: Center(child: Image.network(img, fit: BoxFit.fill,loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            
                  
                  
                  
                  ),

                  );

            },
          errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Stack(
            alignment: Alignment.center,
            textDirection: TextDirection.ltr,
            fit: StackFit.passthrough,
            children: [
              SizedBox(height: 16,),
              
              
            Text("Network Issue!",style: 
            
        GoogleFonts.ubuntu(textStyle: 
        TextStyle(
          // fontSize: 10
        ),),
        textAlign: TextAlign.center,
        ),
            Image.asset("assets/network_issue.png", height: 6,
            width: 4,
            alignment: Alignment.bottomCenter,)
          ],);
        },)),
                              
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                             ],
                          ),
                          Text(
                            author,
                            style: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w400))),
                          ],
                      ),
                    ),
            ),
                  onTap: ()=>
                  Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: 
                  LoaderOverlay(child:
                  Music(name: name,
                    author: author,
                    mp3 : mp3,
                    img: img,
                    description: description,
                    id: id,
                    ))))
                );
            }
          ).toList(),
        );
      },
        
    );
  }
}
