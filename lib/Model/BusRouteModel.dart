class BusRouteModel{
  final String name;
  final String routing;
  bool favorite;
  final String busId;

  BusRouteModel(this.name,this.routing,this.favorite,this.busId);

  BusRouteModel.formJson(Map<String,dynamic> json) :
    name = json['nameZh'],
    routing=json['ddesc'],
    favorite=false,
    busId=json['ID'];
  
  Map<String,dynamic> toJSON()=>{
    'name':name,
    'routing':routing,
    'busId':busId
  };
}