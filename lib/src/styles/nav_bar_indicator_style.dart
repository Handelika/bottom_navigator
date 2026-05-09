import 'indicators/indicator_style.dart';

export 'indicators/indicator_style.dart';
export 'indicators/pill_indicator.dart';
export 'indicators/line_indicator.dart';
export 'indicators/square_indicator.dart';
export 'indicators/circle_indicator.dart';

/// Helper to resolve metrics from an [IndicatorStyle] instance.
IndicatorMetrics resolveIndicatorMetrics({
  required IndicatorStyle style,
  required double barHeight,
  bool isTablet = false,
  bool showLabels = false,
}) {
  return style.resolveMetrics(
    barHeight: barHeight,
    isTablet: isTablet,
    showLabels: showLabels,
  );
}

/// A hook for any future dynamic style resolution logic.
IndicatorStyle resolveEffectiveIndicatorStyle({
  required bool showLabels,
  required IndicatorStyle preferredStyle,
}) {
  return preferredStyle;
}
