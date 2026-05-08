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
import 'widgets/nav_layout_utils.dart';

/// A highly customizable, glassmorphic bottom navigation bar for Flutter.
class BottomNavBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final Color? backgroundColor;
  final double blurAmount;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<Color>? indicatorColors;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool hideOnScroll;
  final ScrollController? scrollController;
  final Curve indicatorCurve;
  final Curve iconCurve;
  final Duration animationDuration;
  final Widget? centerButton;
  final CenterButtonStyle centerButtonStyle;
  final bool showLabels;
  final IndicatorStyle indicatorStyle;
  final NavBarStyle navBarStyle;
  final TextStyle? textStyle;
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

  void _onItemTapped(int index, {bool closeMoreMenu = false}) {
    if (_internalIndex != index && mounted) {
      setState(() => _internalIndex = index);
    }

    final itemTapHandler = widget.items[index].onTap;
    itemTapHandler?.call();
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
        final bool hasMore = widget.items.length > 5;
        final List<BottomNavItem> displayItems = hasMore
            ? widget.items.sublist(0, 3)
            : widget.items;
        final List<BottomNavItem> extraItems = hasMore
            ? widget.items.sublist(3)
            : [];

        final bool isTablet = NavLayoutUtils.isTablet(constraints.maxWidth);
        final bool isDocked = widget.navBarStyle == NavBarStyle.docked;
        final double barHeight = NavLayoutUtils.getBarHeight(
          isTablet: isTablet,
          isDocked: isDocked,
        );
        final double width = isDocked
            ? constraints.maxWidth
            : constraints.maxWidth -
                NavLayoutUtils.getHorizontalMargin(
                  widget.margin.horizontal,
                  isTablet,
                );

        final hasExternalCenterButton = widget.centerButton != null;

        // 2. Calculate slot-based widths and indices
        final totalSlots = hasExternalCenterButton
            ? (hasMore ? 4 : displayItems.length) + 1
            : (hasMore ? 4 : displayItems.length);

        final horizontalPadding = NavLayoutUtils.getHorizontalPadding(
          widget.padding.horizontal,
          isTablet,
        );

        final itemWidth = (width - horizontalPadding) / totalSlots;
        final midIndex = ((hasMore ? 4 : displayItems.length) / 2).floor();

        final indicatorMetrics = resolveIndicatorMetrics(
          style: resolveEffectiveIndicatorStyle(
            showLabels: widget.showLabels,
            preferredStyle: widget.indicatorStyle,
          ),
          itemWidth: itemWidth,
          isTablet: isTablet,
        );

        final indicatorIndex =
            (hasMore && (_isMoreOpen || _effectiveIndex >= 3))
            ? 3
            : _effectiveIndex;

        return Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // Spacer to ensure the Stack is tall enough for floating center buttons
            SizedBox(height: barHeight + widget.margin.bottom + (isTablet ? 60 : 40)),

            // 1. The Main Navigation Bar
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
                              padding: isTablet
                                  ? widget.padding.copyWith(
                                      left: widget.padding.left * 2,
                                      right: widget.padding.right * 2,
                                    )
                                  : widget.padding,
                              height: barHeight,
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: widget.animationDuration,
                                    curve: widget.indicatorCurve,
                                    left: (hasExternalCenterButton &&
                                            indicatorIndex >= midIndex)
                                        ? (indicatorIndex + 1) * itemWidth
                                        : indicatorIndex * itemWidth,
                                    width: itemWidth,
                                    top: indicatorMetrics.top,
                                    bottom: indicatorMetrics.bottom,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 200),
                                      opacity: widget.items[_effectiveIndex].isCenterAction ? 0 : 1,
                                      child: Container(
                                        alignment: indicatorMetrics.alignment,
                                        child: AnimatedContainer(
                                          duration: widget.animationDuration,
                                          width: indicatorMetrics.width,
                                          height: indicatorMetrics.height,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: widget.items[_effectiveIndex].activeColor != null
                                                  ? [
                                                      widget.items[_effectiveIndex].activeColor!,
                                                      widget.items[_effectiveIndex].activeColor!.withValues(alpha: 0.7),
                                                    ]
                                                  : (widget.indicatorColors ??
                                                      [
                                                        colorScheme.primary,
                                                        colorScheme.primary.withValues(alpha: 0.7),
                                                      ]),
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(indicatorMetrics.borderRadius),
                                            boxShadow: [
                                              if (indicatorMetrics.showGlow)
                                                BoxShadow(
                                                  color: (widget.items[_effectiveIndex].activeColor ??
                                                          widget.indicatorColors?.first ??
                                                          colorScheme.primary)
                                                      .withValues(alpha: 0.3),
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
                                  NavItemsRow(
                                    displayItems: displayItems,
                                    extraItems: extraItems,
                                    effectiveIndex: _effectiveIndex,
                                    isMoreOpen: _isMoreOpen,
                                    hasMore: hasMore,
                                    itemWidth: itemWidth,
                                    isTablet: isTablet,
                                    selectedColor: themeColors.selectedItemColor,
                                    unselectedColor: themeColors.unselectedItemColor,
                                    midIndex: midIndex,
                                    hasExternalCenterButton: hasExternalCenterButton,
                                    showLabels: widget.showLabels,
                                    animationDuration: widget.animationDuration,
                                    iconCurve: widget.iconCurve,
                                    textStyle: widget.textStyle,
                                    onItemTapped: _onItemTapped,
                                    onToggleMore: () => setState(() => _isMoreOpen = !_isMoreOpen),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. The More Menu
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
                isTablet: isTablet,
              ),

            // 3. Center Button Overlay (External) - Very front for maximum clickability
            if (hasExternalCenterButton)
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
                    height: barHeight,
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: widget.centerButtonStyle == CenterButtonStyle.notched ? -25 : -30,
                          child: widget.centerButton!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // 4. Internal Center Action Overlay
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
                  height: barHeight,
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  child: NavCenterActionOverlays(
                    items: widget.items,
                    itemWidth: itemWidth,
                    midIndex: midIndex,
                    hasExternalCenterButton: hasExternalCenterButton,
                    padding: widget.padding,
                    onItemTapped: _onItemTapped,
                    isTablet: isTablet,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
