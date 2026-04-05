import 'dart:ui';
import 'package:flutter/material.dart';

import 'home.dart';
import 'detect_pet_page.dart';
import 'calendar_page.dart';
import 'profile_page.dart';
import 'history_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DetectPetPage(),
    const HistoryPage(),
    const CalendarPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget navItem(IconData icon, int index) {

    const Color orange = Color(0xFFF4A261);
    const Color green = Color(0xFF2A9D8F);

    bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),

        child: AnimatedScale(
          scale: isSelected ? 1.25 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,

          child: Icon(
            icon,
            size: 28,
            color: isSelected ? orange : green,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,
      body: _pages[_selectedIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

            child: Container(
              height: 65,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  navItem(Icons.home, 0),
                  navItem(Icons.camera_alt, 1),
                  navItem(Icons.history, 2),
                  navItem(Icons.calendar_month, 3),
                  navItem(Icons.person, 4),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}