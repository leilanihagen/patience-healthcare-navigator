import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hospital_stay_helper/app.dart';
import 'package:hospital_stay_helper/components/icons.dart';
import 'package:hospital_stay_helper/components/page_description.dart';
import 'package:hospital_stay_helper/plugins/feedbacks.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/provider/user_provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
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
  // String? userState;
  // String? userProvider;
  // String? userPlan;
  // Not yet used:
  // double? userDeductible;
  // double? userDeductibleReduction;
  TextEditingController? _controller;
  String? _chosenScreen;
  bool _temp = false;
  late Box box;

  openRating() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  submitSuggestion() {
    String value = _controller!.text;
    if (value.isNotEmpty) {
      FeedbackForm feedbackForm = FeedbackForm(_chosenScreen ?? "", value);
      FormController formController = FormController();
      formController.submitForm(feedbackForm, (String response) {
        if (response == FormController.STATUS_SUCCESS) {
          _controller!.clear();
          rootScaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
              content:
                  Text("Thank you for your suggestion! We have recieved it.")));
          setState(() {
            _temp = false;
          });
        } else {
          rootScaffoldMessengerKey.currentState!
              .showSnackBar(const SnackBar(content: Text("Error Occured")));
        }
      });
    }
  }

  @override
  initState() {
    super.initState();
    // _loadSave();
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
        child: Consumer<UserProvider>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                leading: Hero(
                  tag: 'settings_icon',
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      iconSize: 35,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                title: Hero(
                  tag: 'app_bar_title',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'User Settings',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                        Theme.of(context).scaffoldBackgroundColor,
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
                        elevation: 5,
                        // color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Column(
                              children: [
                                Padding(
                                  padding: Styles.dropdownPadding,
                                  child: DropdownSearch<String>(
                                    popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                    ),
                                    items: const [
                                      'CA',
                                      'WA',
                                      'OR',
                                      'DC',
                                      'VA',
                                      'MD',
                                      'GA'
                                    ],
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          label: Text('State of residence'),
                                          hintText:
                                              'Select state of residence'),
                                    ),
                                    onChanged: (String? s) =>
                                        model.changeState(s),
                                    selectedItem: model.state,
                                  ),
                                ),
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
                                  padding: Styles.dropdownPadding,
                                  child: DropdownSearch<String>(
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                    ),
                                    items: const [
                                      'Kaiser Permanente',
                                      'Pacific Source'
                                    ],
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          label: Text('Insurance Provider'),
                                          hintText:
                                              'Select your insurance provider'),
                                    ),
                                    onChanged: (String? s) =>
                                        model.changeInsuranceProvider(s),
                                    selectedItem: model.insuranceProvider,
                                  ),
                                ),
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
                            )),
                      ),
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                TextField(
                                  onTap: () => setState(() {
                                    _temp = true;
                                  }),
                                  controller: _controller,
                                  minLines: 3,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        CustomIcon.lightbulb,
                                        color:
                                            _temp ? Colors.yellow : Colors.grey,
                                      ),
                                      // labelStyle: TextStyle(color: Colors.black),
                                      // border: OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Styles.blueTheme),
                                      ),
                                      labelText: 'Feedback & Suggestion',
                                      hintText: 'Your suggestion help us',
                                      helperText:
                                          'Type your feedback & suggestion here'),
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
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                        .toList(),
                                    hint: const Text(
                                      "Choose a screen for feedback",
                                      style: TextStyle(
                                          // color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () => openRating(),
                                        child: const Text("Rate us")),
                                    TextButton(
                                        onPressed: () => submitSuggestion(),
                                        child: const Text("Submit")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            );
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
