import 'package:bottom_navigator/bottom_navigator.dart';
import 'package:flutter/material.dart';

/// Base class for all navigation bar indicator styles.
///
/// Custom indicator styles should extend this class and implement [resolveMetrics]
/// and [buildIndicator].
abstract class IndicatorStyle {
  const IndicatorStyle();

  /// A style that shows no indicator highlight.
  static const none = NoneIndicatorStyle();

  /// A square-shaped indicator style.

  /// A pill-shaped indicator style.
  static const pilled = PillIndicatorStyle();

  /// A line-shaped indicator style.

  /// A circle-shaped indicator style.

  /// Resolves the specific metrics (padding, radius, size) for this style
  /// based on the current bar state.
  ///
  /// [barHeight] is the total height of the navigation bar.
  /// [isTablet] indicates if the layout should be scaled for larger screens.
  /// [showLabels] indicates if text labels are currently visible, which may
  /// affect the indicator's vertical alignment or size.
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  });

  /// Builds the indicator widget for a specific item.
  ///
  /// [isSelected] is true if the item is the currently active one.
  /// [metrics] contains the dimensions calculated by [resolveMetrics].
  /// [animationDuration] is the duration for transition animations.
  /// [itemColor] is the primary color of the navigation item.
  /// [indicatorColors] is an optional list of colors for gradient effects.
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
  /// The style that generated these metrics.
  final IndicatorStyle style;

  /// The padding to apply around the indicator widget.
  final EdgeInsets padding;

  /// The border radius for the indicator shape.
  final double? borderRadius;

  /// Whether to show a glow/shadow effect.
  final bool showGlow;

  /// The width of the indicator. If null, it will expand to available space.
  final double? width;

  /// The height of the indicator. If null, it will expand to available space.
  final double? height;

  const IndicatorMetrics({
    required this.style,
    required this.padding,
    this.borderRadius,
    required this.showGlow,
    this.width,
    this.height,
  });
}

/// Implementation for [IndicatorStyle.none].
class NoneIndicatorStyle extends IndicatorStyle {
  const NoneIndicatorStyle({this.indicatorColor, this.border, this.padding});

  final Color? indicatorColor;
  final BoxBorder? border;
  final EdgeInsets? padding;

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    return IndicatorMetrics(
      style: this,
      padding: padding ?? EdgeInsets.zero,
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
