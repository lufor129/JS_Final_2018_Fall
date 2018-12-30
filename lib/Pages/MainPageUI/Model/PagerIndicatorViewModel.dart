
import './PageViewModel.dart';

enum SlideDirection{
  letfToRight,
  rightToLeft,
  none
}

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final double slidePercent;
  final SlideDirection slideDirection;

  PagerIndicatorViewModel(this.pages,this.activeIndex,this.slideDirection,this.slidePercent,);
}