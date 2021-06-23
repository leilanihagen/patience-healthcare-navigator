import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hospital_stay_helper/class/class.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:hospital_stay_helper/widgets/textIcon.dart';
import 'package:http/http.dart' as http;
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app.dart';

class HospitalSearchPage extends StatefulWidget {
  HospitalSearchPage({Key key}) : super(key: key);

  @override
  _CheckHospitalPage createState() => _CheckHospitalPage();
}

showError(error) {
  rootScaffoldMessengerKey.currentState.showSnackBar(SnackBar(
    content: Text(error),
  ));
}

class _CheckHospitalPage extends State<HospitalSearchPage>
    with AutomaticKeepAliveClientMixin<HospitalSearchPage> {
  final GlobalKey<ScaffoldState> _hospitalKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false, ur = true, er = true, isSearching = false;
  HospitalPage _hospitalPage;
  List<String> listSearch = [];
  openMap(String name, String street) async {
    Uri googleUrl = Uri.https('www.google.com', '/maps/search/',
        {'api': '1', 'query': name + ' ' + street});
    if (await canLaunch(googleUrl.toString())) {
      await launch(googleUrl.toString());
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  _searchHospital(String keyword) async {
    setState(() {
      isSearching = true;
    });
    String provider =
        await MySharedPreferences.instance.getStringValue('user_provider');
    try {
      if (provider.isNotEmpty) {
        http.Response response = await http.post(
          Uri.parse(
              "https://us-west2-dscapp-301108.cloudfunctions.net/hospital_search"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'keyword': keyword, 'provider': provider}),
        );
        if (response.statusCode == 200)
          setState(() {
            Iterable tmp = jsonDecode(response.body)['body'];
            listSearch = List<String>.from(tmp);
          });
      } else
        showError("You haven't selected a provider");
    } catch (e) {
      showError(e);
    }
    setState(() {
      isSearching = false;
    });
    // if (provider.isNotEmpty)
    //   http
    //       .post(
    //     Uri.parse(
    //         "https://us-west2-dscapp-301108.cloudfunctions.net/hospital_search"),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode({'keyword': keyword, 'provider': provider}),
    //   )
    //       .then((response) {
    //     print(response.body);
    //     if (response.statusCode == 200)
    //       setState(() {
    //         Iterable tmp = jsonDecode(response.body)['body'];
    //         listSearch = List<String>.from(tmp);
    //       });
    //   }).catchError((onError) => showError(onError));
    // else
    //   showError("You haven't selected a provider");
  }

  submit() async {
    setState(() {
      isLoading = true;
    });
    String provider =
        await MySharedPreferences.instance.getStringValue('user_provider');

    if (provider.isNotEmpty)
      await _determinePosition()
          .then((position) => http
                  .post(
                Uri.parse(
                    "https://us-west2-dscapp-301108.cloudfunctions.net/hospital_check"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                  'lat': position.latitude,
                  'lng': position.longitude,
                  'provider': provider
                }),
              )
                  .then((response) {
                if (response.statusCode == 200) {
                  setState(() {
                    _hospitalPage =
                        HospitalPage.fromJson(jsonDecode(response.body));
                  });
                  MySharedPreferences.instance
                      .setStringValue('checkHospital', response.body);
                } else {
                  showError("Error in request");
                }
              }).catchError((onError) => showError(onError)))
          .catchError((onError) => showError(onError));
    else
      showError("You haven't selected a provider");
    setState(() {
      isLoading = false;
    });
  }

  _loadLastSaved() async {
    String tmp =
        await MySharedPreferences.instance.getStringValue('checkHospital');
    if (tmp.isNotEmpty)
      setState(() {
        _hospitalPage = HospitalPage.fromJson(jsonDecode(tmp));
      });
  }

  showSnackBar(String content) {
    rootScaffoldMessengerKey.currentState.showSnackBar(SnackBar(
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
        timeLimit: Duration(seconds: 5),
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    super.initState();
    _hospitalPage = HospitalPage();
    _loadLastSaved();
  }

  getColor() {
    if (isLoading) return Colors.grey;
    switch (_hospitalPage.check) {
      case 0:
        return Colors.blue;
        break;
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.redAccent;
        break;
      case 3:
        return Colors.yellow[800];
        break;
      default:
        return Colors.blue;
    }
  }

  getShadow() {
    if (isLoading) return Colors.grey.withOpacity(0.2);
    switch (_hospitalPage.check) {
      case 0:
        return Colors.blue.withOpacity(0.2);
        break;
      case 1:
        return Colors.greenAccent.withOpacity(0.2);
        break;
      case 2:
        return Colors.redAccent.withOpacity(0.2);
        break;
      case 3:
        return Colors.yellowAccent.withOpacity(0.2);
        break;
      default:
        return Colors.white.withOpacity(0.5);
    }
  }

  getStatus() {
    if (isLoading)
      return SizedBox(
          width: 0.05.sh,
          height: 0.05.sh,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 10,
            ),
          ));
    switch (_hospitalPage.check) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_rounded, size: 80, color: Colors.white),
            Text(
              "Press to check Hospital",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            )
          ],
        );
        break;
      case 1:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.check_rounded, size: 80, color: Colors.white),
          Text(
            _hospitalPage.status,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          )
        ]);
        break;
      case 2:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.clear_rounded, size: 80, color: Colors.white),
          Text(
            _hospitalPage.status,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          )
        ]);
        break;
      case 3:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.error_rounded, size: 80, color: Colors.white),
          Text(
            _hospitalPage.status,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          )
        ]);
        break;
      default:
        return Icon(Icons.location_on_rounded, size: 80);
    }
  }

  getDistanceColor(double distance) {
    if (distance < 10) return Colors.green[800];
    if (distance < 20) return Colors.yellow[800];
    return Colors.red;
  }

  getTop3() {
    if (_hospitalPage.top3 == null) return SizedBox.shrink();
    return Column(
      children: _hospitalPage.top3
          .map((e) => Padding(
                padding: EdgeInsets.all(5),
                child: ListTile(
                  onTap: () => openMap(e.name, e.street),
                  tileColor: Colors.white,
                  title: Text(e.name),
                  subtitle: Text(e.street),
                  trailing: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    children: [
                      Text("${e.distance} mile",
                          style:
                              TextStyle(color: getDistanceColor(e.distance))),
                      e.er ? ERIcon() : SizedBox(width: 40),
                      e.ur ? URIcon() : SizedBox(width: 40),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  getHeader() {
    return Center(
      child: Column(children: [
        Text(
          _hospitalPage.name ?? "",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white),
        ),
        Text(
          _hospitalPage.address ?? "",
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
          padding: const EdgeInsets.fromLTRB(7, 8, 7, 8),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   color: Colors.white,
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ERIcon(),
              const Text("=",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
              const Text("Emergency services",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
              // Switch.adaptive(
              //     value: er,
              //     onChanged: (value) => setState(() {
              //           er = value;
              //         }))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.fromLTRB(7, 8, 7, 8),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5),
          //   color: Colors.white,
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const URIcon(),
              const Text("=",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
              const Text("Urgent care services",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
              // Switch.adaptive(
              //     value: ur,
              //     onChanged: (value) => setState(() {
              //           ur = value;
              //         })),
            ],
          ),
        )
      ],
    );
  }

  _showResult() {
    if (listSearch.isNotEmpty)
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: listSearch.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              child: ListTile(
                title: Text(listSearch[index]),
                trailing: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            );
          });
    else
      return Container(
        child: ListTile(
          title: Text("The hospital is out-of-network or cannot be found"),
        ),
      );
  }

  _buildSearchHospital() {
    return FloatingSearchBar(
        hint: 'Check for a specific hospital',
        // scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
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
              color: Colors.white,
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
    return Scaffold(
        key: _hospitalKey,
        // backgroundColor: Colors.deepPurple[600],
        body: Stack(
            fit: StackFit.loose,
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => isLoading ? null : submit(),
                        child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: getShadow(),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3)),
                                ],
                                border: Border.all(width: 0.5),
                                color: getColor(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            width: 0.2.sh,
                            height: 0.2.sh,
                            child: getStatus()),
                      ),
                    ),
                    _hospitalPage.name == null || _hospitalPage.name.isEmpty
                        ? getPageIntroduction()
                        : getHeader(),
                    getTop3()
                  ],
                ),
              ),
              _buildSearchHospital(),
            ]));
  }

  @override
  bool get wantKeepAlive => true;
}
