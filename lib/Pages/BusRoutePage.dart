import 'package:flutter/material.dart';
import '../Model/BusRouteModel.dart';
import './BusTimeStep.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    http.Response response = await http.get(
      Uri.encodeFull(widget.busUrl),
      headers: {"Accept":"application/json"},
    );

    var data = jsonDecode(response.body);
    List<dynamic> list = data['BusDynInfo']['BusInfo']['Route'];
    List<BusRouteModel> newbusRoute = new List();
    for(int i =0;i<list.length;i++){
      newbusRoute.add(new BusRouteModel.formJson(list[i]));
    }
    print(newbusRoute.length);
    this.setState((){
      this.busRoutes = newbusRoute;
    });

  }

  bool textInputOpen = false;
  String titleText = "";


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
          itemCount: busRoutes.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              color: Colors.white70,
              padding: EdgeInsets.only(top: 15,bottom: 15,left: 5,right: 5),
              child: new ListTile(
                onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new BusTimeStep())),
                title: new Text(
                  "${busRoutes[index].name}",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SetoFont",
                      fontSize: 32),
                ),
                subtitle: new Text(
                  "${busRoutes[index].routing}",
                  style: new TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent,
                  ),
                ),
                trailing: new IconButton(
                  onPressed: () {
                    this.setState(() {
                      busRoutes[index].favorite = !busRoutes[index].favorite;
                    });
                  },
                  icon: busRoutes[index].favorite == true
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
