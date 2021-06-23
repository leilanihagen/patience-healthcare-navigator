import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/config/styles.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  // Dropdown default values:
  // String userState = 'CA';
  // String userProvider = 'Kaiser Permanente';
  // String userPlan = 'Gold 2000'; // this is a Kaiser plan^
  String userState;
  String userProvider;
  String userPlan;
  // Not yet used:
  double userDeductible;
  double userDeductibleReduction;

  _loadSave() async {
    userState = await MySharedPreferences.instance.getStringValue('user_state');
    userProvider =
        await MySharedPreferences.instance.getStringValue('user_provider');
    userPlan = await MySharedPreferences.instance.getStringValue('user_plan');
    setState(() {});
    // Implement later:
    // userDeductible =
    //     await MySharedPreferences.instance.getStringValue('user_deductible');
    // userDeductibleReduction = await MySharedPreferences.instance
    //     .getStringValue('user_deductible_reduction');
  }

  @override
  initState() {
    super.initState();
    _loadSave();
    MySharedPreferences.instance.setBoolValue('selectProfile', true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // backgroundColor: Colors.deepPurple[600],
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(padding: EdgeInsets.all(20)),
            // Text(
            //   "Your Information",
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //       fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
            // ),
            Padding(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Your setting is used to provide you with personalized tips and info to navigate your hospital stay, like finding in-network hospitals on the Find In-Network Hospital page.",
                            textAlign: TextAlign.left,
                            style: Styles.instruction,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
                ),
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12)),
            // SizedBox(
            //   width: double.infinity,
            //   child: Padding(
            //     child: Text(
            //       'State of residence (USA):',
            //       textAlign: TextAlign.left,
            //       style: TextStyle(fontSize: 15),
            //     ),
            //     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            //   ),
            // ),
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
            Card(
              color: Colors.white,
              child: Padding(
                  child: Column(
                    children: [
                      Padding(
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItem: true,
                            items: ['CA', 'WA', 'OR'],
                            label: 'State of residence',
                            hint: 'Select state of residence',
                            onChanged: (String s) => {
                              // TO DO: Create an initialization where the default provider is
                              // saved if the user never changes this dropdown
                              MySharedPreferences.instance
                                  .setStringValue('user_state', s),
                            },
                            selectedItem: userState,
                          ),
                          padding: Styles.dropdownPadding),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Padding(
                      //     child: Text(
                      //       'Insurance provider:',
                      //       textAlign: TextAlign.left,
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      //   ),
                      // ),
                      Padding(
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItem: true,
                            items: ['Kaiser Permanente', 'Pacific Source'],
                            label: 'Insurance Provider',
                            hint: 'Select your insurance provider',
                            onChanged: (String s) {
                              // TO DO: Create an initialization where the default provider is
                              // saved if the user never changes this dropdown
                              MySharedPreferences.instance
                                  .setStringValue('user_provider', s);
                            },
                            selectedItem: userProvider,
                          ),
                          padding: Styles.dropdownPadding),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Padding(
                      //     child: Text(
                      //       'Insurance plan:',
                      //       textAlign: TextAlign.left,
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      //   ),
                      // ),
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
                            onChanged: (String s) => {
                              // TO DO: Create an initialization where the default provider is
                              // saved if the user never changes this dropdown
                              MySharedPreferences.instance
                                  .setStringValue('user_plan', s),
                            },
                            selectedItem: userPlan,
                          ),
                          padding: Styles.dropdownPadding),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Padding(
                      //     child: Text(
                      //       'Your plans deductible:',
                      //       textAlign: TextAlign.left,
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      //   ),
                      // ),
                      // ******REMOVE if adding text labels above each item again:
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      ),
                      // *********************************************************
                      Padding(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Your plan\'s deductible amount'),
                            keyboardType: TextInputType.number,
                            // onChanged: (String s) => {
                            //       MySharedPreferences.instance
                            //           .setStringValue('user_deductible', s),
                            //     }
                          ),
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 8)),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Padding(
                      //     child: Text(
                      //       'Amount of deductible you have paid so far:',
                      //       textAlign: TextAlign.left,
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     padding: EdgeInsets.fromLTRB(20, 8, 20, 5),
                      //   ),
                      // ),
                      Padding(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText:
                                    'Amount of your deductible you have paid'),
                            keyboardType: TextInputType.number,
                            // onChanged: (String s) => {
                            //   MySharedPreferences.instance
                            //       .setStringValue('user_deductible_reduction', s),
                            // },
                          ),
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
            )
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
