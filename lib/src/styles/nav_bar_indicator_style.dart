import 'package:flutter/material.dart';
import '../enums.dart';

class IndicatorMetrics {
  final IndicatorStyle style;
  final EdgeInsets padding;
  final double borderRadius;
  final bool showGlow;

  const IndicatorMetrics({
    required this.style,
    required this.padding,
    required this.borderRadius,
    required this.showGlow,
  });
}

IndicatorStyle resolveEffectiveIndicatorStyle({
  required bool showLabels,
  required IndicatorStyle preferredStyle,
}) {
  return preferredStyle;
}

IndicatorMetrics resolveIndicatorMetrics({
  required IndicatorStyle style,
  required double barHeight,
  bool isTablet = false,
  bool showLabels = false,
}) {
  switch (style) {
    case IndicatorStyle.dot:
      final dotSize = isTablet ? 12.0 : 8.0;
      final bottomPadding = isTablet ? 14.0 : 8.0;
      return IndicatorMetrics(
        style: IndicatorStyle.dot,
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          top: barHeight - bottomPadding - dotSize,
        ),
        borderRadius: dotSize / 2,
        showGlow: false,
      );
    case IndicatorStyle.line:
      final lineWidth = isTablet ? 24.0 : 12.0;
      final lineHeight = isTablet ? 4.0 : 3.0;
      final bottomPadding = isTablet ? 16.0 : 10.0;
      return IndicatorMetrics(
        style: IndicatorStyle.line,
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          top: barHeight - bottomPadding - lineHeight,
        ),
        borderRadius: 2,
        showGlow: false,
      );
    case IndicatorStyle.square:
      final horizontalPadding = (isTablet ? 12.0 : 8.0) / 2;
      final targetHeight = isTablet ? (showLabels ? 95.0 : 80.0) : (showLabels ? 70.0 : 60.0);
      final verticalPadding = (barHeight - targetHeight) / 2;
      return IndicatorMetrics(
        style: IndicatorStyle.square,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        borderRadius: isTablet ? 12 : 8,
        showGlow: false,
      );
    case IndicatorStyle.pill:
      final horizontalPadding = (isTablet ? 12.0 : 8.0) / 2;
      final targetHeight = isTablet ? (showLabels ? 100.0 : 85.0) : (showLabels ? 75.0 : 65.0);
      final verticalPadding = (barHeight - targetHeight) / 2;
      return IndicatorMetrics(
        style: IndicatorStyle.pill,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        borderRadius: isTablet ? 25 : 20,
        showGlow: true,
      );
  }
}
