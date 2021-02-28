import "package:flutter/material.dart";

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Stay Helper - Home"),
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
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
      ]),
    );
  }
}
