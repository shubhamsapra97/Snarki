
import 'package:flutter/material.dart';



class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int?)? onTap;
  final List<BottomNavigationBarItem> navItems;

  const BottomNavBar({Key? key, this.currentIndex = 0, this.onTap, this.navItems = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: SizedBox(
        height:
            //Platform.isAndroid ?
            kBottomNavigationBarHeight,
        //: 77,
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
         //   backgroundColor: AppTheme.primaryTextColor,
            elevation: 0,
            currentIndex: currentIndex,
            iconSize: 19,
            unselectedItemColor: Colors.white54,
         //   selectedItemColor: AppTheme.primaryColorLight,
            onTap: onTap,
            items: navItems),
      ),
    );
  }
}
