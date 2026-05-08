import 'package:flutter/material.dart';

/// Utility class for handling responsive layout logic across the package.
class NavLayoutUtils {
  /// Threshold width to distinguish between mobile and tablet/desktop layouts.
  static const double tabletBreakpoint = 600.0;

  /// Returns true if the current width indicates a tablet or larger device.
  static bool isTablet(double width) => width > tabletBreakpoint;

  /// Returns the appropriate bar height based on device type and style.
  static double getBarHeight({required bool isTablet, required bool isDocked}) {
    if (isTablet) {
      return isDocked ? 92.0 : 84.0;
    }
    return isDocked ? 72.0 : 65.0;
  }

  /// Returns the horizontal margin adjustment for tablets.
  static double getHorizontalMargin(double baseMargin, bool isTablet) {
    return isTablet ? baseMargin * 2.0 : baseMargin;
  }

  /// Returns the content padding adjustment for tablets.
  static double getHorizontalPadding(double basePadding, bool isTablet) {
    return isTablet ? basePadding * 2.5 : basePadding;
  }
}
