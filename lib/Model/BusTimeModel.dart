import 'dart:typed_data';

class BusTimeModel{
  final String stopName;
  final String lastTime;
  final String nextBusTime;
  final String busId;

  BusTimeModel(this.stopName,this.lastTime,this.nextBusTime,this.busId);

  BusTimeModel.fromJson(Map<String,dynamic> json) :
    stopName=json['StopName'],
    lastTime=json['lastTime'],
    nextBusTime=json["nextTime"],
    busId=json['nextBus'];
}