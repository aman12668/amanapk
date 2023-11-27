import 'package:ENEB_HUB/app/screens/main/screens/drawer/page/favourites_page.dart';
import 'package:ENEB_HUB/app/screens/main/screens/drawer/widget/navigation_drawer_widget.dart';
import 'package:ENEB_HUB/app/screens/main/screens/tabs/favourate_page.dart';
import 'package:ENEB_HUB/app/screens/main/screens/tabs/profile_page.dart';
import 'package:ENEB_HUB/app/screens/main/screens/tabs/search_page.dart';
import 'package:ENEB_HUB/app/screens/main/screens/tabs/setting_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../HomeScreen.dart';
import '../../../../Widgets/consttants.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int index = 0;
  final screen = [
    const HomeScreen(),
    const FavoriteScreen(),
    const SearchPage(),
    const ProfilePage(),
    const SettingPage(),
  ];

  onPageChange(int pageIndex) {
    setState(() {
      index = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      const Icon(Icons.home, size: 30),
      const Icon(Icons.search, size: 30),
      const Icon(Icons.favorite, size: 30),
      const Icon(Icons.person, size: 30),
      const Icon(Icons.settings, size: 30)
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MenuScreenPage(),
      extendBody: true,
      body: IndexedStack(
        children: [screen[index]],
      ),
      // Center(
      //   child: Text(
      //     '$index',
      //     style: const TextStyle(
      //         fontSize: 110, fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      // ),
      // bottomNavigationBar: Theme(
      //   // this them is for to change icon colors.
      //   data: Theme.of(context).copyWith(
      //       iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   )),
      //   child: CurvedNavigationBar(
      //     animationDuration: const Duration(milliseconds: 300),
      //     // navigationBar colors
      //     color: Colors.grey,
      //     //selected times colors
      //     buttonBackgroundColor: Colors.black,
      //     backgroundColor: Colors.transparent,
      //     items: items,
      //     height: 75,
      //     index: index,
      //     onTap: (index) => setState(
      //       () => this.index = index,
      //     ),
      //   ),
      // ),

      bottomNavigationBar: buildCustomBottomNavigation(),
    );
  }

  Widget buildActivePageDot() {
    return Positioned(
      top: 5,
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget buildCustomBottomNavigation() {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 3,
            color: kShadowColor.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: index == 0 ? Colors.black : Colors.grey,
                ),
                onPressed: () => onPageChange(0),
              ),
              if (index == 0) buildActivePageDot()
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: index == 1 ? Colors.redAccent : Colors.grey,
                ),
                onPressed: () => onPageChange(1),
              ),
              if (index == 1) buildActivePageDot()
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  color: index == 2 ? Colors.black : Colors.grey,
                ),
                onPressed: () => onPageChange(2),
              ),
              if (index == 2) buildActivePageDot()
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notification_important_rounded,
                  color: index == 3 ? Colors.black : Colors.grey,
                ),
                onPressed: () => onPageChange(3),
              ),
              if (index == 3) buildActivePageDot()
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.person_3_rounded,
                  color: index == 4 ? Colors.black : Colors.grey,
                ),
                onPressed: () => onPageChange(4),
              ),
              if (index == 4) buildActivePageDot()
            ],
          ),
        ],
      ),
    );
  }
}
