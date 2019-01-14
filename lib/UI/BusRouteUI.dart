import 'package:flutter/material.dart';
import '../Pages/BusTimeStep.dart';
import '../Model/Globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/BusRouteModel.dart';

class BusRouteUI extends StatefulWidget {
  final BusRouteModel busRoute;
  final bool isFavorite;
  final Color color;
  final FirebaseUser user;

  BusRouteUI(this.user,this.busRoute,this.isFavorite,this.color);

  @override
  _BusRouteUIState createState() => new _BusRouteUIState();
}

class _BusRouteUIState extends State<BusRouteUI> {

  bool isFavorite;
  final DatabaseReference fireBaseDB = FirebaseDatabase.instance.reference();

  @override
  void initState(){
    super.initState();
    this.isFavorite = widget.isFavorite;
  }


  void toggleFavorite(BusRouteModel busRoute){
    if(this.isFavorite==false){
      fireBaseDB.child("user/${widget.user.uid}/favorite").push().set(busRoute.toJSON()).whenComplete((){
          print("toggle favorite");
        }).catchError((error){
          print(error);
      });
      this.setState((){
        this.isFavorite = true;
      });
    }else{
      fireBaseDB.child("user/${widget.user.uid}/favorite").once().then((DataSnapshot snapshot){
        Map data = snapshot.value;
        String removeKey;
        data.forEach((key,value){
          if(value["busId"] == widget.busRoute.busId){
            removeKey = key;
          }
        });
        fireBaseDB.child("user/${widget.user.uid}/favorite").child(removeKey).remove().whenComplete((){
          this.setState((){
            this.isFavorite = false;
          });
        });
      });
    }
  }

  void navigatorWithCount(){
    fireBaseDB.child("statistic/${widget.busRoute.name}").once().then((DataSnapshot snapshot){
      int data = snapshot.value;
      if(data == null){
        fireBaseDB.child("statistic").update({widget.busRoute.name:1});
      }else{
        fireBaseDB.child("statistic").update({widget.busRoute.name:data+1});
      }
    }).whenComplete((){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>new BusTimeStep(
          widget.busRoute.name,
          "${processUrl}route?id=${widget.busRoute.busId}&isFlutter=true",
          widget.color
        )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white70,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
      child: new ListTile(
        onTap: navigatorWithCount,
        title: new Text(
          widget.busRoute.name,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "SetoFont",
              fontSize: 32),
        ),
        subtitle: new Text(
          widget.busRoute.routing,
          style: new TextStyle(
            fontSize: 18,
            color: Colors.redAccent,
          ),
        ),
        trailing: new IconButton(
          onPressed: () =>toggleFavorite(widget.busRoute),
          icon: isFavorite == true
              ? Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 32,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 32,
                ),
        ),
      ),
    );
  }
}
