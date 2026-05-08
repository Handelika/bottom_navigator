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
}) {
  switch (style) {
    case IndicatorStyle.dot:
      return const IndicatorMetrics(
        style: IndicatorStyle.dot,
        top: null,
        bottom: 8,
        alignment: Alignment.bottomCenter,
        width: 8,
        height: 8,
        borderRadius: 4,
        showGlow: false,
      );
    case IndicatorStyle.line:
      return const IndicatorMetrics(
        style: IndicatorStyle.line,
        top: null,
        bottom: 10,
        alignment: Alignment.bottomCenter,
        width: 12,
        height: 3,
        borderRadius: 2,
        showGlow: false,
      );
    case IndicatorStyle.square:
      return IndicatorMetrics(
        style: IndicatorStyle.square,
        top: null,
        bottom: 0,
        alignment: Alignment.bottomCenter,
        width: itemWidth * 0.4,
        height: 4,
        borderRadius: 2,
        showGlow: false,
      );
    case IndicatorStyle.pill:
      return IndicatorMetrics(
        style: IndicatorStyle.pill,
        top: 0,
        bottom: 0,
        alignment: Alignment.center,
        width: itemWidth * 0.9,
        height: 50,
        borderRadius: 25,
        showGlow: true,
      );
  }
}
