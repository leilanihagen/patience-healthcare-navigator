import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/class/class.dart';
import 'package:hospital_stay_helper/components/list_tile_top3.dart';
import 'package:hospital_stay_helper/components/page_description.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/components/text_icon.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app.dart';

class HospitalSearchPage extends StatefulWidget {
  const HospitalSearchPage({Key? key}) : super(key: key);

  @override
  _CheckHospitalPage createState() => _CheckHospitalPage();
}

class _CheckHospitalPage extends State<HospitalSearchPage>
    with AutomaticKeepAliveClientMixin<HospitalSearchPage> {
  // final GlobalKey<ScaffoldState> _hospitalKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false, ur = false, er = false, isSearching = false;
  late HospitalPage _hospitalPage;
  List<SearchResult> listSearch = [];
  late Box box;
  @override
  void initState() {
    super.initState();
    _hospitalPage = HospitalPage();
    _loadLastSaved();
  }

  openMap(String name, String street) async {
    Uri googleUrl = Uri.https('www.google.com', '/maps/search/',
        {'api': '1', 'query': name + ' ' + street});
    if (await canLaunch(googleUrl.toString())) {
      await launch(googleUrl.toString());
      observer.analytics.logEvent(
          name: 'open_map', parameters: {'name': name, 'street': street});
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  showError(error) {
    print(error.toString());
    rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(error.toString()),
    ));
  }

  showProviderError() {
    rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text("You haven't selected a provider"),
      action: SnackBarAction(
        label: 'SETTINGS',
        onPressed: () => Navigator.pushNamed(context, '/profile'),
      ),
    ));
  }

  _searchHospital(String keyword) async {
    setState(() {
      isSearching = true;
    });
    var tbox = await Hive.openBox('profile');
    String provider = tbox.get('user_provider') ?? '';
    try {
      if (provider.isNotEmpty) {
        bool connection = await InternetConnectionChecker().hasConnection;
        if (connection) {
          http.Response response = await http.post(
            Uri.parse(
                "https://us-west2-patience-tuan-leilani.cloudfunctions.net/search_hospital"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'keyword': keyword, 'provider': provider}),
          );
          if (response.statusCode == 200)
            setState(() {
              Iterable tmp = jsonDecode(response.body)['body'];
              listSearch = List<SearchResult>.from(
                  tmp.map((e) => SearchResult.fromJson(e)));
            });
        } else
          showError("No internet connection");
      } else
        showProviderError();
    } catch (e) {
      showError(e);
    }
    setState(() {
      isSearching = false;
    });
    observer.analytics
        .logEvent(name: 'search_hospital', parameters: {'keyword': keyword});
  }

  _checkHospital() async {
    setState(() {
      isLoading = true;
    });
    var tbox = await Hive.openBox('profile');
    String provider = tbox.get('user_provider') ?? '';
    try {
      if (provider.isNotEmpty) {
        setState(() {
          _hospitalPage.status = "Getting your position";
        });
        Position position = await _determinePosition();
        setState(() {
          _hospitalPage.status = "Checking...";
        });
        bool connection = await InternetConnectionChecker().hasConnection;
        if (connection) {
          http.Response response = await http.post(
            Uri.parse(
                "https://us-west2-patience-tuan-leilani.cloudfunctions.net/check_hospital_test"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'lat': position.latitude,
              'lng': position.longitude,
              'er': er,
              'ur': ur,
              'provider': provider
            }),
          );
          if (response.statusCode == 200) {
            setState(() {
              _hospitalPage = HospitalPage.fromJson(jsonDecode(response.body));
            });
            box.put('checkHospital', response.body);
          }
        } else
          showError("No internet connection");
      } else
        showProviderError();
    } catch (e) {
      showError(e);
    }
    setState(() {
      isLoading = false;
    });
    observer.analytics.logEvent(name: 'check_hospital');
    tbox.close();
  }

  _loadLastSaved() async {
    box = await Hive.openBox('checkHospitalPage');
    String tmp = box.get('checkHospital') ?? '';
    if (tmp.isNotEmpty)
      setState(() {
        _hospitalPage = HospitalPage.fromJson(jsonDecode(tmp));
      });
  }

  showSnackBar(String content) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition(
        timeLimit: Duration(seconds: 10),
        desiredAccuracy: LocationAccuracy.high);
  }

  getColor() {
    if (isLoading) return Colors.grey;
    switch (_hospitalPage.check) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.yellow[800];
      default:
        return Colors.blue;
    }
  }

  getShadow() {
    return Colors.grey.withOpacity(0.2);
  }

  getStatus() {
    if (isLoading)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 10,
              ),
            ),
          ),
          Text(
            _hospitalPage.status!,
            textAlign: TextAlign.center,
            style: Styles.statusButton,
          )
        ],
      );
    switch (_hospitalPage.check) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_rounded, size: 120.w, color: Colors.white),
            Text(
              "Tap to find/verify hospitals",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 32.sp),
            )
          ],
        );
      case 1:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.check_rounded, size: 120.w, color: Colors.white),
          Text(
            _hospitalPage.status!,
            textAlign: TextAlign.center,
            style: Styles.statusButton,
          )
        ]);
      case 2:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.clear_rounded, size: 120.w, color: Colors.white),
          Text(
            _hospitalPage.status!,
            textAlign: TextAlign.center,
            style: Styles.statusButton,
          )
        ]);
      case 3:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.error_rounded, size: 120.w, color: Colors.white),
          Text(
            _hospitalPage.status!,
            textAlign: TextAlign.center,
            style: Styles.statusButton,
          )
        ]);
      default:
        return Icon(Icons.location_on_rounded, size: 120.w);
    }
  }

  getTop3() {
    if (_hospitalPage.top3 == null) return SizedBox.shrink();
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _hospitalPage.top3!
            .map((e) => ListTop(
                  top3: e,
                  callback: () => openMap(e.name!, e.street!),
                ))
            .toList());
  }

  getHeader() {
    return Center(
      child: Column(children: [
        Text(
          _hospitalPage.name ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white),
        ),
        Text(
          _hospitalPage.address ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, backgroundColor: Colors.white),
        ),
      ]),
    );
  }

  getPageIntroduction() {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(7, 8, 7, 3),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   color: Colors.white,
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ERIcon(),
              // const Text("=",
              //     style: TextStyle(
              //         fontWeight: FontWeight.w600, color: Colors.white)),
              const Text("Emergency services",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      // color: Colors.white,
                      fontSize: 15)),
              Switch.adaptive(
                  value: er,
                  onChanged: (value) => setState(() {
                        er = value;
                      }))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(7, 3, 7, 8),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   color: Colors.white,
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const URIcon(),
              // const Text("=",
              //     style: TextStyle(
              //         fontWeight: FontWeight.w600, color: Colors.white)),
              const Text("Urgent care services",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      // color: Colors.white,
                      fontSize: 15)),
              Switch.adaptive(
                  value: ur,
                  onChanged: (value) => setState(() {
                        ur = value;
                      })),
            ],
          ),
        )
      ],
    );
  }

  _showResult() {
    if (listSearch.isNotEmpty)
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(.02.sw),
            child: Text(
              "The below hospitals are in your network:",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.green[800]),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(.004.sw),
          //   child: Text(
          //     "(Tap to go Maps)",
          //     style: TextStyle(
          //         fontWeight: FontWeight.w600,
          //         fontSize: 15,
          //         color: Colors.green[800]),
          //   ),
          // ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: listSearch.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                      title: Text(listSearch[index].name!),
                      subtitle: Text(listSearch[index].address!),
                      trailing: Icon(
                        Icons.check,
                        color: Colors.green[800],
                      ),
                      onTap: () => openMap(
                          listSearch[index].name!, listSearch[index].address!)),
                );
              }),
        ],
      );
  }

  _buildSearchHospital() {
    return FloatingSearchBar(
        hint: 'Search for a specific hospital',
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: Icon(Icons.search),
          ),
          FloatingSearchBarAction.back(),
        ],
        onSubmitted: (String keyword) {
          _searchHospital(keyword);
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              child: isSearching
                  ? Container(
                      width: 20,
                      height: 20,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: LinearProgressIndicator(),
                      ),
                    )
                  : _showResult(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // key: _hospitalKey,
      // backgroundColor: Colors.deepPurple[600],
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Hint text:
                // Find-hospital square:
                SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: .025.sw),
                  child: buildPageDescriptionColor(
                    "How to use Check Hospitals",
                    'With one tap, find nearby in-network hospitals or verify in-network status of a hospital you are at based on your location. Tap the locator at any time to refresh.\n\nTap any hospital search result to open in Maps.',
                    Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => isLoading ? null : _checkHospital(),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(child: child, opacity: animation);
                      },
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                            // margin: EdgeInsets.fromLTRB(0, 0, 0, .025.sw),
                            key: UniqueKey(),
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: getShadow(),
                                //       spreadRadius: 5,
                                //       blurRadius: 7,
                                //       offset: Offset(0, 3)),
                                // ],
                                border: Border.all(width: 0.5),
                                color: getColor(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            width: 375.w,
                            height: 375.w,
                            child: getStatus()),
                      ),
                    ),
                  ),
                ),
                _hospitalPage.name == null || _hospitalPage.name!.isEmpty
                    ? SizedBox.shrink()
                    : getHeader(),
                _hospitalPage.top3 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(4, 26, 4, 10),
                        child: Text(
                          'TOP 3 NEARBY IN-NETWORK HOSPITALS',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                getTop3(),
                getPageIntroduction()
              ],
            ),
          ),
          _buildSearchHospital(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
