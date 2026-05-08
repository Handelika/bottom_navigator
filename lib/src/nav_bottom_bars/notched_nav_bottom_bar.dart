import 'package:flutter/material.dart';
import 'classic_nav_bottom_bar.dart';
import '../enums.dart';
import '../nav_bar.dart';

class NotchedNavBottomBar extends ClassicNavBottomBar {
  const NotchedNavBottomBar({
    super.key,
    required super.items,
    required super.currentIndex,
    super.backgroundColor,
    super.blurAmount,
    super.borderRadius = 24.0,
    super.padding = const EdgeInsets.fromLTRB(12, 12, 12, 10),
    super.margin = const EdgeInsets.fromLTRB(20, 20, 20, 16),
    super.indicatorColors,
    super.selectedItemColor,
    super.unselectedItemColor,
    super.hideOnScroll,
    super.scrollController,
    super.indicatorCurve,
    super.iconCurve,
    super.animationDuration,
    super.centerButton,
    super.showLabels,
    super.indicatorStyle,
    super.textStyle,
    super.onTap,
  }) : assert(
         centerButton != null,
         'NotchedNavBottomBar requires a centerButton for compatible notch layout.',
       );

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(
      items: items,
      currentIndex: currentIndex,
      backgroundColor: backgroundColor,
      blurAmount: blurAmount,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      indicatorColors: indicatorColors,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      hideOnScroll: hideOnScroll,
      scrollController: scrollController,
      indicatorCurve: indicatorCurve,
      iconCurve: iconCurve,
      animationDuration: animationDuration,
      centerButton: centerButton,
      centerButtonStyle: CenterButtonStyle.notched,
      showLabels: showLabels,
      indicatorStyle: indicatorStyle,
      navBarStyle: NavBarStyle.floating,
      textStyle: textStyle,
      onTap: onTap,
    );
  }
}
