import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  // List<Widget> tabList = [HomeTab(), SearchTab(), ExploreTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.darkGreyColor,
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          _builtBottomNavBarItem(
            selectedIcon: Image.asset(
              AppAssets.homeIcon,
              color: AppColors.primaryColor,
            ),
            unSelectedIcon: Image.asset(AppAssets.homeIcon),
            label: '',
            isSelected: selectedIndex == 0,
          ),
          _builtBottomNavBarItem(
            selectedIcon: Image.asset(
              AppAssets.searchIcon,
              color: AppColors.primaryColor,
            ),
            unSelectedIcon: Image.asset(AppAssets.searchIcon),
            label: '',
            isSelected: selectedIndex == 1,
          ),
          _builtBottomNavBarItem(
            selectedIcon: Image.asset(
              AppAssets.exploreIcon,
              color: AppColors.primaryColor,
            ),
            unSelectedIcon: Image.asset(AppAssets.exploreIcon),
            label: '',
            isSelected: selectedIndex == 2,
          ),
          _builtBottomNavBarItem(
            unSelectedIcon: Image.asset(AppAssets.profileIcon),
            selectedIcon: Image.asset(
              AppAssets.profileIcon,
              color: AppColors.primaryColor,
            ),
            label: '',
            isSelected: selectedIndex == 3,
          ),

        ],
      ),
      // body: tabList[selectedIndex],

    );
  }

  BottomNavigationBarItem _builtBottomNavBarItem({
    required Widget selectedIcon,
    required Widget unSelectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: isSelected ? selectedIcon : unSelectedIcon,
      label: label,
    );
  }
}