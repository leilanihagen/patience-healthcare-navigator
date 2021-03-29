import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/screens/checkHospital.dart';
import 'package:hospital_stay_helper/screens/guidelinesPage.dart';
import 'package:hospital_stay_helper/screens/profilePage.dart';
import 'package:hospital_stay_helper/screens/searchPage.dart';
import 'screens/guidelinesPage.dart';

class AppBottomNavBarController extends StatefulWidget {
  @override
  _AppBottomNavBarControllerState createState() =>
      _AppBottomNavBarControllerState();
}

// (Below) re-implementing the state of AppBottomNavBarController
class _AppBottomNavBarControllerState extends State<AppBottomNavBarController> {
  List<Widget> pages;
  PageController _pageController;
  int _selectedIndex;

  String purpleTheme = "#AB92F4";
  String lightPinkTheme = "#FDEBF1";
  String darkPinkTheme = "#ED558C";
  String blueTheme = "#54D0EB";
  String darkGreenTheme = "#758C20";
  String lightGreenTheme = "#A1BF36";

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    pages = [
      RootCategoriesPage(),
      ProfilePage(key: PageStorageKey('yourprofile')),
      HospitalSearchPage(key: PageStorageKey('hospitalsearch')),
      SearchPage(key: PageStorageKey('searchservices')),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _bottomNavBar(int selectedIndex) => BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (int index) => setState(() {
                _selectedIndex = index;
                _pageController.jumpToPage(index);
              }), // rebuild this widget
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconData(
                62421,
                fontFamily: 'MaterialIcons',
              )),
              label: 'Guidelines',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconData(59162, fontFamily: 'MaterialIcons'),
              ),
              label: 'Your Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe857, fontFamily: 'MaterialIcons')),
              label: 'Find In-Network Hospitals',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(59828, fontFamily: 'MaterialIcons')),
              label: 'Search Services',
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(_selectedIndex),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
