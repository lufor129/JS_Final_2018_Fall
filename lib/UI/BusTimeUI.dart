import 'package:flutter/material.dart';

class BusTimeUI extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return  ListView.separated(
      itemCount: 25,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Text(
            "123456"
          ),
          subtitle: new Text("5555"),
          onTap: (){},
          leading: new Container(
            width: 50,
            height: 50,
            child: new Center(
              // child:new Text(
              //   "12:18",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold
              //   ),
              // )
              child: new Icon(
                Icons.assistant_photo,
                color:Colors.white,

              ),
            ),
            decoration: new BoxDecoration(
              color:Colors.red,
              shape: BoxShape.circle
            ),
          ),
          trailing: new Container(
            decoration: new BoxDecoration(
              color:Colors.green[800],
              borderRadius: new BorderRadius.all(Radius.circular(10.0))
            ),
            width: 100,
            height: 40,
            child: new Center(
                child:new Text(
                "USH-WD",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ) 
          ) 
        );
      },
    );
  }
}