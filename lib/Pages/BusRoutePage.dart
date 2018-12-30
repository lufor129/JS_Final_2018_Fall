import 'package:flutter/material.dart';
import '../Model/BusRoute.dart';

class BusRoutePage extends StatefulWidget{

  @override
  _BusRoutePageState createState()=>new _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage>{

  List<BusRoute> busRoutes =[
    new BusRoute("紅67A部分班次延駛中正堂(原 紅69B)", "捷運衛武營站-捷運西子灣站(1號出口)高雄第一科大", true,18),
    new BusRoute("紅2A", "小港站", false,6515),
    new BusRoute("紅3A","區公所", false,66),
    new BusRoute("紅3A","區公所", false,66),
    new BusRoute("紅3A","區公所", false,66),
    new BusRoute("紅3A","區公所", false,66),
    new BusRoute("紅3A","區公所", false,66),
    new BusRoute("紅3A","區公所", false,66),
    new BusRoute("紅3A","區公所", false,66)
  ];

  bool textInputOpen = false;
  String titleText = "";

  void _toggleTextInput(){
    this.setState((){
      textInputOpen = !textInputOpen;
    });
  }

  void _searchBus(String str){
    this.setState((){
      titleText = str;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: new AppBar(
        title: new Text(
          "紅 "+titleText ,
          style: new TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "SetoFont"
          ),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: new ListView.separated(
        padding: EdgeInsets.all(10.0),
        separatorBuilder: (BuildContext context,int index)=>Divider(height: 10),
        itemCount: busRoutes.length,
        itemBuilder: (BuildContext context,int index) {
          return new Container(
            padding: EdgeInsets.only(top: 15,bottom: 15,left: 5,right: 5),
            color: Colors.white70,
            child: new FlatButton(
              onPressed: (){},
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        child:new Text(
                          "${busRoutes[index].name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "SetoFont",
                            fontSize: 32
                          ),
                          overflow: TextOverflow.clip
                        ), 
                      ),
                      new Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: new Text(
                          "${busRoutes[index].routing}",
                          style: new TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      )   
                    ],
                  ),
                  new Container(
                    child: new IconButton(
                      onPressed: (){
                        this.setState((){
                          busRoutes[index].favorite = !busRoutes[index].favorite;
                        });
                      },
                        icon: busRoutes[index].favorite==true?Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 32,
                      ):Icon(
                        Icons.favorite_border,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                    ) 
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_toggleTextInput(),
        child: Icon(Icons.search),
      ),
      bottomNavigationBar: 
        textInputOpen == true?
        BottomAppBar(
          child: new TextField(
            onChanged: (String str)=>_searchBus(str),
            autofocus: true,
            keyboardType: TextInputType.number,
          ),
        ):null
    );
  }
}