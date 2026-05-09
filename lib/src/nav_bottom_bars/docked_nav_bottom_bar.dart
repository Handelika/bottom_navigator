import 'package:bottom_navigator/src/styles/nav_bar_indicator_style.dart';
import 'package:flutter/material.dart';
import '../enums.dart';
import '../nav_bar.dart';
import '../nav_item.dart';

class DockedNavBottomBar extends StatelessWidget {
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
  final Widget? centerButton;
  final bool showLabels;
  final IndicatorStyle indicatorStyle;
  final TextStyle? textStyle;
  final ValueChanged<int>? onTap;

  const DockedNavBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.backgroundColor,
    this.blurAmount = 15.0,
    this.borderRadius = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.margin = EdgeInsets.zero,
    this.indicatorColors,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.hideOnScroll = false,
    this.scrollController,
    this.indicatorCurve = Curves.easeOutBack,
    this.iconCurve = Curves.easeInOut,
    this.animationDuration = const Duration(milliseconds: 400),
    this.centerButton,
    this.showLabels = true,
    this.indicatorStyle = const PillIndicatorStyle(),
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
