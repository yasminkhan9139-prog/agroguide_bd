import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home/home_screen.dart';
import 'market/market_screen.dart';
import 'weather/weather_screen.dart';
import 'profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final screens = const [
    HomeScreen(),
    MarketScreen(),
    WeatherScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        indicatorColor: AppTheme.lightGreen,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'হোম'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'বাজার'),
          NavigationDestination(icon: Icon(Icons.cloud_outlined), selectedIcon: Icon(Icons.cloud), label: 'আবহাওয়া'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'প্রোফাইল'),
        ],
      ),
    );
  }
}
