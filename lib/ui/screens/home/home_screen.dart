import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/ui/screens/home/tabs/explore/explore_tab.dart';
import 'package:movies_app/ui/screens/home/tabs/home/home_tab.dart';
import 'package:movies_app/ui/screens/home/tabs/profile/profile_tab.dart';
import 'package:movies_app/ui/screens/home/tabs/search/search_tab.dart';
import 'package:movies_app/utils/size_utils.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabList = [HomeTab(), SearchTab(), ExploreTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.height * .01,
          horizontal: context.width * .01,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.darkGreyColor,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              _builtBottomNavBarItem(
                unSelectedIcon: SvgPicture.asset(AppAssets.homeIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssets.homeIcon,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
                isSelected: selectedIndex == 0,
              ),
              _builtBottomNavBarItem(
                unSelectedIcon: SvgPicture.asset(AppAssets.searchIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssets.searchIcon,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
                isSelected: selectedIndex == 1,
              ),
              _builtBottomNavBarItem(
                unSelectedIcon: SvgPicture.asset(AppAssets.exploreIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssets.exploreIcon,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
                isSelected: selectedIndex == 2,
              ),
              _builtBottomNavBarItem(
                unSelectedIcon: SvgPicture.asset(AppAssets.profileIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssets.profileIcon,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
                isSelected: selectedIndex == 3,
              ),
            ],
          ),
        ),
      ),
      body: tabList[selectedIndex],
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
