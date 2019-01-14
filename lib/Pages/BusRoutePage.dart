import 'package:flutter/material.dart';
import '../Model/BusRouteModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../UI/BusRouteUI.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BusRoutePage extends StatefulWidget {

  final Color color;
  final String title;
  final String busUrl;

  BusRoutePage(this.color,this.title,this.busUrl);

  @override
  _BusRoutePageState createState() => new _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage> {

  List<BusRouteModel> busRoutes = [];
  List<BusRouteModel> favorites = [];
  bool textInputOpen = false;
  String titleText = "";
  FirebaseUser user;
  final DatabaseReference fireBaseDB = FirebaseDatabase.instance.reference();

  @override
  void initState(){
    super.initState();
    getUser().then((user){
      this.user = user;
      _getFavorite().then((List<BusRouteModel> myFavorites){
        this.favorites = myFavorites;
        this._getJsonData();
      });
    });
  }
  
  Future<FirebaseUser> getUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user == null){
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
    }
    return user;
  }

  void _getJsonData() async{
    http.Response response = await http.get(
      Uri.encodeFull(widget.busUrl),
      headers: {"Accept":"application/json"},
    );
    var list = jsonDecode(response.body);
    List<BusRouteModel> newbusRoute = new List();
    for(int i =0;i<list.length;i++){
      newbusRoute.add(new BusRouteModel.formJson(list[i]));
    }
    this.setState((){
      this.busRoutes = newbusRoute;
    });
  }

  List<BusRouteModel> _computedBusLine(){
    if(this.titleText == ""){
      return this.busRoutes;
    }else{
      List<BusRouteModel> newbusRoutes = this.busRoutes.where((data)=>data.name.contains(this.titleText)).toList();
      return newbusRoutes;
    }
  }

  Future<List<BusRouteModel>> _getFavorite() async{
    List<BusRouteModel> myFavorites = new List();
    await fireBaseDB.child("user/${user.uid}/favorite").once().then((DataSnapshot snapshot){
      Map data = snapshot.value;
      data.keys.forEach((key){
        myFavorites.add(new BusRouteModel.formFireBaseJSON(data[key]));
      });
    }).catchError((error){
      myFavorites = [];
    });
    return myFavorites;
  }

  void _toggleTextInput() {
    this.setState(() {
      textInputOpen = !textInputOpen;
    });
  }

  void _searchBus(String str) {
    this.setState(() {
      titleText = str;
    });
  }

  bool _isFavorite(BusRouteModel busRoute){
    return this.favorites.any((BusRouteModel favorite){
      return favorite.busId == busRoute.busId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: new AppBar(
          title: new Text(
            widget.title+" "+ titleText,
            style: new TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "SetoFont"),
          ),
          backgroundColor: widget.color,
          centerTitle: true,
        ),
        body: new ListView.separated(
          padding: EdgeInsets.all(10.0),
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 10),
          itemCount: _computedBusLine().length,
          itemBuilder: (BuildContext context, int index) {
            return BusRouteUI(user,_computedBusLine()[index],_isFavorite(_computedBusLine()[index]),widget.color);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _toggleTextInput(),
          child: Icon(Icons.search),
        ),
        bottomNavigationBar: textInputOpen == true
            ? BottomAppBar(
                child: new TextField(
                  onChanged: (String str) => _searchBus(str),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                ),
              )
            : null);
  }
}
