import 'package:flutter/material.dart';
import 'classic_nav_bottom_bar.dart';
import '../enums.dart';
import '../nav_bar.dart';

class DockedNavBottomBar extends ClassicNavBottomBar {
  const DockedNavBottomBar({
    super.key,
    required super.items,
    required super.currentIndex,
    super.backgroundColor,
    super.blurAmount,
    super.borderRadius,
    super.padding,
    super.margin,
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
  });

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
      centerButtonStyle: CenterButtonStyle.none,
      showLabels: showLabels,
      indicatorStyle: indicatorStyle,
      navBarStyle: NavBarStyle.docked,
      textStyle: textStyle,
      onTap: onTap,
    );
  }
}
