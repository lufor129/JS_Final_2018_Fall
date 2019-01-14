import 'package:flutter/material.dart';
import './MainPages.dart';
import '../Model/PageViewModel.dart';
import './pageReveal.dart';
import './PagerIndecator.dart';
import '../Model/PagerIndicatorViewModel.dart';
import './PageDragger.dart';
import 'dart:async';
import '../../../Model/Globals.dart';

final pages = [
  new PageViewModel(
    Colors.grey[700],
    "assets/man.png",
    "全部",
    "高雄公車全線",
    "assets/key.png",
    "${processUrl}bus?line=all"
  ),
  new PageViewModel(
      Colors.red[600],
      'assets/boy.png',
      '紅',
      '捷運紅線接駁公車',
      'assets/key.png',
      "${processUrl}bus?line=紅",
  ),
  new PageViewModel(
      const Color(0xFFFF7C35),
      'assets/girl.png',
      '橘線 / 黃線',
      '捷運橘線/黃線接駁公車',
      'assets/key.png',
      "${processUrl}bus?line=橘"
  ),
  new PageViewModel(
      Color(0xFFFC977D),
      'assets/girl (2).png',
      '幹線 / 快線',
      '幹線/快線路線列車',
      'assets/key.png',
      "${processUrl}bus?line=快線"
  ),
  new PageViewModel(
      Color(0xFF6A7152),
      'assets/mountains.png',
      'JOY',
      '山地快車',
      'assets/key.png',
      "${processUrl}bus?line=JOY"
  ),
  new PageViewModel(
      Colors.red[200],
      'assets/like.png',
      '我的最愛',
      '我的最愛頁面',
      'assets/key.png',
      "myFavoritePage"
  ),
];

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animationPageDragger;


  _MyHomePageState(){
    slideUpdateStream = new StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event){
      setState(() {
        if(event.updateType == UpdateType.dragging){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if(slideDirection == SlideDirection.letfToRight){
            nextPageIndex = activeIndex-1;
          }else if(slideDirection == SlideDirection.rightToLeft){
            nextPageIndex = activeIndex +1;
          }else{
            nextPageIndex = activeIndex;
          }

        }else if(event.updateType == UpdateType.doneDraagging){
          if(slidePercent >0.5){
            animationPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this
            );
          }else{
            animationPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this
            );
            nextPageIndex = activeIndex;
          }
          animationPageDragger.run();
        }else if(event.updateType == UpdateType.animating){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        }else if(event.updateType == UpdateType.doneAnimating){
          activeIndex  = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animationPageDragger.dispose(); 
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Pages(
            viewModel: pages[activeIndex],
            percentVisiable: 1,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Pages(
              viewModel:pages[nextPageIndex],
              percentVisiable: slidePercent,
            )
          ),
          new PagerIndecator(
            viewModel: new PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent
            ),
            activeIndex:activeIndex
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex>0,
            canDragRightToLeft: activeIndex<pages.length-1,
            slideUpdateStream: this.slideUpdateStream,
          )
        ],
      ),
    );
  }
}