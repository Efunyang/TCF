import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: Theme.of(context).colorScheme.secondary,
        gapWidth: 0,
        gapLocation: GapLocation.none,
        rightCornerRadius: 25,
        leftCornerRadius: 25,
        iconSize: 32,
        icons: const [
          Icons.home,
          Icons.change_circle,
          Icons.access_time_filled_outlined,
          Icons.person,
        ],
        activeIndex: navigationShell.currentIndex,
        onTap: _goBranch,
      ),
    );
  }
}
