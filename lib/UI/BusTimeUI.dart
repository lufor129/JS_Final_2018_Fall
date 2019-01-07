import 'package:flutter/material.dart';

class BusTimeUI extends StatelessWidget{

  final List list;
  BusTimeUI(this.list);

  @override
  Widget build(BuildContext context){
    if(list == null){
      return new Container();
    }else{
      return ListView.separated(
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: new Text(
              list[index].stopName
            ),
            subtitle: new Text(list[index].nextBusTime),
            onTap: (){},
            leading: new Container(
              width: 50,
              height: 50,
              child: new Center(
                child:new Text(
                  list[index].lastTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                )
                // child: new Icon(
                //   Icons.assistant_photo,
                //   color:Colors.white,
                // ),
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
                  list[index].busId,
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
}