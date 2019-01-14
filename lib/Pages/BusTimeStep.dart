import 'package:flutter/material.dart';
import '../Model/BusTimeModel.dart';
import '../UI/BusTimeUI.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusTimeStep extends StatefulWidget {

  final String name;
  final String url;
  final Color color;
  BusTimeStep(this.name,this.url,this.color);

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
        title: new Text(widget.name),
        backgroundColor: widget.color,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        iconSize: 30,
        onTap: _changeRoute,
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.arrowUp),
            title:new Text("去程")
          ),
          BottomNavigationBarItem(
            icon:new Icon(FontAwesomeIcons.arrowDown),
            title:new Text("回程")
          )
        ]
      ),
    );
  }
}
