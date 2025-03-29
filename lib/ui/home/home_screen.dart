// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/color_data.dart';
import 'package:cairoshopping/ui/home/tabscreen/tab_cart.dart';
import 'package:cairoshopping/ui/home/tabscreen/tab_favourite.dart';
import 'package:cairoshopping/ui/home/tabscreen/tab_home.dart';
import 'package:cairoshopping/ui/home/tabscreen/tab_profile.dart';
// import 'package:shopping/ui/home/tabscreen/tab_favourite.dart';
// import 'package:shopping/ui/home/tabscreen/tab_home.dart';
// import 'package:shopping/ui/home/tabscreen/tab_profile.dart';

import '../../constants/custom_animated_bottom_bar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  int selectedTab;

  HomeScreen({Key? key, this.selectedTab=0}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  int currentPos = 0;
  final Color _activeColor = primaryColor;
  final Color _inactiveColor = Colors.transparent;

  List<Widget> listImages = [
    const TabHome(),
    const TabFavourite(),
    const TabCart(),
    const TabProfile(),
  ];

  @override
  void initState() {
    currentPos=widget.selectedTab;
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double bottomHeight = Constant.getPercentSize(screenHeight, 8.5);
    double iconHeight = Constant.getPercentSize(bottomHeight, 28);
    return WillPopScope(
        child: Scaffold(
          body: listImages[currentPos],
          bottomNavigationBar: CustomAnimatedBottomBar(
            containerHeight: bottomHeight,
            backgroundColor: backgroundColor,
            selectedIndex: currentPos,
            showElevation: true,
            itemCornerRadius: 24,
            curve: Curves.easeIn,
            totalItemCount: 4,
            onItemSelected: (index) => setState(() => currentPos = index),
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: 'Home',
                activeColor: _activeColor,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
                iconSize: iconHeight,
                imageName: "Home.svg",
              ),

              BottomNavyBarItem(
                title: 'Search',
                activeColor: _activeColor,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
                iconSize: iconHeight,
                imageName: "heart.svg",
              ),

              // BottomNavyBarItem(
              //   title: 'Messages',
              //   activeColor: _activeColor,
              //   inactiveColor: _inactiveColor,
              //   textAlign: TextAlign.center,
              //   iconSize: iconHeight,
              //   imageName: "messenger.png",
              // ),

              BottomNavyBarItem(
                title: 'Cart',
                activeColor: _activeColor,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
                iconSize: iconHeight,
                imageName: "Bag.svg",
              ),

              BottomNavyBarItem(
                title: 'All Pets',
                activeColor: _activeColor,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
                iconSize: iconHeight,
                imageName: "User.svg",
              ),

              //
              // BottomNavyBarItem(
              //   iconSize: iconHeight,
              //   title: 'Profile',
              //   activeColor: _activeColor,
              //   imageName: "more.png",
              //   inactiveColor: _inactiveColor,
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
          // bottomNavigationBar: customBar.FloatingNavbar(
          //   margin: EdgeInsets.zero,
          //   backgroundColor: Colors.white,
          //   selectedBackgroundColor: primaryColor,
          //   selectedItemColor: Colors.white,
          //   onTap: (val) {
          //     setState(() {
          //       currentPos = val;
          //     });
          //   },
          //   currentIndex: currentPos,
          //   items: [
          //     FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          //     FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          //     FloatingNavbarItem(
          //         icon: Icons.chat_bubble_outline, title: 'Chats'),
          //     FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
          //   ],
          // ),
        ),
        onWillPop: () async {
          Constant.closeApp();
          return false;
        });
  }
}
