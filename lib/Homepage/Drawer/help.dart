


import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        ),
        body: Padding(padding: EdgeInsets.all(12),
        // child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
        // side: BorderSide(
        //   // color: Colors.black,
        //    width: 100)
        
        // ),
        child: SingleChildScrollView(physics: BouncingScrollPhysics(),child: Column(children: [
          
          ExpansionTile(

          title: 
          Text("Listen", style: TextStyle(fontSize: 30),),
          children: [
            ExpansionTile(
            title: 
            Text("Data, ", style: TextStyle(fontSize: 30, height: 1.4),),
          // Text("Listen", style: TextStyle(fontSize: 30),),
          children: [
            Text("Just checking the data ok , ", style: TextStyle(fontSize: 30, height: 1.4),),
            
            Text("Just checking the data ok , ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Just checking the data ok , ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Just checking the data ok , ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Just checking the data ok , ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Just checking the data ok , ", style: TextStyle(fontSize: 30, height: 1.4),),
            

          ],
          ),

            Text("Is it ok ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Is it ok ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Is it ok ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Is it ok ", style: TextStyle(fontSize: 30, height: 1.4),),
            Text("Is it ok ", style: TextStyle(fontSize: 30, height: 1.4),),
            

          ],
          ),
          
        ],
        ),
        )
        ,),
    );
  }
}