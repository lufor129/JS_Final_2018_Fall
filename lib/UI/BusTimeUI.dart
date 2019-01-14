import 'package:flutter/material.dart';
import '../Model/BusTimeModel.dart';

class BusTimeUI extends StatelessWidget{

  final List list;
  BusTimeUI(this.list);

  Color busTimeIconBackground(String time){
    int busTime = int.tryParse(time);
    if(busTime!=null){
      if(busTime>8){
        return Colors.red[300];
      }else if(busTime>5){
        return Colors.red;
      }else if(busTime >3){
        return Colors.red[700];
      }else{
        return Colors.red[900];
      }
    }else if(time==''){
      return Colors.blueGrey;
    }else{
      return Colors.deepOrange;
    }
  }

  Widget leadingText(BusTimeModel busTime){
    int time = int.tryParse(busTime.lastTime);
    if(time!=null && time==0){
      return new Icon(
        Icons.assistant_photo,
        color:Colors.white,
        size: 40,
      );
    }else if(time!=null && time<5){
      return new Text(
        "即將抵達",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14
        ),
      );
    }else if(busTime.nextBusTime == "末班車已發"){
      return new Icon(
        Icons.close,
        color:Colors.white,
        size: 40,
      );
    }else{
      return new Text(
        busTime.lastTime,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      );
    }
  }

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
            subtitle: new Text("下一班 : "+list[index].nextBusTime),
            onTap: (){},
            leading: new Container(
              width: 60,
              height: 60,
              child: new Center(
                child:leadingText(list[index])
              ),
              decoration: new BoxDecoration(
                color:busTimeIconBackground(list[index].lastTime),
                shape: BoxShape.circle
              ),
            ),
            trailing: int.tryParse(list[index].lastTime)==0?new Container(
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
            ):null 
          );
        },
      );
    }
  }
}