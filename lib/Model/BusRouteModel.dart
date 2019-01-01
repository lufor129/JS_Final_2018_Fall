class BusRouteModel{
  final String name;
  final String routing;
  bool favorite;
  final int busId;

  BusRouteModel(this.name,this.routing,this.favorite,this.busId);

  BusRouteModel.formJson(Map<String,dynamic> json)
    :name = json['nameZh'],
    routing=json['ddesc'],
    favorite=false,
    busId=int.parse(json['ID']);
  
  Map<String,dynamic> toJSON()=>{
    'name':name,
    'routing':routing,
    'favorite':favorite,
    'busId':busId
  };
}