import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/Globals.dart';
import 'dart:async';
import './MainPageUI/pages/MyHomePages.dart';

class LoginPage extends StatelessWidget{

  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _signIn(context) async{
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    ).then((FirebaseUser user){
      User.username = user.displayName;
      User.email = user.email;
      User.userId = user.uid;
      print("${user.uid} && ${user.email} && ${user.displayName}");
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