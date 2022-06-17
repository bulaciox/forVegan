import 'package:flutter/material.dart';

import 'package:for_vegan/pages/navpages/add_page.dart';
import 'package:for_vegan/pages/navpages/fav_page.dart';
import 'package:for_vegan/pages/navpages/profile_page.dart';
import 'package:for_vegan/pages/navpages/search_page.dart';
import 'package:for_vegan/pages/navpages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const SearchPage(),
    const AddPage(),
    const FavPage(),
    const ProfilePage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(122, 122, 199, 1.0),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.home_filled, size: 30)),
          BottomNavigationBarItem(
              label: 'Search', icon: Icon(Icons.search, size: 30)),
          BottomNavigationBarItem(
              label: 'Add', icon: Icon(Icons.add, size: 30)),
          BottomNavigationBarItem(
              label: 'Fav', icon: Icon(Icons.favorite_border, size: 30)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person, size: 30)),
        ],
      ),
    );
  }
}
