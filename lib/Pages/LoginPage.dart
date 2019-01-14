import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class LoginPage extends StatelessWidget{

  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference fireBaseDB = FirebaseDatabase.instance.reference();

  Future<FirebaseUser> _signIn(context) async{
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    ).then((FirebaseUser user){
      print(user);
      fireBaseDB.child("user/${user.uid}/info").update({"Name":user.displayName,"Email":user.email,"uid":user.uid});
      Navigator.pushNamed(context, "/home");
    }).catchError((e)=>print(e));

    return user; 
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Opacity(
            opacity: 0.4,
            child:new Image.asset(
              "assets/Login.gif",
              fit: BoxFit.fitHeight,
            ),
          ),
          new InkWell(
            onTap: ()=>_signIn(context),
            onLongPress: (){},
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Center(
                  child:new Text(
                    "高雄公車衝衝衝",
                    style: new TextStyle(
                      color: Colors.black87,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SetoFont"
                    ),
                  ),
                ),
                new Center(
                  child:new Text(
                    "點擊並繼續",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SetoFont"
                    ),
                  ),
                )
              ], 
            ),
          )
        ],
      ),
    );
  }
}