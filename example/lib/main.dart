import 'package:example/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navigator/bottom_navigator.dart';

void main() {
  runApp(const BottomNavDemo());
}

class BottomNavDemo extends StatelessWidget {
  const BottomNavDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Nav Demo',
      debugShowCheckedModeBanner: kDebugMode,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Outfit',
        colorSchemeSeed: Colors.deepOrange,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.deepOrange.withValues(alpha: 0.5),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

enum _SelectedTab { home, search, likes, profile, maps, settings, flutter }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static void _logMapsClick() => debugPrint('Maps item clicked');
  static void _logSettingsClick() => debugPrint('Settings item clicked');

  _SelectedTab _selectedTab = _SelectedTab.home;
  final ScrollController _scrollController = ScrollController();
  _NavVariant _navVariant = _NavVariant.classic;
  IndicatorStyle _indicatorStyle = pilledIndicator;
  bool _showLabels = false;
  double _borderRadius = 30.0;

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  List<BottomNavItem> get _navItems => [
    BottomNavItem(
      icon: Icons.home_rounded,
      label: 'Home',
      activeColor: Colors.amber,
      // activeColor: Color(0xFF6366F1),
    ),
    BottomNavItem(
      icon: Icons.search_rounded,
      label: 'Search',
      // activeColor: Color(0xFF10B981),
    ),
    BottomNavItem(
      icon: Icons.favorite_rounded,
      label: 'Likes',
      // activeColor: Colors.deepOrange,
    ),
    BottomNavItem(
      icon: Icons.person_rounded,
      label: 'Profile',
      // activeColor: Color(0xFFF59E0B),
    ),
    BottomNavItem(
      icon: Icons.map,
      label: 'Maps',
      onTap: () {
        _logMapsClick();
      },
      // activeColor: Color(0xFFF59E0B),
    ),
    BottomNavItem(
      icon: Icons.settings,
      label: 'Settings',
      onTap: () {
        _logSettingsClick();
      },
      // activeColor: Color(0xFFF59E0B),
    ),
    BottomNavItem(
      icon: Icons.settings,
      label: 'Flutter',
      customWidget: FlutterLogo(size: 24),
      // activeColor: Color(0xFFF59E0B),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for the floating glass bar
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F172A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildPage(_selectedTab.index),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildPage(int index) {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 100, bottom: 150),
      itemCount: 20,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      _navItems[index].activeColor ??
                          BottomNavBarColors.primaryStart,
                      (_navItems[index].activeColor ??
                              BottomNavBarColors.primaryEnd)
                          .withValues(alpha: 0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_navItems[index].activeColor ??
                                  BottomNavBarColors.primaryStart)
                              .withValues(alpha: 0.5),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  _navItems[index].icon,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _navItems[index].label,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Explore the premium glassmorphism design',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 40),
              // Controls
              const Text(
                'Bottom Bar Variant',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _navVariant = _NavVariant.classic),
                    child: const Text('Classic'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _navVariant = _NavVariant.docked),
                    child: const Text('Docked'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _navVariant = _NavVariant.floating),
                    child: const Text('Floating'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _navVariant = _NavVariant.notched),
                    child: const Text('Notched'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Indicator Style',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _indicatorStyle = pilledIndicator),
                    child: const Text('Pill'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _indicatorStyle = IndicatorStyle.none),
                    child: const Text('None'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _indicatorStyle = lineIndicator),
                    child: const Text('Line'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _indicatorStyle = squareIndicator),
                    child: const Text('Square'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => _indicatorStyle = circleIndicator),
                    child: const Text('Circle'),
                  ),
                ],
              ),
              const Text(
                'Show Labels',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Switch(
                value: _showLabels,
                onChanged: (val) => setState(() => _showLabels = val),
              ),
              const SizedBox(height: 16),
              Text(
                'Border Radius: ${_borderRadius.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Slider(
                value: _borderRadius,
                activeColor: Colors.deepOrange,
                inactiveColor: Colors.deepOrange.withValues(alpha: 0.3),
                min: 0,
                max: 50,
                onChanged: (val) => setState(() => _borderRadius = val),
              ),
              const SizedBox(height: 24),
            ],
          );
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Center(
            child: Text(
              'Scroll Item $i',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    final fab = FloatingActionButton(
      elevation: 5,
      backgroundColor: BottomNavBarColors.glassBackground.withValues(
        alpha: 0.1,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Center fab clicked',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: BottomNavBarColors.electricBlue,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: const FlutterLogo(size: 50, curve: Curves.bounceIn),
      ),
    );

    switch (_navVariant) {
      case _NavVariant.classic:
        return ClassicNavBottomBar(
          items: _navItems,
          blurAmount: 25,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          hideOnScroll: true,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.all(9),
          scrollController: _scrollController,
          indicatorCurve: Curves.easeInCubic,
          animationDuration: const Duration(milliseconds: 300),
          showLabels: _showLabels,
          borderRadius: _borderRadius,
          indicatorStyle: _indicatorStyle,
          onTap: _handleIndexChanged,
        );
      case _NavVariant.docked:
        return DockedNavBottomBar(
          items: _navItems,
          blurAmount: 5,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          hideOnScroll: false,
          moreButtonLabel: "More",
          moreButtonWidget: const Icon(Icons.more_horiz, size: 40),
          showSelectedMoreItem: true,
          scrollController: _scrollController,
          indicatorCurve: Curves.easeInCubic,
          centerButton: fab,
          animationDuration: const Duration(milliseconds: 300),
          showLabels: _showLabels,
          indicatorStyle: _indicatorStyle,
          borderRadius: _borderRadius,
          onTap: _handleIndexChanged,
        );
      case _NavVariant.floating:
        return FloatingNavBottomBar(
          items: _navItems,
          blurAmount: 5,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          centerButton: fab,
          hideOnScroll: false,
          scrollController: _scrollController,
          indicatorCurve: Curves.easeInCubic,
          animationDuration: const Duration(milliseconds: 300),
          showLabels: _showLabels,
          indicatorStyle: _indicatorStyle,
          borderRadius: _borderRadius,
          onTap: _handleIndexChanged,
        );
      case _NavVariant.notched:
        return NotchedNavBottomBar(
          items: _navItems,
          blurAmount: 5,

          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          centerButton: fab,
          hideOnScroll: false,
          scrollController: _scrollController,
          indicatorCurve: Curves.easeInCubic,
          animationDuration: const Duration(milliseconds: 300),
          showLabels: _showLabels,
          indicatorStyle: _indicatorStyle,
          borderRadius: _borderRadius,
          onTap: _handleIndexChanged,
        );
    }
  }
}

enum _NavVariant { classic, docked, floating, notched }
