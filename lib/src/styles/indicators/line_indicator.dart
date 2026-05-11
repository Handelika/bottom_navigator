import 'package:flutter/material.dart';
import 'indicator_style.dart';

class LineIndicatorStyle extends IndicatorStyle {
  final double height;

  const LineIndicatorStyle({
    this.height = 3.0,
    this.indicatorColor,
    this.border,
    this.padding,
  });

  final Color? indicatorColor;
  final BoxBorder? border;
  final EdgeInsets? padding;

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    final lineWidth = isTablet ? 36.0 : 26.0;
    final indicatorHeight = height;
    final bottomPadding = isTablet ? 8.0 : 6.0;

    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.only(bottom: bottomPadding),
      borderRadius: indicatorHeight / 2,
      showGlow: false,
      width: lineWidth,
      height: indicatorHeight,
    );
  }

  @override
  Widget buildIndicator({
    required BuildContext context,
    required bool isSelected,
    required IndicatorMetrics metrics,
    required Duration animationDuration,
    Color? itemColor,
    List<Color>? indicatorColors,
  }) {
    final theme = Theme.of(context);
    final primaryColor =
        indicatorColor ??
        itemColor ??
        indicatorColors?.first ??
        theme.colorScheme.primary;

    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: animationDuration,
        width: metrics.width,
        height: metrics.height,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(metrics.borderRadius ?? 0),
          border: border,
        ),
      ),
    );
  }
}
