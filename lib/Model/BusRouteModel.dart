class BusRouteModel{
  final String name;
  final String routing;
  final String busId;

  BusRouteModel(this.name,this.routing,this.busId);

  BusRouteModel.formJson(Map<String,dynamic> json) :
    name = json['nameZh'],
    routing=json['ddesc'],
    busId=json['ID'];

  BusRouteModel.formFireBaseJSON(Map<dynamic,dynamic> json):
    name = json["name"],
    routing = json["routing"],
    busId = json["busId"];
  
  Map<String,dynamic> toJSON()=>{
    'name':name,
    'routing':routing,
    'busId':busId
  };
}