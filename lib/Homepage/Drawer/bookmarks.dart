import 'package:alok/audiobook%20page/audiopage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';



 

class Bookmark extends StatefulWidget{

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  final snackBar = SnackBar(
    content: Text('Removed from Bookmarks',style: GoogleFonts.ubuntu(textStyle: TextStyle(),),), backgroundColor: Colors.green,shape: BeveledRectangleBorder(), 
    duration: Duration(
      // seconds: 1, 
      milliseconds: 500
      ),
    
    // action: SnackBarAction(
    //   textColor: Colors.white,
    // label: 'Undo',    
    // onPressed: (){

    // })
    );
  
  // var changes = new ChangeStack();
  late Box<String> friendsBox;
      // changes.undo();

    @override
    void initState() {
      super.initState();
      
    friendsBox = Hive.box<String>("friends"); //name same as openBox
    }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text("Bookmarks",style: 
      
      GoogleFonts.ubuntu(textStyle: 
                
      
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20, 
      // fontFamily: "Ubuntu"
      
      ),)
      
      
      ),
      centerTitle: true,
      elevation: 2,
      // toolbarHeight: 24,,),)
    ),
    body: 
    
    
    
    
    
    
    
    Center(child: 
      ValueListenableBuilder(
            valueListenable: friendsBox
                .listenable(), // import hive_flutter package if listenable() throw error
            builder: (context, Box<String> friends, _) => friends.values.isEmpty
                ? 
                
                Stack(
                  alignment: Alignment.topCenter,
            // textDirection: TextDirection.ltr,
            // fit: StackFit.passthrough,
            children: [
              
              
              Image.asset("assets/oops.png", height: 300,width: 200),
            Text(
                        "No! BookMarks Yet!",
                        style: 
                                GoogleFonts.ubuntu(textStyle: 
                                
                                
                                TextStyle(fontSize: 20,),),
                              ),
                              SizedBox(height: 4,),
            
          ],)
                
                
                
                
                : ListView.separated(
                    itemBuilder: (context, index) {
                      String key = friends.keys.toList()[index];
                      String? value = friends.get(key);
                      return Dismissible(
                        key: Key(value!),
                        background: Container(color: Colors.red,),
                        onDismissed: (direction){
                          if(direction== DismissDirection.endToStart){
                            friendsBox.delete(key);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        


                          }
                        },
                        child: InkWell(
                          child: ListTile(
                            
                            
                            trailing: InkWell(child: Icon(Icons.delete, color: Colors.red,), onTap: (){
                              friendsBox.delete(key);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             
                            },),
                            title: Text(
                              key,
                               style: 
                                GoogleFonts.ubuntu(textStyle: 
                                
                                
                                TextStyle(fontSize: 20,),),
                              ),
                            subtitle: Text(
                              "By " + 
                              value, style: 
                                GoogleFonts.ubuntu(textStyle: 
                                
                                
                                TextStyle(fontSize: 15),),),
                              
                              ),
                              onTap: (){
                              }
                    ),
                        
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: friends.keys.toList().length,
                  ),
          
      )
    )
    );
  }
}