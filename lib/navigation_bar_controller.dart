import 'package:flutter/material.dart';

class AppBottomNavBarController extends StatefulWidget{
  @override
  _AppBottomNavBarControllerState createState =>
  _AppBottomNavBarControllerState();
}

// (Below) re-implementing the state of AppBottomNavBarController
class _AppBottomNavBarControllerState extends State<AppBottomNavBarController>{

  final List<Widget> pages = [
    GuidelinesPage(
      key: PageStorageKey('guidelines')
    ),
    ProfilePage(
      key: PageStorageKey('yourprofile')
    ),
    SearchServicesPage(
      key: PageStorageKey('searchservices')
    ),
    HospitalSearchPage(
      key: PageStorageKey('hospitalsearch')
    ),
  ];

  final PageStorageBucket bucket =  PageStorageBucket();
  int _selectedIndex = 0;

  Widget _bottomNavBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index), // rebuild this widget
    currentIndex: selectedIndex,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(IconData(62421, fontFamily: 'MaterialIcons')),
          label: 'Guidelines',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconData(59162, fontFamily: 'MaterialIcons')),
          label: 'Your Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconData(59828, fontFamily: 'MaterialIcons')),
          label: 'Search Health Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconData(0xe857, fontFamily: 'MaterialIcons')),
          label: 'Find In-Network Hospitals',
        ),
    ]
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex], // listitem
        bucket: bucket,
      ),
    );
  }
}