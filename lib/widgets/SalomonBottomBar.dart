import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  const BottomNavigation({Key? key, required this.child}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // _updateIndexFromLocation();
  }

  // void _updateIndexFromLocation() {
  //   final currentLocation = GoRouter.of(context).;
  //   if (currentLocation == '/') {
  //     _currentIndex = 0;
  //   } else if (currentLocation.contains('search')) {
  //     _currentIndex = 1;
  //   } else if (currentLocation.contains('notifications')) {
  //     _currentIndex = 2;
  //   } else if (currentLocation.contains('profile')) {
  //     _currentIndex = 3;
  //   }
  // }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/search');
        break;
      case 2:
        GoRouter.of(context).go('/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            selectedColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
