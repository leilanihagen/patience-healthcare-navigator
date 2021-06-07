// import 'package:csv/csv.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:hospital_stay_helper/class/class.dart';
// import 'package:hospital_stay_helper/class/sharePref.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';
// import 'package:reorderables/reorderables.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../app.dart';
// import '../class/class.dart';

// class SearchPage extends StatefulWidget {
//   SearchPage({Key key}) : super(key: key);
//   @override
//   _SearchPage createState() => _SearchPage();
// }

// class _SearchPage extends State<SearchPage>
//     with AutomaticKeepAliveClientMixin<SearchPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final FloatingSearchBarController searchController =
//       FloatingSearchBarController();
//   ProceduresController controller;
//   Map usStates;
//   List<Search> searchList;
//   List<Search> items = [];

//   String purpleTheme = "#AB92F4";
//   String lightPinkTheme = "#FDEBF1";
//   String darkPinkTheme = "#ED558C";
//   String blueTheme = "#54D0EB";
//   String darkGreenTheme = "#758C20";
//   String lightGreenTheme = "#A1BF36";

//   @override
//   void initState() {
//     super.initState();
//     _loadSaved();
//     _loadProvider();
//     _loadSearch();
//   }

//   Future<void> _loadProvider() async {
//     String provider =
//         await MySharedPreferences.instance.getStringValue("user_provider");
//     if (provider != null) setState(() => controller.provider = provider);
//   }

//   Future<void> _loadSaved() async {
//     String tmp =
//         await MySharedPreferences.instance.getStringValue('searchPage');
//     if (tmp.isNotEmpty)
//       controller = ProceduresController.fromJson(jsonDecode(tmp));
//     else
//       controller = ProceduresController();
//   }

//   Future<void> _loadSearch() async {
//     final data = await rootBundle.loadString('assets/data/proceduresList.csv');
//     List<List<dynamic>> temp = CsvToListConverter().convert(data);
//     searchList = List<Search>.from(temp.map((e) => Search.fromString(e)));
//     items.addAll(searchList);
//   }

//   Future _refresh() async {
//     await _loadProvider();
//   }

//   Future search(Search s) async {
//     if (controller.checkExist(s)) return;
//     Map<String, dynamic> tmp = {
//       "name": "${s.name}",
//       "lower_cpt": s.lowerCpt,
//       "upper_cpt": s.upperCpt,
//     };
//     http.Response response = await http.post(
//         Uri.https('us-west2-dscapp-301108.cloudfunctions.net', '/search'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({'lower_cpt': s.lowerCpt}));
//     if (response.statusCode == 200) {
//       tmp.addAll(jsonDecode(response.body));
//       Procedure p = Procedure.fromJson(tmp);
//       setState(() {
//         controller.add(p);
//         controller.update();
//       });
//       saveState();
//     }
//   }

//   void saveState() async {
//     MySharedPreferences.instance
//         .setStringValue('searchPage', json.encode(controller));
//   }

//   void deleteItem(index) {
//     setState(() {
//       controller.procedures.removeAt(index);
//       controller.update();
//     });
//     saveState();
//   }

//   void undoDeletion(index, item) {
//     setState(() {
//       controller.procedures.insert(index, item);
//       controller.update();
//     });
//     saveState();
//   }

//   void filterSearchResults(String query) {
//     List<Search> dummySearchList = [];
//     dummySearchList.addAll(searchList);
//     if (query.isNotEmpty) {
//       List<Search> dummyListData = [];
//       dummySearchList.forEach((item) {
//         if (item.name.toLowerCase().contains(query.toLowerCase()))
//           dummyListData.add(item);
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else
//       setState(() {
//         items.clear();
//         items.addAll(searchList);
//       });
//   }

//   List<Widget> _buildList() {
//     deleteSearch(index) {
//       Procedure item = controller.procedures.elementAt(index);
//       deleteItem(index);
//       rootScaffoldMessengerKey.currentState.showSnackBar(SnackBar(
//         content: Text('${item.name} is deleted'),
//         action: SnackBarAction(
//           label: 'Undo',
//           onPressed: () {
//             undoDeletion(index, item);
//           },
//         ),
//       ));
//     }

