import 'package:flutter/material.dart';
import 'dart:ui';
import '../Model/PagerBubbleViewModel.dart';


class PageBubble extends StatelessWidget {
  final PagerBubbleViewModel viewModel;
  PageBubble({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width:55,
        height: 65,
        child:new Center(
          child: new Container(
            width: lerpDouble(20,45,viewModel.activePercent),
            height: lerpDouble(20, 45, viewModel.activePercent),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.isHollow ? Color(0x88FFFFFF).withAlpha((0x88 * viewModel.activePercent).round()): Color(0x88FFFFFF),
              border: new Border.all(
                color: viewModel.isHollow ? Color(0x88FFFFFF).withAlpha(0x88 * (1.0-viewModel.activePercent).round()) : Colors.transparent,
                width: 3
              )
            ),
            child: new Opacity(
              opacity: viewModel.activePercent,
              child: new Image.asset(
                viewModel.iconAssetPath,
                color: viewModel.color
              ),
            )
          )
        )
      );
  }
}
