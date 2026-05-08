import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'nav_item.dart';
import 'painter/nav_bar_painter.dart';
import 'enums.dart';
import 'styles/nav_bar_indicator_style.dart';
import 'styles/nav_bar_theme_resolver.dart';
import 'widgets/nav_more_menu.dart';
import 'widgets/nav_items_row.dart';
import 'widgets/nav_center_action_overlays.dart';

/// A highly customizable, glassmorphic bottom navigation bar for Flutter.
///
/// Features include:
/// * Glassmorphism with customizable blur and opacity.
/// * Automatic "More" menu aggregation for more than 5 items.
/// * Multiple indicator styles (pill, dot, line, square).
/// * Supports center action buttons (both internal and external).
/// * Haptic feedback and smooth animations.
class BottomNavBar extends StatefulWidget {
  /// The list of items to display in the navigation bar.
  final List<BottomNavItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// The background color of the navigation bar.
  final Color? backgroundColor;

  /// The amount of blur to apply to the glass effect.
  final double blurAmount;

  /// The border radius of the navigation bar container.
  final double borderRadius;

  /// Padding around the content inside the bar.
  final EdgeInsets padding;

  /// Margin around the navigation bar container.
  final EdgeInsets margin;

  /// Colors for the animated indicator gradient.
  final List<Color>? indicatorColors;

  /// Color of the selected item's icon and label.
  final Color? selectedItemColor;

  /// Color of the unselected item's icon and label.
  final Color? unselectedItemColor;

  /// Whether to hide the navigation bar when scrolling.
  final bool hideOnScroll;

  /// The scroll controller to monitor for hide-on-scroll functionality.
  final ScrollController? scrollController;

  /// The curve used for the indicator's movement animation.
  final Curve indicatorCurve;

  /// The curve used for icon scaling animations.
  final Curve iconCurve;

  /// The duration of all animations in the bar.
  final Duration animationDuration;

  /// An optional widget to display as a floating center button.
  final Widget? centerButton;

  /// The style of the center button (none, notched, floating).
  final CenterButtonStyle centerButtonStyle;

  /// Whether to show labels below the icons.
  final bool showLabels;

  /// The shape/style of the selection indicator.
  final IndicatorStyle indicatorStyle;

  /// The overall layout style (docked or floating).
  final NavBarStyle navBarStyle;

  /// Custom text style for the labels.
  final TextStyle? textStyle;

  /// Callback fired when an item is selected.
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.backgroundColor,
    this.blurAmount = 15.0,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.margin = const EdgeInsets.all(20),
    this.indicatorColors,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.hideOnScroll = false,
    this.scrollController,
    this.indicatorCurve = Curves.easeOutBack,
    this.iconCurve = Curves.easeInOut,
    this.centerButton,
    this.centerButtonStyle = CenterButtonStyle.none,
    this.showLabels = true,
    this.indicatorStyle = IndicatorStyle.pill,
    this.animationDuration = const Duration(milliseconds: 400),
    this.navBarStyle = NavBarStyle.floating,
    this.textStyle,
    this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool _isVisible = true;
  bool _isMoreOpen = false;
  late int _internalIndex;

  int get _effectiveIndex => _internalIndex;

