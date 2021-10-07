import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:hospital_stay_helper/app.dart';
import 'package:hospital_stay_helper/components/icons.dart';
import 'package:hospital_stay_helper/components/pageDescription.dart';
import 'package:hospital_stay_helper/plugins/feedbacks.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hive/hive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:in_app_review/in_app_review.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

List<String> listScreen = [
  "Dashboard",
  "Guidelines",
  "Visit Timeline",
  "Find In-Network Hospitals",
  "Search Medical Services"
];

class _ProfilePage extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  // Dropdown default values:
  // String userState = 'CA';
  // String userProvider = 'Kaiser Permanente';
  // String userPlan = 'Gold 2000'; // this is a Kaiser plan^
  String? userState;
  String? userProvider;
  String? userPlan;
  // Not yet used:
  // double? userDeductible;
  // double? userDeductibleReduction;
  TextEditingController? _controller;
  String? _chosenScreen;
  late Box box;
  _loadSave() async {
    // String tempUserState =
    //     await MySharedPreferences.instance.getStringValue('user_state');
    // String tempUserProvider =
    //     await MySharedPreferences.instance.getStringValue('user_provider');
    // String tempUserPlan =
    //     await MySharedPreferences.instance.getStringValue('user_plan');
    box = await Hive.openBox('profile');
    String? tempUserState = box.get('user_state');
    String? tempUserProvider = box.get('user_provider');
    String? tempUserPlan = box.get('user_plan');
    setState(() {
      userState = tempUserState;
      userProvider = tempUserProvider;
      userPlan = tempUserPlan;
    });
    // Implement later:
    // userDeductible =
    //     await MySharedPreferences.instance.getStringValue('user_deductible');
    // userDeductibleReduction = await MySharedPreferences.instance
    //     .getStringValue('user_deductible_reduction');
  }

  _loadProviderInfo(String? provider) async {
    final String temp =
        await rootBundle.loadString('assets/data/provider.json');
    final data = await jsonDecode(temp);
    box.put('provider_phone', data[provider]['phone']);
  }

  _check() async {
    var tempBox = await Hive.openBox('mainController');
    tempBox.put('selectProfile', true);
    tempBox.close();
  }

  openRating() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  submitSuggestion() {
    String value = _controller!.text;
    if (value.isNotEmpty) {
      FeedbackForm feedbackForm = FeedbackForm(_chosenScreen!, value);
      FormController formController = FormController();
      formController.submitForm(feedbackForm, (String response) {
        if (response == FormController.STATUS_SUCCESS) {
          _controller!.clear();
          rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
              content:
                  Text("Thank you for your suggestion! We have recieved it.")));
        } else
          rootScaffoldMessengerKey.currentState!
              .showSnackBar(SnackBar(content: Text("Error Occured")));
      });
    }
  }

  @override
  initState() {
    super.initState();
    _loadSave();
    _check();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.deepPurple[600],
        appBar: AppBar(
          backgroundColor: Styles.blueTheme,
          leading: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Hero(
                tag: 'settings_icon',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 165.w,
                    height: 165.w,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 75.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Hero(
            tag: 'app_bar_title',
            child: Container(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  'User Settings',
                  style: Styles.appBar,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
            // Text(
            //   "Your Information",
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //       fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
            // ),
            buildPageDescriptionColor(
              "Welcome to Your Settings",
              "Your settings are used to provide you with personalized tips and info to navigate your healthcare, such as finding in-network hospitals on the Find In-Network Hospital page.\n\n*NOTE: We are actively working to add more states and insurance providers to the app!",
              Colors.white,
            ),
            // Padding(
            //     child: Card(
            //       color: Colors.white,
            //       child: Padding(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Text(
            //                 ,
            //                 textAlign: TextAlign.left,
            //                 style: Styles.instruction,
            //               ),
            //             ],
            //           ),
            //           padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
            //     ),
            //     padding: EdgeInsets.fromLTRB(0, 0, 0, 12)),

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
                            items: ['CA', 'WA', 'OR', 'DC', 'VA', 'MD', 'GA'],
                            label: 'State of residence',
                            hint: 'Select state of residence',
                            onChanged: (String? s) {
                              observer.analytics.logEvent(
                                  name: 'set_state', parameters: {'state': s});
                              // TO DO: Create an initialization where the default provider is
                              // saved if the user never changes this dropdown
                              // MySharedPreferences.instance
                              //     .setStringValue('user_state', s);
                              box.put('user_state', s);
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
                            onChanged: (String? s) {
                              observer.analytics.logEvent(
                                  name: 'set_provider',
                                  parameters: {'provider': s});
                              // TO DO: Create an initialization where the default provider is
                              // saved if the user never changes this dropdown
                              // MySharedPreferences.instance
                              //     .setStringValue('user_provider', s);
                              box.put('user_provider', s);
                              _loadProviderInfo(s);
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

                      // CURRENT version (temporarily disabled):
                      // Padding(
                      //     child: DropdownSearch<String>(
                      //       mode: Mode.MENU,
                      //       showSelectedItem: true,
                      //       items: [
                      //         'Gold 2000',
                      //         'Silver 3500',
                      //         'Silver 5000',
                      //         'Bronze 7000',
                      //         'Deductible Bronze',
                      //         'HSA Bronze'
                      //       ],
                      //       label: 'Insurance Plan',
                      //       hint: 'Select your insurance plan',
                      //       onChanged: (String s) => {
                      //         // TO DO: Create an initialization where the default provider is
                      //         // saved if the user never changes this dropdown
                      //         MySharedPreferences.instance
                      //             .setStringValue('user_plan', s),
                      //       },
                      //       selectedItem: userPlan,
                      //     ),
                      //     padding: Styles.dropdownPadding),
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
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      // ),
                      // *********************************************************
                      // CURRENT version (temporarily disabled):
                      // Padding(
                      //     child: TextField(
                      //       decoration: InputDecoration(
                      //           hintText: 'Your plan\'s deductible amount'),
                      //       keyboardType: TextInputType.number,
                      //       // onChanged: (String s) => {
                      //       //       MySharedPreferences.instance
                      //       //           .setStringValue('user_deductible', s),
                      //       //     }
                      //     ),
                      //     padding: EdgeInsets.fromLTRB(20, 5, 20, 8)),

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

                      // CURRENT version (temporarily disabled):
                      // Padding(
                      //     child: TextField(
                      //       decoration: InputDecoration(
                      //           hintText:
                      //               'Amount of your deductible you have paid'),
                      //       keyboardType: TextInputType.number,
                      //       // onChanged: (String s) => {
                      //       //   MySharedPreferences.instance
                      //       //       .setStringValue('user_deductible_reduction', s),
                      //       // },
                      //     ),
                      //     padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: _controller,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                          icon: Icon(
                            CustomIcon.lightbulb,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          // border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Styles.blueTheme),
                          ),
                          labelText: 'Feedback & Suggestion',
                          hintText: 'Your suggestion help us',
                          helperText: 'Type your feedback & suggestion here'),
                      maxLength: 300,
                    ),
                    Center(
                      child: DropdownButton<String>(
                        value: _chosenScreen,
                        onChanged: (String? value) {
                          setState(() {
                            _chosenScreen = value;
                          });
                        },
                        items: listScreen
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    ))
                            .toList(),
                        hint: Text(
                          "Choose a screen for feedback",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => openRating(),
                            child: Text("Rate us")),
                        TextButton(
                            onPressed: () => submitSuggestion(),
                            child: Text("Submit")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
