import 'package:bottom_navigator/bottom_navigator.dart';
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
  final bool showSelectedMoreItem;
  final String? moreButtonLabel;
  final Widget? moreButtonWidget;
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
    required this.showSelectedMoreItem,
    required this.animationDuration,
    required this.iconCurve,
    required this.indicatorMetrics,
    required this.indicatorColors,
    required this.onItemTapped,
    required this.onToggleMore,
    this.moreButtonLabel,
    this.moreButtonWidget,
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
        ? (isTablet ? 6.0 : 4.0)
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

      final isCircleStyle = indicatorMetrics.style is CircleIndicatorStyle;

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
                if (!isCircleStyle)
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity:
                          (isSelected &&
                              indicatorMetrics.style != IndicatorStyle.none)
                          ? 1
                          : 0,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isCircleStyle
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: isSelected ? 1 : 0,
                                    child: SizedBox(
                                      width: iconSize + 24,
                                      height: iconSize + 24,
                                      child: indicatorMetrics.style
                                          .buildIndicator(
                                            context: context,
                                            isSelected: isSelected,
                                            metrics: indicatorMetrics,
                                            animationDuration:
                                                animationDuration,
                                            itemColor: item.activeColor,
                                            indicatorColors: indicatorColors,
                                          ),
                                    ),
                                  ),
                                  _buildBadge(
                                    AnimatedContainer(
                                      duration: animationDuration,
                                      curve: iconCurve,
                                      transform: Matrix4.identity()
                                        ..scaleAdjoint(
                                          isSelected ? selectedScale : 1.0,
                                        ),
                                      transformAlignment: Alignment.center,
                                      child:
                                          item.customWidget ??
                                          Icon(
                                            item.icon,
                                            color: isSelected
                                                ? (item.activeColor ??
                                                      selectedColor)
                                                : unselectedColor,
                                            size: iconSize,
                                          ),
                                    ),
                                    item.badge,
                                  ),
                                ],
                              )
                            : _buildBadge(
                                AnimatedContainer(
                                  duration: animationDuration,
                                  curve: iconCurve,
                                  transform: Matrix4.identity()
                                    ..scaleAdjoint(
                                      isSelected ? selectedScale : 1.0,
                                    ),
                                  transformAlignment: Alignment.center,
                                  child:
                                      item.customWidget ??
                                      Icon(
                                        item.icon,
                                        color: isSelected
                                            ? (item.activeColor ??
                                                  selectedColor)
                                            : unselectedColor,
                                        size: iconSize,
                                      ),
                                ),
                                item.badge,
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
      final isMoreSelected =
          isMoreOpen || (showSelectedMoreItem && selectedExtraItem != null);
      final isCircleStyle = indicatorMetrics.style is CircleIndicatorStyle;

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
                if (!isCircleStyle)
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity:
                          (isMoreSelected &&
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
                      isCircleStyle
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isMoreSelected ? 1 : 0,
                                  child: SizedBox(
                                    width: iconSize + 24,
                                    height: iconSize + 24,
                                    child: indicatorMetrics.style
                                        .buildIndicator(
                                          context: context,
                                          isSelected: isMoreSelected,
                                          metrics: indicatorMetrics,
                                          animationDuration: animationDuration,
                                          indicatorColors: indicatorColors,
                                        ),
                                  ),
                                ),
                                _buildBadge(
                                  AnimatedContainer(
                                    duration: animationDuration,
                                    curve: iconCurve,
                                    transform: Matrix4.identity()
                                      ..scaleAdjoint(
                                        isMoreOpen
                                            ? moreOpenScale
                                            : (isMoreSelected
                                                  ? selectedScale
                                                  : 1.0),
                                      ),
                                    transformAlignment: Alignment.center,
                                    child: isMoreOpen
                                        ? Icon(
                                            Icons.close,
                                            color: isMoreSelected
                                                ? selectedColor
                                                : unselectedColor,
                                            size: iconSize,
                                          )
                                        : (showSelectedMoreItem &&
                                                  selectedExtraItem != null
                                              ? (selectedExtraItem
                                                        .customWidget ??
                                                    Icon(
                                                      selectedExtraItem.icon,
                                                      color: isMoreSelected
                                                          ? selectedColor
                                                          : unselectedColor,
                                                      size: iconSize,
                                                    ))
                                              : (moreButtonWidget ??
                                                    Icon(
                                                      Icons.more_horiz_rounded,
                                                      color: isMoreSelected
                                                          ? selectedColor
                                                          : unselectedColor,
                                                      size: iconSize,
                                                    ))),
                                  ),
                                  (!isMoreOpen &&
                                          extraItems.any(
                                            (e) =>
                                                e.badge != null &&
                                                e.badge!.showBadge,
                                          ))
                                      ? const BottomNavBadge(showBadge: true)
                                      : null,
                                ),
                              ],
                            )
                          : _buildBadge(
                              AnimatedContainer(
                                duration: animationDuration,
                                curve: iconCurve,
                                transform: Matrix4.identity()
                                  ..scaleAdjoint(
                                    isMoreOpen
                                        ? moreOpenScale
                                        : (isMoreSelected
                                              ? selectedScale
                                              : 1.0),
                                  ),
                                transformAlignment: Alignment.center,
                                child: isMoreOpen
                                    ? Icon(
                                        Icons.close,
                                        color: isMoreSelected
                                            ? selectedColor
                                            : unselectedColor,
                                        size: iconSize,
                                      )
                                    : (showSelectedMoreItem &&
                                              selectedExtraItem != null
                                          ? (selectedExtraItem.customWidget ??
                                                Icon(
                                                  selectedExtraItem.icon,
                                                  color: isMoreSelected
                                                      ? selectedColor
                                                      : unselectedColor,
                                                  size: iconSize,
                                                ))
                                          : (moreButtonWidget ??
                                                Icon(
                                                  Icons.more_horiz_rounded,
                                                  color: isMoreSelected
                                                      ? selectedColor
                                                      : unselectedColor,
                                                  size: iconSize,
                                                ))),
                              ),
                              (!isMoreOpen &&
                                      extraItems.any(
                                        (e) =>
                                            e.badge != null &&
                                            e.badge!.showBadge,
                                      ))
                                  ? const BottomNavBadge(showBadge: true)
                                  : null,
                            ),
                      if (showLabels && isMoreSelected)
                        Padding(
                          padding: EdgeInsets.only(top: labelPadding),
                          child: Text(
                            showSelectedMoreItem && selectedExtraItem != null
                                ? selectedExtraItem.label
                                : (moreButtonLabel ?? 'More'),
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

  Widget _buildBadge(Widget child, BottomNavBadge? badge) {
    if (badge == null || !badge.showBadge) return child;

    final isDot = badge.text == null || badge.text!.isEmpty;

    Widget badgeWidget;
    if (isDot) {
      badgeWidget = Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          color: badge.color ?? Colors.red,
          shape: BoxShape.circle,
        ),
      );
    } else {
      badgeWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        constraints: const BoxConstraints(minWidth: 16.0, minHeight: 16.0),
        decoration: BoxDecoration(
          color: badge.color ?? Colors.red,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          badge.text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
          ).merge(badge.textStyle),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: badge.offset?.dy ?? -8.0,
          right: badge.offset?.dx ?? -8.0,
          child: badgeWidget,
        ),
      ],
    );
  }
}