//     return List<Widget>.generate(
//         controller.procedures.length,
//         (int index) => Dismissible(
//             key: PageStorageKey<String>(controller.procedures[index].name),
//             background: stackBehindDismiss(),
//             onDismissed: (direction) => deleteSearch(index),
//             child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Container(
//                       color: Colors.white,
//                       child: ExpansionTile(
//                         expandedCrossAxisAlignment: CrossAxisAlignment.start,
//                         subtitle: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                       decoration: TextDecoration.underline),
//                                   children: [
//                                     TextSpan(text: 'CPT code: '),
//                                     TextSpan(
//                                         text:
//                                             "${controller.procedures[index].lowerCpt} - ${controller.procedures[index].upperCpt}",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold))
//                                   ]),
//                             ),
//                             IconButton(
//                                 icon: Icon(Icons.delete),
//                                 onPressed: () => deleteSearch(index))
//                           ],
//                         ),
//                         title: Text("${controller.procedures[index].name}"),
//                         childrenPadding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                         expandedAlignment:
//                             controller.procedures[index].lowerPrice == null
//                                 ? Alignment.center
//                                 : Alignment.bottomLeft,
//                         maintainState: false,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                                 children: [
//                                   TextSpan(text: 'Price range: '),
//                                   TextSpan(
//                                       text:
//                                           "\$${controller.procedures[index].lowerPrice} - \$${controller.procedures[index].upperPrice}",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold))
//                                 ]),
//                           ),
//                           Divider(),
//                           RichText(
//                             text: TextSpan(
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                       text: '• Section: ',
//                                       style: TextStyle(color: Colors.green)),
//                                   TextSpan(
//                                       text:
//                                           " ${controller.procedures[index].section}",
//                                       style: TextStyle(
//                                           fontStyle: FontStyle.italic))
//                                 ]),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                       text: '• Group: ',
//                                       style:
//                                           TextStyle(color: Colors.redAccent)),
//                                   TextSpan(
//                                       text:
//                                           " ${controller.procedures[index].group}",
//                                       style: TextStyle(
//                                           fontStyle: FontStyle.italic))
//                                 ]),
//                           ),
//                           Divider(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               RichText(
//                                 text: TextSpan(
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.blue,
//                                         decoration: TextDecoration.underline),
//                                     children: [
//                                       TextSpan(
//                                         text: "CPT code detail",
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () async {
//                                             var url = controller
//                                                 .procedures[index].codeUrl;
//                                             if (await canLaunch(url)) {
//                                               await launch(url);
//                                             } else
//                                               throw 'Could not launch $url';
//                                           },
//                                       )
//                                     ]),
//                               ),
//                               RichText(
//                                 text: TextSpan(
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.blue,
//                                         decoration: TextDecoration.underline),
//                                     children: [
//                                       TextSpan(
//                                         text: "Procedure price detail",
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () async {
//                                             var url = controller
//                                                 .procedures[index].priceUrl;
//                                             if (await canLaunch(url)) {
//                                               await launch(url);
//                                             } else
//                                               throw 'Could not launch $url';
//                                           },
//                                       )
//                                     ]),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     )))));
//   }

//   Widget _buildSummary() {
//     if (controller.procedures.isNotEmpty)
//       return DraggableScrollableSheet(
//         initialChildSize: 0.1,
//         minChildSize: 0.03,
//         maxChildSize: 0.9,
//         builder: (context, scrollController) {
//           return Stack(
//             clipBehavior: Clip.none,
//             children: <Widget>[
//               Container(
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(-1, -1), // changes position of shadow
//                         ),
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30))),
//                   child: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.topCenter,
//                             child: Icon(
//                               Icons.drag_handle_rounded,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             "Summary",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           ),
//                           Divider(),
//                           ListTile(
//                               title: Text(
//                                 "Provider: ${controller.provider ?? "Empty provider"}",
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.bold),
//                               ),
//                               trailing: IconButton(
//                                 iconSize: 30,
//                                 color: Colors.blue,
//                                 tooltip: "Call your provider",
//                                 icon: Icon(
//                                   Icons.phone,
//                                 ),
//                                 onPressed: () => print("hello"),
//                               )),
//                           Divider(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text("Price range:"),
//                               Text(
//                                 "\$ ${controller.totalLowerPrice}",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               Text(" to "),
//                               Text(
//                                 "\$ ${controller.totalUpperPrice}",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           Divider(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 "• ${controller.procedures.length} items",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               Text("• ${controller.numSection} Section(s)",
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.green)),
//                               Text("• ${controller.numGroup} Group(s)",
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.redAccent))
//                             ],
//                           ),
//                           Container(
//                             height: 800,
//                           )
//                         ],
//                       ))),
//             ],
//           );
//         },
//       );
//     else
//       return Container();
//   }

