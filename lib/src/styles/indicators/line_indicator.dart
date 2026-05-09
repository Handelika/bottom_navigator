import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'indicator_style.dart';

class LineIndicatorStyle extends IndicatorStyle {
  final double height;

  const LineIndicatorStyle({this.height = 3.0});

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    final lineWidth = isTablet ? 32.0 : 20.0;
    final bottomPadding = isTablet ? 12.0 : 8.0;
    
    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.only(
        bottom: bottomPadding,
        top: math.max(0.0, barHeight - bottomPadding - height),
      ),
      borderRadius: 2,
      showGlow: false,
      width: lineWidth,
      height: height,
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
    final primaryColor = itemColor ?? indicatorColors?.first ?? theme.colorScheme.primary;

    return AnimatedContainer(
      duration: animationDuration,
      width: metrics.width,
      height: metrics.height,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(metrics.borderRadius),
      ),
    );
  }
}
