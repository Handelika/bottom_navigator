import 'package:bottom_navigator/bottom_navigator.dart';
import 'package:bottom_navigator/src/styles/nav_bar_indicator_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that builds the horizontal row of items for the [BottomNavBar].
class NavItemsRow extends StatelessWidget {
  final List<BottomNavItem> displayItems;
  final List<BottomNavItem> extraItems;
  final int effectiveIndex;
  final bool isMoreOpen;
  final bool hasMore;
  final Color selectedColor;
  final Color unselectedColor;
  final int midIndex;
  final bool hasExternalCenterButton;
  final bool showLabels;
  final Duration animationDuration;
  final Curve iconCurve;
  final bool isTablet;
  final TextStyle? textStyle;
  final IndicatorMetrics indicatorMetrics;
  final List<Color>? indicatorColors;
  final Function(int, {bool closeMoreMenu}) onItemTapped;
  final VoidCallback onToggleMore;

  const NavItemsRow({
    super.key,
    required this.displayItems,
    required this.extraItems,
    required this.effectiveIndex,
    required this.isMoreOpen,
    required this.hasMore,
    required this.selectedColor,
    required this.unselectedColor,
    required this.midIndex,
    required this.hasExternalCenterButton,
    required this.showLabels,
    required this.animationDuration,
    required this.iconCurve,
    required this.indicatorMetrics,
    required this.indicatorColors,
    required this.onItemTapped,
    required this.onToggleMore,
    this.isTablet = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    // Responsive scaling based on device type
    final iconSize = isTablet ? 32.0 : 24.0;
    final selectedScale = showLabels ? 1.0 : (isTablet ? 1.15 : 1.1);
    final moreOpenScale = showLabels ? 1.06 : (isTablet ? 1.25 : 1.2);
    final labelSize = isTablet ? 14.0 : 10.0;
    final labelPadding = showLabels
        ? (isTablet ? 4.0 : 2.0)
        : (isTablet ? 6.0 : 4.0);

    for (int i = 0; i < displayItems.length; i++) {
      // Inject gap for external center button
      if (hasExternalCenterButton && i == midIndex) {
        children.add(const Expanded(child: SizedBox.shrink()));
      }

      final isSelected = !isMoreOpen && effectiveIndex == i;
      final item = displayItems[i];

      if (item.isCenterAction) {
        children.add(const Expanded(child: SizedBox.shrink()));
        continue;
      }

      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              onItemTapped(i, closeMoreMenu: true);
            },
            behavior: HitTestBehavior.translucent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: (isSelected &&
                            indicatorMetrics.style != IndicatorStyle.none)
                        ? 1
                        : 0,
                    child: Padding(
                      padding: indicatorMetrics.padding,
                      child: Center(
                        child: indicatorMetrics.style.buildIndicator(
                          context: context,
                          isSelected: isSelected,
                          metrics: indicatorMetrics,
                          animationDuration: animationDuration,
                          itemColor: item.activeColor,
                          indicatorColors: indicatorColors,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: animationDuration,
                        curve: iconCurve,
                        transform: Matrix4.identity()
                          ..scaleAdjoint(isSelected ? selectedScale : 1.0),
                        transformAlignment: Alignment.center,
                        child:
                            item.customWidget ??
                            Icon(
                              item.icon,
                              color: isSelected
                                  ? selectedColor
                                  : unselectedColor,
                              size: iconSize,
                            ),
                      ),
                      if (showLabels)
                        AnimatedSize(
                          duration: animationDuration,
                          curve: iconCurve,
                          child: isSelected
                              ? Padding(
                                  padding: EdgeInsets.only(top: labelPadding),
                                  child: Text(
                                    item.label,
                                    style:
                                        (textStyle ??
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium!)
                                            .copyWith(
                                              color: selectedColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: labelSize,
                                            ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Append the "More" button if the total item count exceeds the display threshold
    if (hasMore) {
      final selectedExtraIndex = effectiveIndex - displayItems.length;
      final selectedExtraItem =
          (selectedExtraIndex >= 0 && selectedExtraIndex < extraItems.length)
          ? extraItems[selectedExtraIndex]
          : null;
      final isMoreSelected = isMoreOpen || selectedExtraItem != null;

      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              onToggleMore();
            },
            behavior: HitTestBehavior.translucent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: (isMoreSelected &&
                            indicatorMetrics.style != IndicatorStyle.none)
                        ? 1
                        : 0,
                    child: Padding(
                      padding: indicatorMetrics.padding,
                      child: Center(
                        child: indicatorMetrics.style.buildIndicator(
                          context: context,
                          isSelected: isMoreSelected,
                          metrics: indicatorMetrics,
                          animationDuration: animationDuration,
                          indicatorColors: indicatorColors,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: animationDuration,
                        curve: iconCurve,
                        transform: Matrix4.identity()
                          ..scaleAdjoint(
                            isMoreOpen
                                ? moreOpenScale
                                : (isMoreSelected ? selectedScale : 1.0),
                          ),
                        transformAlignment: Alignment.center,
                        child: Icon(
                          isMoreOpen
                              ? Icons.close
                              : (selectedExtraItem?.icon ??
                                    Icons.more_horiz_rounded),
                          color: isMoreSelected
                              ? selectedColor
                              : unselectedColor,
                          size: iconSize,
                        ),
                      ),
                      if (showLabels && isMoreSelected)
                        Padding(
                          padding: EdgeInsets.only(top: labelPadding),
                          child: Text(
                            selectedExtraItem?.label ?? 'More',
                            style:
                                (textStyle ??
                                        Theme.of(context).textTheme.bodyMedium!)
                                    .copyWith(
                                      color: selectedColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: labelSize,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(children: children);
  }
}
