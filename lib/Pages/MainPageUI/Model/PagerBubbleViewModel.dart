import 'package:flutter/material.dart';

class PagerBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;
  final String busRouteUrl;
  final String title;

  PagerBubbleViewModel(this.iconAssetPath,this.color,this.isHollow,this.activePercent,this.busRouteUrl,this.title);
  
}