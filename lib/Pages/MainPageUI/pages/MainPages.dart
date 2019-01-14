import 'package:flutter/material.dart';
import '../Model/PageViewModel.dart';
import '../../BusRoutePage.dart';
import '../../MyFavorite.dart';

class Pages extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisiable;

  Pages({
    this.viewModel,
    this.percentVisiable = 1.0
  });

  void navigatorPage(BuildContext context){
    if(viewModel.busRouteUrl=="myFavoritePage"){
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new MyFavorite()));
    }else{
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new BusRoutePage(viewModel.color,viewModel.title,viewModel.busRouteUrl)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onDoubleTap: ()=>navigatorPage(context),
      splashColor: Colors.yellowAccent,
      child:new Container(
        constraints: BoxConstraints.expand(),
        color: viewModel.color,
        child:new Opacity(
          opacity: percentVisiable,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Transform(
                transform: new Matrix4.translationValues(0, 50*(1.0-percentVisiable), 0),
                child:new Padding(
                  padding: new EdgeInsets.only(bottom: 20),
                  child: new Image.asset(
                    viewModel.heroAssetPath,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0, 30*(1.0-percentVisiable), 0),
                child:new Padding(
                  padding: new EdgeInsets.only(top: 10, bottom: 10),
                  child: new Text(
                    viewModel.title,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: 'FlamanteRoma'),
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0,30*(1-percentVisiable) , 0),
                child:new Padding(
                  padding: new EdgeInsets.only(bottom: 75),
                  child: new Text(
                    viewModel.body,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      )
    ) ;
  }
}
