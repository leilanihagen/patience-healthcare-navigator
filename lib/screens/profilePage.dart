import 'package:flutter/material.dart';
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
      Text(
        'State of residence (USA):',
        textAlign: TextAlign.left,
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
      DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItem: true,
        items: ['CA', 'WA', 'OR'],
        label: 'State',
        hint: 'Select state of residence',
        onChanged: print,
        selectedItem: 'WA',
      ),
      DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItem: true,
        items: ['Kaiser Permanente', 'Pacific Source'],
        label: 'Insurance Provider',
        hint: 'Select your insurance provider',
        onChanged: print,
        selectedItem: 'Kaiser Permanente',
      ),
      DropdownSearch<String>(
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
      Text('Your plans deductible:'),
      TextField(
        decoration:
            InputDecoration(hintText: 'Enter your plan\'s deductible amount'),
      ),
      Text('Deductible amount paid:'),
      TextField(
        decoration: InputDecoration(
            hintText: 'Enter amount of your deductible you have paid'),
      ),
    ])));
  }
}
