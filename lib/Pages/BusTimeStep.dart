import 'package:flutter/material.dart';
import '../UI/BusTimeUI.dart';

class BusTimeStep extends StatefulWidget {
  @override
  _BusTimeStepState createState() => new _BusTimeStepState();
}

class _BusTimeStepState extends State<BusTimeStep> {

  int _currentIndex = 0;  
  final List<Widget> _children =[
    new BusTimeUI(),
    new Container(
      color: Colors.deepOrangeAccent,
    ),
  ];


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
            title:new Text("Home")
          ),
          BottomNavigationBarItem(
            icon:new Icon(Icons.mail),
            title:new Text("mail")
          )
        ]
      ),
    );
  }
}
