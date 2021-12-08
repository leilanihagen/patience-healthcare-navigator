import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/screens/check_hospital.dart';
import 'package:hospital_stay_helper/screens/dashboard.dart';
import 'package:hospital_stay_helper/screens/guidelines_page.dart';
import 'package:hospital_stay_helper/screens/visits_timeline_page.dart';

final List<String> listTitle = [
  'Dashboard',
  'Guidelines',
  'Visits Timeline',
  'Find In-Network Hospitals',
];

class MainNavigationProvider extends ChangeNotifier {
  late List<Widget> _pages;
  late int _pageIndex;
  late String _title;
  late Box box;
  late bool _haveOpenProfile;
  PageController? _pageController;
  int get pageIndex => _pageIndex;
  bool get haveOpenProfile => _haveOpenProfile;
  String get title => _title;
  PageController? get pageController => _pageController;
  List<Widget> get pages => _pages;
  MainNavigationProvider() {
    _pages = [
      DashboardPage(),
      RootCategoriesPage(),
      VisitsTimelinePage(key: PageStorageKey('visitstimeline')),
      HospitalSearchPage(
        key: PageStorageKey('hospitalsearch'),
        openPage: openPage,
      ),
    ];
    _pageIndex = 0;
    _title = listTitle[_pageIndex];
    _pageController = PageController(initialPage: _pageIndex);
    box = Hive.box('mainController');
    _haveOpenProfile = box.get('selecteProfile') ?? false;
  }
  void openPage(int index, BuildContext context) {
    if (0 <= index && index < pages.length) {
      _pageController!.animateToPage(
        index,
        duration: Duration(milliseconds: 800),
        // Stick with Curves.easeIn or similar to avoid errors (https://github.com/flutter/flutter/issues/47730)
        curve: Curves.ease,
      );
      _pageIndex = index;
      _title = listTitle[index];
      notifyListeners();
    }
    switch (index) {
      case 0:
        observer.analytics.logEvent(name: 'open_dashboard');
        break;
      case 1:
        observer.analytics.logEvent(name: 'open_guildelines');
        break;
      case 2:
        observer.analytics.logEvent(name: 'open_visittimeline');
        break;
      case 3:
        observer.analytics.logEvent(name: 'open_checkhospital');
        break;
      case 4:
        observer.analytics.logEvent(name: 'open_searchpage');
        break;
      case 5:
        observer.analytics.logEvent(name: 'open_profilepage');
        Navigator.pushNamed(context, '/profile');
        break;
      default:
    }
  }
}
