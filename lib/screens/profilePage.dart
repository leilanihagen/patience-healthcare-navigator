import 'package:flutter/material.dart';
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Padding(
        child: Text(
          'Your Information', // or 'Your Profile'
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
          child: Text(
            'State of residence (USA):',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        ),
      ),
      //   DropdownButton<String>(
      //     value: dropdownVal,
      //     icon: Icon(Icons.arrow_downward),
      //     iconSize: 13,
      //     style: TextStyle(color: Colors.blue),
      //     items: <String>['CA', 'WA', 'OR']
      //     .map<DropdownMenuItem<String>>((String val){
      //       return DropdownMenuItem<String>(
      //         value: val,
      //         child: Text(val),
      //       );
      //     }).toList(),
      // ])
      Padding(
          child: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            items: ['CA', 'WA', 'OR'],
            label: 'State',
            hint: 'Select state of residence',
            onChanged: print,
            selectedItem: 'WA',
          ),
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8)),
      SizedBox(
        width: double.infinity,
        child: Padding(
          child: Text(
            'Insurance provider:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        ),
      ),
      Padding(
          child: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            items: ['Kaiser Permanente', 'Pacific Source'],
            label: 'Insurance Provider',
            hint: 'Select your insurance provider',
            onChanged: print,
            selectedItem: 'Kaiser Permanente',
          ),
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8)),
      SizedBox(
        width: double.infinity,
        child: Padding(
          child: Text(
            'Insurance plan:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        ),
      ),
      Padding(
          child: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            items: [
              'Gold 2000',
              'Silver 3500',
              'Silver 5000',
              'Bronze 7000',
              'Deductible Bronze',
              'HSA Bronze'
            ],
            label: 'Insurance Plan',
            hint: 'Select your insurance plan',
            onChanged: print,
            selectedItem: 'Gold 2000',
          ),
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8)),
      SizedBox(
        width: double.infinity,
        child: Padding(
          child: Text(
            'Your plans deductible:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        ),
      ),
      Padding(
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Enter your plan\'s deductible amount'),
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 8)),
      SizedBox(
        width: double.infinity,
        child: Padding(
          child: Text(
            'Amount of deductible you have paid so far:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15),
          ),
          padding: EdgeInsets.fromLTRB(20, 8, 20, 5),
        ),
      ),
      Padding(
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Enter amount of your deductible you have paid'),
          ),
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
    ])));
  }
}
