import 'indicators/indicator_style.dart';
import 'indicators/pill_indicator.dart';
import 'indicators/line_indicator.dart';
import 'indicators/square_indicator.dart';
import 'indicators/circle_indicator.dart';
export 'indicators/indicator_style.dart';
export 'indicators/pill_indicator.dart';
export 'indicators/line_indicator.dart';
export 'indicators/square_indicator.dart';
export 'indicators/circle_indicator.dart';

/// A square-shaped indicator style.
const squareIndicator = SquareIndicatorStyle();

/// A pill-shaped indicator style.
const pilledIndicator = PillIndicatorStyle();

/// A line-shaped indicator style.
const lineIndicator = LineIndicatorStyle();

/// A circle-shaped indicator style.
const circleIndicator = CircleIndicatorStyle();

/// Getters for IndicatorStyle aliases.
SquareIndicatorStyle get square => squareIndicator;
PillIndicatorStyle get pilled => pilledIndicator;
LineIndicatorStyle get line => lineIndicator;
CircleIndicatorStyle get circle => circleIndicator;

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

/// Extension to provide named indicator styles on [IndicatorStyle].
extension IndicatorStyleExtensions on IndicatorStyle {
  /// A square-shaped indicator style.
  static SquareIndicatorStyle get square => squareIndicator;

  /// A pill-shaped indicator style.
  static PillIndicatorStyle get pilled => pilledIndicator;

  /// A line-shaped indicator style.
  static LineIndicatorStyle get line => lineIndicator;

  /// A circle-shaped indicator style.
  static CircleIndicatorStyle get circle => circleIndicator;
}