//   Widget _buildSearchBar() {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;

//     return FloatingSearchBar(
//       controller: searchController,
//       hint: 'Search...',
//       scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//       transitionCurve: Curves.easeInOut,
//       physics: const BouncingScrollPhysics(),
//       axisAlignment: isPortrait ? 0.0 : -1.0,
//       openAxisAlignment: 0.0,
//       width: 500,
//       // debounceDelay: const Duration(milliseconds: 500),
//       onQueryChanged: (query) {
//         filterSearchResults(query);
//       },
//       transition: CircularFloatingSearchBarTransition(),
//       actions: [
//         FloatingSearchBarAction.back(),
//         FloatingSearchBarAction(
//           showIfOpened: false,
//           child: CircularButton(
//             icon: const Icon(Icons.search_rounded),
//             onPressed: () => searchController.open(),
//           ),
//         ),
//         FloatingSearchBarAction.searchToClear(
//           showIfClosed: false,
//         ),
//       ],
//       builder: (context, transition) {
//         return ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Material(
//               color: Colors.white,
//               elevation: 4.0,
//               child: items.isEmpty
//                   ? ListTile(title: Text("Can't find that"))
//                   : ListView.separated(
//                       physics: NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.all(10.h),
//                       shrinkWrap: true,
//                       itemCount: items.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           height: 200.h,
//                           child: ListTile(
//                             selectedTileColor: Colors.grey,
//                             trailing: Icon(
//                               Icons.add_circle_outline_rounded,
//                               color: Colors.pinkAccent,
//                             ),
//                             title: Text(items[index].name),
//                             onTap: () {
//                               search(items[index]);
//                               rootScaffoldMessengerKey.currentState
//                                   .showSnackBar(SnackBar(
//                                 content: Text(
//                                     'Adding ${items[index].name} to the list'),
//                               ));
//                               searchController.clear();
//                             },
//                           ),
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) =>
//                           Divider(),
//                     ),
//             ));
//       },
//     );
//   }

//   Widget _buildrows() {
//     return SafeArea(
//         child: FloatingSearchBarScrollNotifier(
//             child: RefreshIndicator(
//       displacement: 55,
//       onRefresh: () => _refresh(),
//       child: CustomScrollView(
//         physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics()),
//         slivers: [
//           SliverAppBar(
//             floating: true,
//             automaticallyImplyLeading: false,
//             backgroundColor: HexColor(darkPinkTheme),
//             expandedHeight: 60,
//           ),
//           ReorderableSliverList(
//             delegate: ReorderableSliverChildListDelegate(_buildList()),
//             onReorder: (oldIndex, newIndex) {
//               Procedure item = controller.procedures.removeAt(oldIndex);
//               controller.procedures.insert(newIndex, item);
//             },
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               height: 25,
//             ),
//           )
//         ],
//       ),
//     )));
//   }

//   Widget stackBehindDismiss() {
//     return Container(
//       alignment: Alignment.centerRight,
//       padding: EdgeInsets.only(right: 20.0),
//       color: Colors.redAccent,
//       child: Icon(
//         Icons.delete,
//         color: Colors.white,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       resizeToAvoidBottomInset: false,
//       // backgroundColor: Colors.deepPurple[600],
//       body: controller == null
//           ? Container()
//           : Stack(
//               fit: StackFit.loose,
//               alignment: Alignment.center,
//               children: [_buildrows(), _buildSearchBar(), _buildSummary()],
//             ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          MaterialBanner(
            leading: const CircleAvatar(
              child: const Icon(
                Icons.settings_applications_sharp,
                color: Colors.white,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello from the dev team',
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: const Text(
                        '''Thank you for your interest in our app Patient- A Health Care Navigator. This feature haven't finished yet, as the devs team is constantly working in it. We will release in the near future. Once again, our deep appreciate and be Patience with us.'''),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'DISMISS',
                ),
                onPressed: null,
              ),
            ],
          ),
          const Spacer(),
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
