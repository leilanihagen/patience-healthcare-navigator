import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/screens/checkHospital.dart';
import 'package:hospital_stay_helper/screens/guidelinesPage.dart';
import 'package:hospital_stay_helper/screens/profilePage.dart';
import 'package:hospital_stay_helper/screens/searchPage.dart';
import 'package:hospital_stay_helper/screens/visitsTimelinePage.dart';
import 'screens/guidelinesPage.dart';
import 'screens/visitsTimelinePage.dart';

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

  String purpleTheme = "#66558E";
  String lightPinkTheme = "#FDEBF1";
  String darkPinkTheme = "#ED558C";
  String blueTheme = "#44B5CD";
  String darkGreenTheme = "#758C20";
  String lightGreenTheme = "#A1BF36";

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    pages = [
      RootCategoriesPage(),
      VisitsTimelinePage(key: PageStorageKey('visitstimeline')),
      HospitalSearchPage(key: PageStorageKey('hospitalsearch')),
      SearchPage(key: PageStorageKey('searchservices')),
      ProfilePage(key: PageStorageKey('yourprofile')),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _bottomNavBar(int selectedIndex) => BottomNavigationBar(
          selectedItemColor: HexColor(blueTheme),
          unselectedItemColor: Colors.grey,
          backgroundColor: HexColor(lightPinkTheme),
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
                Icons.event_note,
              ),
              label: 'Visits Timeline',
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

  List<String> _pageTitles = [
    'Guidelines',
    'Visits Timeline',
    'Find In-Network Hospitals',
    'Search Medical Services',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(blueTheme),
        leading: IconButton(
          icon: Icon(IconData(59162, fontFamily: 'MaterialIcons')),
          onPressed: () => setState(() {
            _selectedIndex = 1;
            _pageController.jumpToPage(4);
          }),
        ),
        title: Text(
          _pageTitles[_selectedIndex],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
      ),
      bottomNavigationBar: _bottomNavBar(_selectedIndex),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
