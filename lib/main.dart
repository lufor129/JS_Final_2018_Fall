import 'package:flutter/material.dart';
import './Pages/LoginPage.dart';
import './Pages/MainPageUI/pages/MyHomePages.dart';
import './Pages/BusRoutePage.dart';
import './Pages/BusTimeStep.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "高雄公車GOGO",
      theme: new ThemeData(
        primaryColor: Colors.blue
      ),
      home: new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/home': (BuildContext context)=>new MyHomePage()
      },
    );
  }
}