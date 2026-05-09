import 'package:flutter/material.dart';

/// Base class for all navigation bar indicator styles.
abstract class IndicatorStyle {
  const IndicatorStyle();

  /// A style that shows no indicator highlight.
  static const none = NoneIndicatorStyle();

  /// Resolves the specific metrics (padding, radius, size) for this style
  /// based on the current bar state.
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  });

  /// Builds the indicator widget for a specific item.
  Widget buildIndicator({
    required BuildContext context,
    required bool isSelected,
    required IndicatorMetrics metrics,
    required Duration animationDuration,
    Color? itemColor,
    List<Color>? indicatorColors,
  });
}

/// The result of resolving an indicator style, containing raw dimensions
/// used for rendering.
class IndicatorMetrics {
  final IndicatorStyle style;
  final EdgeInsets padding;
  final double borderRadius;
  final bool showGlow;
  final double? width;
  final double? height;

  const IndicatorMetrics({
    required this.style,
    required this.padding,
    required this.borderRadius,
    required this.showGlow,
    this.width,
    this.height,
  });
}

/// Implementation for [IndicatorStyle.none].
class NoneIndicatorStyle extends IndicatorStyle {
  const NoneIndicatorStyle();

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.zero,
      borderRadius: 0,
      showGlow: false,
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
    return const SizedBox.shrink();
  }
}
