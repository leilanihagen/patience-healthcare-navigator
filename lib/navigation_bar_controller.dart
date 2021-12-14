import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/icons.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/provider/navigation_provider.dart';
import 'package:hospital_stay_helper/screens/profile_page.dart';
import 'package:provider/provider.dart';

class AppBottomNavBarController extends StatefulWidget {
  final int currentIndex;

  const AppBottomNavBarController({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  _AppBottomNavBarControllerState createState() =>
      _AppBottomNavBarControllerState();
}

// (Below) re-implementing the state of AppBottomNavBarController
class _AppBottomNavBarControllerState extends State<AppBottomNavBarController> {
  @override
  void initState() {
    super.initState();
    observer.analytics.logAppOpen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _bottomNavBar(int selectedIndex) => BottomNavigationBar(
          onTap: (int index) {
            Provider.of<MainNavigationProvider>(context, listen: false)
                .openPage(index, context);
            // openPage(index);
          },
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.patienceIcon),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_answer_outlined,
              ),
              label: 'Guidelines',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event_note_outlined,
              ),
              label: 'Visits',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.map),
              icon: Icon(
                Icons.location_on_outlined,
              ),
              label: 'Find Hospitals',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Services',
            // ),
          ]);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavigationProvider>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Badge(
                position: BadgePosition.topStart(),
                showBadge: model.haveOpenProfile,
                badgeContent: const Text(
                  "!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Hero(
                  tag: 'settings_icon',
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      iconSize: 35,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ProfilePage())),
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                ),
              ),
            ],
            title: Hero(
              tag: 'app_bar_title',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  model.title,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
            ),
          ),
          bottomNavigationBar: _bottomNavBar(model.pageIndex),
          body: PageView(
            controller: model.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: model.pages,
            // onPageChanged: (index) => model.openPage(index, context),
          ),
        );
      },
    );
  }
}
