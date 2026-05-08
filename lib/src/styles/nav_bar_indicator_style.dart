import 'package:flutter/material.dart';
import '../enums.dart';

class IndicatorMetrics {
  final IndicatorStyle style;
  final double? top;
  final double bottom;
  final Alignment alignment;
  final double width;
  final double height;
  final double borderRadius;
  final bool showGlow;

  const IndicatorMetrics({
    required this.style,
    required this.top,
    required this.bottom,
    required this.alignment,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.showGlow,
  });
}

IndicatorStyle resolveEffectiveIndicatorStyle({
  required bool showLabels,
  required IndicatorStyle preferredStyle,
}) {
  if (showLabels) {
    return IndicatorStyle.square;
  }
  return preferredStyle;
}

IndicatorMetrics resolveIndicatorMetrics({
  required IndicatorStyle style,
  required double itemWidth,
  bool isTablet = false,
}) {
  switch (style) {
    case IndicatorStyle.dot:
      return IndicatorMetrics(
        style: IndicatorStyle.dot,
        top: null,
        bottom: isTablet ? 14 : 8,
        alignment: Alignment.bottomCenter,
        width: isTablet ? 12 : 8,
        height: isTablet ? 12 : 8,
        borderRadius: isTablet ? 6 : 4,
        showGlow: false,
      );
    case IndicatorStyle.line:
      return IndicatorMetrics(
        style: IndicatorStyle.line,
        top: null,
        bottom: isTablet ? 16 : 10,
        alignment: Alignment.bottomCenter,
        width: isTablet ? 24 : 12,
        height: isTablet ? 4 : 3,
        borderRadius: 2,
        showGlow: false,
      );
    case IndicatorStyle.square:
      return IndicatorMetrics(
        style: IndicatorStyle.square,
        top: null,
        bottom: 0,
        alignment: Alignment.bottomCenter,
        width: isTablet ? (itemWidth * 0.35).clamp(40.0, 80.0) : itemWidth * 0.4,
        height: isTablet ? 6 : 4,
        borderRadius: isTablet ? 3 : 2,
        showGlow: false,
      );
    case IndicatorStyle.pill:
      return IndicatorMetrics(
        style: IndicatorStyle.pill,
        top: 0,
        bottom: 0,
        alignment: Alignment.center,
        width: isTablet ? (itemWidth * 0.75).clamp(80.0, 160.0) : itemWidth * 0.9,
        height: isTablet ? 60 : 50,
        borderRadius: isTablet ? 30 : 25,
        showGlow: true,
      );
  }
}
