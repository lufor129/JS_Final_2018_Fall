import 'package:flutter/material.dart';
import '../Model/BusTimeModel.dart';
import '../UI/BusTimeUI.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusTimeStep extends StatefulWidget {

  final String url;
  BusTimeStep(this.url);

  @override
  _BusTimeStepState createState() => new _BusTimeStepState();
}

class _BusTimeStepState extends State<BusTimeStep> {


  int _currentIndex = 0;
  List<Widget> _children =[
    new BusTimeUI(null),
    new BusTimeUI(null),
  ];

  @override
  void initState(){
    super.initState();
    this.getJSON();
  }

  void getJSON() async{
    http.Response response = await http.get(
      Uri.encodeFull(widget.url),
      headers: {"Accept":"application/json"},
    );

    List _child = new List(2);
    _child[0] = new List();
    _child[1] = new List();

    List list = jsonDecode(response.body);
    list.forEach((item){
      if(item["GoBack"]=='1'){
        _child[0].add(new BusTimeModel.fromJson(item));
      }else{
        _child[1].add(new BusTimeModel.fromJson(item));
      }
    });
    this.setState((){
      _children=[
        new BusTimeUI(_child[0]),
        new BusTimeUI(_child[1])
      ];
    });
  }


  void _changeRoute(int index){
    this.setState((){
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("時刻表頁"),
        backgroundColor: Colors.redAccent,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: _changeRoute,
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title:new Text("去程")
          ),
          BottomNavigationBarItem(
            icon:new Icon(Icons.mail),
            title:new Text("回程")
          )
        ]
      ),
    );
  }
}
