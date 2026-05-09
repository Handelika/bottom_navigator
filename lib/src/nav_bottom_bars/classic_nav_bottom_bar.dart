import 'package:flutter/material.dart';
import '../enums.dart';
import '../nav_bar.dart';
import '../nav_item.dart';

class ClassicNavBottomBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final Color? backgroundColor;
  final double blurAmount;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<Color>? indicatorColors;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool hideOnScroll;
  final ScrollController? scrollController;
  final Curve indicatorCurve;
  final Curve iconCurve;
  final Duration animationDuration;
  final bool showLabels;
  final IndicatorStyle indicatorStyle;
  final TextStyle? textStyle;
  final ValueChanged<int>? onTap;

  const ClassicNavBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.backgroundColor,
    this.blurAmount = 15.0,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.margin = const EdgeInsets.all(20),
    this.indicatorColors,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.hideOnScroll = false,
    this.scrollController,
    this.indicatorCurve = Curves.easeOutBack,
    this.iconCurve = Curves.easeInOut,
    this.showLabels = true,
    this.indicatorStyle = IndicatorStyle.pill,
    this.animationDuration = const Duration(milliseconds: 400),
    this.textStyle,
    this.onTap,
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
      showLabels: showLabels,
      indicatorStyle: indicatorStyle,
      navBarStyle: NavBarStyle.docked,
      textStyle: textStyle,
      onTap: onTap,
    );
  }
}
