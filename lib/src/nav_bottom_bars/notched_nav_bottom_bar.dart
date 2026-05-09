import 'package:flutter/material.dart';
import '../enums.dart';
import '../nav_bar.dart';
import '../nav_item.dart';

class NotchedNavBottomBar extends StatelessWidget {
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

  const NotchedNavBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.backgroundColor,
    this.blurAmount = 15.0,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 10),
    this.margin = const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
    this.indicatorStyle = IndicatorStyle.pill,
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
      centerButtonStyle: CenterButtonStyle.notched,
      showLabels: showLabels,
      indicatorStyle: indicatorStyle,
      navBarStyle: NavBarStyle.floating,
      textStyle: textStyle,
      onTap: onTap,
    );
  }
}
