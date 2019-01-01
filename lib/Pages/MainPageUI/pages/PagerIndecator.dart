import 'package:flutter/material.dart';
import '../Model/PagerIndicatorViewModel.dart';
import './PageBubble.dart';
import '../Model/PagerBubbleViewModel.dart';

class PagerIndecator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;
  int activeIndex;

  PagerIndecator({this.viewModel,this.activeIndex});

  @override
  Widget build(BuildContext context) {

    List<PageBubble> bubbles = [];
    for (var i= 0;i<viewModel.pages.length;i++) {
      final page = viewModel.pages[i];

      var percentActive;
      if(i==viewModel.activeIndex){
        percentActive = 1.0 - viewModel.slidePercent;
      }else if(i == viewModel.activeIndex -1 && viewModel.slideDirection == SlideDirection.letfToRight){
        percentActive = viewModel.slidePercent;
      }else if(i == viewModel.activeIndex +1  && viewModel.slideDirection == SlideDirection.rightToLeft){
        percentActive = viewModel.slidePercent;
      }else{
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex || (i == viewModel.activeIndex && viewModel.slideDirection == SlideDirection.letfToRight);


      bubbles.add(
        new PageBubble(
          viewModel: new PagerBubbleViewModel(
            page.iconAssetPath, 
            page.color, 
            isHollow,
            percentActive,
            page.busRouteUrl
          ),
        ),
      );
    }

    final double BUBBLE_WIDTH = 55.0;
    final baseTranslation = ((viewModel.pages.length * BUBBLE_WIDTH)/2)-(BUBBLE_WIDTH/2);
    var translation = baseTranslation - (viewModel.activeIndex*BUBBLE_WIDTH);
    if(viewModel.slideDirection == SlideDirection.letfToRight){
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    }else if (viewModel.slideDirection == SlideDirection.rightToLeft){
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }

    return new Column(
      children: <Widget>[
        new Expanded(child: new Container()),
        new Transform(
          transform: new Matrix4.translationValues(translation, 0, 0),
          child: new InkWell(
            onTap: ()=>print(bubbles[activeIndex].viewModel.busUrl),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bubbles,
            ),
          ),
        ),
      ],
    );
  }
}
