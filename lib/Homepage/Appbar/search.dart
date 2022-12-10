import 'package:alok/Homepage/home.dart';
import 'package:alok/audiobook%20page/audiopage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataSearch extends SearchDelegate{

  final firestoreref = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('book').snapshots();
  // String query1  

  // get query => query;

List<String> setSearchParam(String title) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < title.length; i++) {
      temp = temp + title[i].toLowerCase();
      caseSearchList.add(temp);
    }

    for (var i = 0; i < title.split(" ").length; i++) {
      String keyword = title.split(" ")[i].toLowerCase();

      caseSearchList.add(keyword);
    }
    return caseSearchList;
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    // action for app bar 
    return [
      IconButton(
        onPressed: (){
        query = '';
      },
      icon: Icon(
        Icons.clear
        )
      )
    ];
  }



  @override
  Widget? buildLeading(BuildContext context) {
    // leading icons 
    return IconButton(
    icon: Icon(Icons.arrow_back),
      onPressed: ()
        => Navigator.of(context).push(MaterialPageRoute(builder : (_) => MainPage()
        )
        )

    );
  }





  @override
  Widget buildResults(BuildContext context) {
  return FutureBuilder<QuerySnapshot>(
      future: firestoreref.collection("book").where(
        'query1'.toLowerCase(),
        arrayContainsAny: [query.toLowerCase()],
      )
      .get(),
      


      
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final List<DocumentSnapshot> arrData = snapshot.data!.docs;
         

        
          return ListView(
            children: arrData.map((data) {
              String img = data["img"];
              String name = data["name"];
              String author = data["author"];
              String mp3 = data["mp3"];            
              String description = data["description"];  
              String id = data["id"];          

              return Card(
              child: InkWell(child:
              // SPdN2VPKCFEn3ySmvL8e
              ListTile(

              title: Text(data['name'], style: GoogleFonts.ubuntu(
      //           textStyle: TextStyle(wordSpacing: .2)
      // ,
      ),),
      // git clone https://Cherry-Bunny@bitbucket.org/brvteck/oho_admin_app.git
              subtitle: Text("By "+ data['author'],style: GoogleFonts.ubuntu(
                
                // textStyle: TextStyle(wordSpacing: .2)
               ) ),
            
            ),
            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Music(
                    name: name,
                    author: author,
                    mp3 : mp3,
                    img: img,
                    description: description,
                    id: id,

              )
              )
              ),
            )
            );
                 
                
              
              
              
            
            }).toList(),

          );


}

if(!snapshot.hasData){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(strokeWidth: 2,),
        SizedBox(height: 3,),
        Text("Loading....", style:GoogleFonts.ubuntu(textStyle: 
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w400)
                    ),)
      ],
    ),
  );
  }
      else{
          return Center(
            child: CircularProgressIndicator(strokeWidth: 2,)
          ); 
        }      }
        
      );
      }
      


  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // initialData: ,

      stream: _usersStream,

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


        // if(snapshot.connectionState==ConnectionState.active){
        //   return Text("hello");

        // }
        if (snapshot.hasError) {

          return 
          SnackBar(content: Text("Your network is unstable"));
          
        }
        // if(snapshot.hasData==false){
        //           return Text("No Data");
            // } 

        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 6,));
          
        }

        if(snapshot.hasData){
        return 
        
        ListView(
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document){
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            // String alok = Data();
            String img = data["img"];
            String name = data["name"];
            String author = data["author"];
            String mp3 = data["mp3"];            
            String description = data["description"];  
            String id = data["id"];          

            
                return Card(
              child: InkWell(
                child:
              ListTile(
              leading: Image.network(img, filterQuality: FilterQuality.low,),

              title: Text(data['name'],  style: 
                   GoogleFonts.ubuntu(textStyle: TextStyle()),),
              subtitle: Text("By "+ data['author'],style: 
                   GoogleFonts.ubuntu(textStyle: TextStyle()),),
            
            ),
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Music(
                   
                  
                    name: name,
                    author: author,
                    mp3 : mp3,
                    img: img,
                    description: description,
                    id: id,
            
              ),),
            )
              
              )
              );
            }
            
          ).toList(),
        );
      }
      else{
        return Center(child: Text("No Data found!",  style: 
                   GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 20)),),);
      }
      }
    );
    }
}