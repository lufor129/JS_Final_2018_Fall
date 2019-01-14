import 'package:flutter/material.dart';
import '../UI/BusRouteUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/BusRouteModel.dart';
import 'package:firebase_database/firebase_database.dart';

class MyFavorite extends StatefulWidget{

  @override
  _MyFavoriteState createState()=>new _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite>{

  final DatabaseReference fireBaseDB = FirebaseDatabase.instance.reference();
  List<BusRouteModel> favorites = [];
  FirebaseUser user;

  Future<FirebaseUser> _getUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user == null){
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
    }
    return user;
  }

  void _getFavorite(){
    List<BusRouteModel> myFavorites = new List();
    fireBaseDB.child("user/${user.uid}/favorite").once().then((DataSnapshot snapshot){
      Map data = snapshot.value;
      data.keys.forEach((key){
        myFavorites.add(new BusRouteModel.formFireBaseJSON(data[key]));
      });
    }).catchError((error){
      myFavorites = [];
    }).whenComplete((){
      this.setState((){
        this.favorites = myFavorites;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    _getUser().then((user){
      this.user = user;
      _getFavorite();
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[200],
        title: new Text("我的最愛"),
      ),
      body:favorites.length!=0?new ListView.separated(
        padding: EdgeInsets.all(10),
        separatorBuilder: (BuildContext context,int index)=>Divider(height: 10),
        itemCount: favorites.length,
        itemBuilder: (BuildContext context,int index){
          return BusRouteUI(user,favorites[index],true,Colors.red[200]);
        },
      ):new Container(
        child: new Center(
          child: new Text(
            "目前這裡沒東西喔!!",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: "SetoFont"
            ),
          ),
        ),
      ),
    );
  }
}