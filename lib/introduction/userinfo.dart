




import 'package:alok/introduction/signpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';



class Userdatainfo extends StatelessWidget {
  // Userdatainfo();
  final user = FirebaseAuth.instance.currentUser!;

  // const Userdatainfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(onPressed: () {
        user.delete(
          
        );
        googleSignOut(context);
      },
      child: Text("delete"),
      )
      )
    );
  }
}