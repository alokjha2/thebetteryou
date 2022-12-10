
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentPage extends StatefulWidget {
  final String id;
  CommentPage({required this.id, Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final snackBar = SnackBar(content: Text('Reported to admins!',style: GoogleFonts.ubuntu(textStyle: TextStyle(),),), backgroundColor: Colors.blue,shape: BeveledRectangleBorder(),duration: Duration(milliseconds: 50));
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController updatecommentController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final report =  FirebaseFirestore.instance.collection("Customer Care");
  late final comment;

  @override
  void initState() {
    super.initState();
    comment = FirebaseFirestore.instance.collection('book').doc(widget.id).collection('comment');
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      ));
  
  
  }
  final bottomstyle = GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400));
  
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page",
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20))),

      centerTitle: true,
      elevation: 2,
      ),


      body: Container(
        child: CommentBox(
          userImage: user.photoURL,
              child: StreamBuilder(
                stream : comment.limit(10).snapshots(),
                builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.hasData) {
                    return ListView(
                        children: snapshots.data!.docs
                            .map(
                              (e) => ListTile(
                                horizontalTitleGap: 1,
                                leading: InkWell(child: CircleAvatar(backgroundImage: NetworkImage(e["commentimg"]),backgroundColor: Colors.lightBlue,)),

                                title: Text(e["commentname"],style: GoogleFonts.ubuntu(textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 13))),   

                                trailing: InkWell(child: Icon(Icons.more_vert),
                                onTap: (){

                                  // if comment is of user then show edit / delete option else report
                                  if(user.email == e['commentemail']){
                                    showModalBottomSheet(context: context, builder: (context) {
                                        return Container(
                                          height: 100,
                                          child: ListView(
                                            padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.add_comment),
                                                title: Text("Edit",style: bottomstyle),
                                                onTap: () {
                                                  // if doc contains commentid then allow edit , else show exception
                                                  snapshots.data!.docs.contains('commentid') != ""?
                                                    newcomment(id: e["commentid"]) :
                                                    CupertinoAlertDialog(title: Text("Not Possible"),content: Text("Your comment is Exception"),);
                                                                  }
                                                                ),
                                              ListTile(
                                                leading: Icon(Icons.delete),
                                                title: Text("Delete",style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))),
                                                onTap: (){
                                                // if doc contains commentid then allow delete , else show exception
                                                snapshots.data!.docs.contains('commentid') != ""?
                                                  deletecomment(id: e["commentid"]) :
                                                  CupertinoAlertDialog(title: Text("Not Possible"),content: Text("Your comment is Exception"),);
                                                                },
                                                              )
                                                            ]
                                                          )
                                                          );
                                  }
                                );
                              }
                              else{
                                showModalBottomSheet(context: context, builder: (context) {
                                return Container(
                                  height: 50,
                                  child: ListTile(title: Text("Report",style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))),
                                  onTap: (){
                                    // reportcomment(id: e["commentid"]);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                   },
                                  leading: Icon(Icons.local_police_sharp),
                                  )    
                                );
                              }
                            );
                          }
                        },
                      ),                             
                        subtitle : Text(e["comment"],style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)
                              ),
                            ),
                          ),  
                        ).toList());
              } else if (snapshots.hasError) {
                return Center(child: Text("No internet"),);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),


          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              makecomment();
              CoolAlert.show(
                title: "Saved!",
                context: context,
                type: CoolAlertType.success,
                text: "Your comment saved!",
              );
              commentController.clear();
              FocusScope.of(context).unfocus();
              print("success");
            } else {
              CoolAlert.show(context: context, type: CoolAlertType.error, title: "Sorry!",text: "Comment cant' saved", );

            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(
            Icons.send_sharp,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  // show dialog box to update comment
  newcomment({required id}){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Edit"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: updatecommentController,
            ),
          ],
        ),

        actions: <Widget>[
          TextButton(
            onPressed: (){
              editcomment(id:id);
              Navigator.of(context).pop();
            },
            child: Text("Save"),)
            ]
          )
        );
      }
    

  // update comment
  editcomment({required id})async{
    final comment1 = FirebaseFirestore.instance.collection('book').doc(widget.id).collection('comment').doc(id);
    comment1.update({
      "comment" : updatecommentController.text,
      "edited" : true
    }
  ); 
}
   deletecomment({required id})async{
   final comment1 = FirebaseFirestore.instance.collection('book').doc(widget.id).collection('comment').doc(id);
   comment1.delete();
   }

 Future makecomment() async{
   final comment1 = FirebaseFirestore.instance.collection('book').doc(widget.id).collection('comment').doc(); 
   final json = {
        'id': user.uid,
        "commentid" : comment1.id,
        'comment': commentController.text,
        'commentimg': user.photoURL,
        'commentname': user.displayName,
        'commentemail': user.email,
        'commenttime' :  
        DateTime.now().toString(),
        'like' : 0,
        "edited" : false
   };
  //  final userdata = json.toJson();

   await comment1.set(json); // set will replace the field of docs to json
   print(comment1.id);
 }

 // report comment
  // reportcomment({required id})async{
  //     await report.set({
  //     "Report.${user.email}" :  id
  //     });
  // }

  
}
    