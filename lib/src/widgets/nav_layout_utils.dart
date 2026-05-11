/// Utility class for handling responsive layout logic across the package.
class NavLayoutUtils {
  /// Threshold width to distinguish between mobile and tablet/desktop layouts.
  static const double tabletBreakpoint = 600.0;

  /// Returns true if the current width indicates a tablet or larger device.
  static bool isTablet(double width) => width > tabletBreakpoint;

  /// Returns the appropriate bar height based on device type and style.
  static double getBarHeight({
    required bool isTablet,
    required bool isDocked,
    required double screenHeight,
    required double screenWidth,
  }) {
    // Dynamic height calculation based on screen height for premium responsiveness
    if (isTablet) {
      // For tablets, we want a taller, more prominent bar
      final baseHeight = (screenHeight * 0.09).clamp(90.0, 120.0);
      return isDocked ? baseHeight + 10.0 : baseHeight;
    }
    // For mobile, we use a standard responsive height
    final baseHeight = (screenHeight * 0.08).clamp(70.0, 90.0);
    return isDocked ? baseHeight + 8.0 : baseHeight;
  }

  /// Returns the horizontal margin adjustment for tablets.
  static double getHorizontalMargin(double baseMargin, bool isTablet) {
    return isTablet ? baseMargin * 1.8 : baseMargin;
  }

  /// Returns the content padding adjustment for tablets.
  static double getHorizontalPadding(double basePadding, bool isTablet) {
    // Increased multiplier for better centering and spacing on large screens
    return isTablet ? basePadding * 2.0 : basePadding;
  }
}