  /// Handles item selection, haptics, and menu closing logic.
  void _onItemTapped(int index, {bool closeMoreMenu = false}) {
    if (_internalIndex != index && mounted) {
      setState(() => _internalIndex = index);
    }

    // Call item-specific callback if provided
    final itemTapHandler = widget.items[index].onTap;
    itemTapHandler?.call();

    // Notify parent of index change
    widget.onTap?.call(index);

    if (closeMoreMenu && _isMoreOpen && mounted) {
      setState(() => _isMoreOpen = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _internalIndex = widget.currentIndex;
    if (widget.hideOnScroll && widget.scrollController != null) {
      widget.scrollController!.addListener(_scrollListener);
    }
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _internalIndex = widget.currentIndex;
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isVisible) setState(() => _isVisible = false);
    } else if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isVisible) setState(() => _isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navTheme = theme.bottomNavigationBarTheme;
    final colorScheme = theme.colorScheme;
    final themeColors = resolveNavBarThemeColors(
      theme: theme,
      navTheme: navTheme,
      backgroundColor: widget.backgroundColor,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Determine layout metrics and split items if > 5
        final bool hasMore = widget.items.length > 5;
        final List<BottomNavItem> displayItems = hasMore
            ? widget.items.sublist(0, 3)
            : widget.items;
        final List<BottomNavItem> extraItems = hasMore
            ? widget.items.sublist(3)
            : [];

        final bool isDocked = widget.navBarStyle == NavBarStyle.docked;
        final double barHeight = isDocked ? 72.0 : 65.0;
        final double width = isDocked
            ? constraints.maxWidth
            : constraints.maxWidth - widget.margin.horizontal;

        final hasExternalCenterButton = widget.centerButton != null;

        // 2. Calculate slot-based widths and indices
        // totalSlots includes the center button gap if applicable
        final totalSlots = hasExternalCenterButton
            ? (hasMore ? 4 : displayItems.length) + 1
            : (hasMore ? 4 : displayItems.length);
        final itemWidth = (width - widget.padding.horizontal) / totalSlots;
        final midIndex = ((hasMore ? 4 : displayItems.length) / 2).floor();

        // 3. Resolve indicator position and visual style
        final indicatorMetrics = resolveIndicatorMetrics(
          style: resolveEffectiveIndicatorStyle(
            showLabels: widget.showLabels,
            preferredStyle: widget.indicatorStyle,
          ),
          itemWidth: itemWidth,
        );

        // If an item in the "More" menu is selected, the indicator stays on the "More" button (index 3)
        final indicatorIndex =
            (hasMore && (_isMoreOpen || _effectiveIndex >= 3))
            ? 3
            : _effectiveIndex;

        return Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // 1. The Main Navigation Bar (Animated for hide-on-scroll)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: _isVisible ? Offset.zero : const Offset(0, 2),
                curve: Curves.easeInOutCubic,
                child: Container(
                  margin: isDocked ? EdgeInsets.zero : widget.margin,
                  decoration: isDocked
                      ? BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 0.5,
                            ),
                          ),
                        )
                      : null,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Background with Painter for the glass effect and notch/floating shape
                      CustomPaint(
                        size: Size(width, barHeight),
                        painter: NavBarPainter(
                          backgroundColor: themeColors.backgroundColor,
                          borderRadius: isDocked ? 0.0 : widget.borderRadius,
                          style: widget.centerButtonStyle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            isDocked ? 0.0 : widget.borderRadius,
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: widget.blurAmount,
                              sigmaY: widget.blurAmount,
                            ),
                            child: Container(
                              padding: widget.padding,
                              height: barHeight,
                              child: Stack(
                                children: [
                                  // Animated Indicator
                                  AnimatedPositioned(
                                    duration: widget.animationDuration,
                                    curve: widget.indicatorCurve,
                                    left:
                                        (hasExternalCenterButton &&
                                            indicatorIndex >= midIndex)
                                        ? (indicatorIndex + 1) * itemWidth
                                        : indicatorIndex * itemWidth,
                                    width: itemWidth,
                                    top: indicatorMetrics.top,
                                    bottom: indicatorMetrics.bottom,
                                    child: AnimatedOpacity(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      opacity:
                                          widget
                                              .items[_effectiveIndex]
                                              .isCenterAction
                                          ? 0
                                          : 1,
                                      child: Container(
                                        alignment: indicatorMetrics.alignment,
                                        child: AnimatedContainer(
                                          duration: widget.animationDuration,
                                          width: indicatorMetrics.width,
                                          height: indicatorMetrics.height,
                                          transform: null,
                                          transformAlignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors:
                                                  widget
                                                          .items[_effectiveIndex]
                                                          .activeColor !=
                                                      null
                                                  ? [
                                                      widget
                                                          .items[_effectiveIndex]
                                                          .activeColor!,
                                                      widget
                                                          .items[_effectiveIndex]
                                                          .activeColor!
                                                          .withValues(
                                                            alpha: 0.7,
                                                          ),
                                                    ]
                                                  : (widget.indicatorColors ??
                                                        [
                                                          colorScheme.primary,
                                                          colorScheme.primary
                                                              .withValues(
                                                                alpha: 0.7,
                                                              ),
                                                        ]),
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              indicatorMetrics.borderRadius,
                                            ),
                                            boxShadow: [
                                              if (indicatorMetrics.showGlow)
                                                BoxShadow(
                                                  color:
                                                      (widget
                                                                  .items[_effectiveIndex]
                                                                  .activeColor ??
                                                              widget
                                                                  .indicatorColors
                                                                  ?.first ??
                                                              colorScheme
                                                                  .primary)
                                                          .withValues(
                                                            alpha: 0.3,
                                                          ),
                                                  blurRadius: 15,
                                                  spreadRadius: -2,
                                                  offset: const Offset(0, 4),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Items
                                  NavItemsRow(
                                    displayItems: displayItems,
                                    extraItems: extraItems,
                                    effectiveIndex: _effectiveIndex,
                                    isMoreOpen: _isMoreOpen,
                                    hasMore: hasMore,
                                    itemWidth: itemWidth,
                                    selectedColor:
                                        themeColors.selectedItemColor,
                                    unselectedColor:
                                        themeColors.unselectedItemColor,
                                    midIndex: midIndex,
                                    hasExternalCenterButton:
                                        hasExternalCenterButton,
                                    showLabels: widget.showLabels,
                                    animationDuration: widget.animationDuration,
                                    iconCurve: widget.iconCurve,
                                    textStyle: widget.textStyle,
                                    onItemTapped: _onItemTapped,
                                    onToggleMore: () => setState(
                                      () => _isMoreOpen = !_isMoreOpen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Center Button Overlay (External)
                      if (hasExternalCenterButton)
                        Positioned(
                          top:
                              widget.centerButtonStyle ==
                                  CenterButtonStyle.notched
                              ? -25
                              : -30,
                          child: widget.centerButton!,
                        ),
                      // Internal Center Action Overlay
                      NavCenterActionOverlays(
                        items: widget.items,
                        itemWidth: itemWidth,
                        midIndex: midIndex,
                        hasExternalCenterButton: hasExternalCenterButton,
                        padding: widget.padding,
                        onItemTapped: _onItemTapped,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 2. The More Menu (Sibling to the bar for independent hit-testing)
            if (hasMore)
              NavMoreMenu(
                isMoreOpen: _isMoreOpen,
                borderRadius: widget.borderRadius,
                blurAmount: widget.blurAmount,
                backgroundColor: themeColors.backgroundColor,
                extraItems: extraItems,
                currentIndex: _effectiveIndex,
                selectedColor: themeColors.selectedItemColor,
                unselectedColor: themeColors.unselectedItemColor,
                textStyle: widget.textStyle,
                onItemTap: (index) {
                  _onItemTapped(index, closeMoreMenu: true);
                },
              ),
          ],
        );
      },
    );
  }
}
