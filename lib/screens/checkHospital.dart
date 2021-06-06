import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hospital_stay_helper/class/class.dart';
import 'package:hospital_stay_helper/class/sharePref.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

import '../app.dart';

class HospitalSearchPage extends StatefulWidget {
  HospitalSearchPage({Key key}) : super(key: key);

  @override
  _CheckHospitalPage createState() => _CheckHospitalPage();
}

class _CheckHospitalPage extends State<HospitalSearchPage>
    with AutomaticKeepAliveClientMixin<HospitalSearchPage> {
  final GlobalKey<ScaffoldState> _hospitalKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  HospitalPage _hospitalPage;
  openMap(String place) async {
    Uri googleUrl = Uri.https(
        'www.google.com', '/maps/search/', {'api': '1', 'query': place});
    if (await canLaunch(googleUrl.toString())) {
      await launch(googleUrl.toString());
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  submit() async {
    setState(() {
      isLoading = true;
    });
    String provider =
        await MySharedPreferences.instance.getStringValue('user_provider');
    if (provider != null)
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
                  throw ("Error");
                }
              }).catchError((onError) {
                throw (onError);
              }))
          .catchError((onError) => throw (onError));
    else
      rootScaffoldMessengerKey.currentState.showSnackBar(SnackBar(
        content: Text("You haven't select a provider"),
      ));
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
        return Colors.white;
        break;
      case 1:
        return Colors.greenAccent;
        break;
      case 2:
        return Colors.redAccent;
        break;
      case 3:
        return Colors.yellow;
        break;
      default:
        return Colors.white;
    }
  }

  getShadow() {
    if (isLoading) return Colors.grey.withOpacity(0.5);
    switch (_hospitalPage.check) {
      case 0:
        return Colors.grey.withOpacity(0.5);
        break;
      case 1:
        return Colors.greenAccent.withOpacity(0.5);
        break;
      case 2:
        return Colors.redAccent.withOpacity(0.5);
        break;
      case 3:
        return Colors.yellowAccent.withOpacity(0.5);
        break;
      default:
        return Colors.white.withOpacity(0.5);
    }
  }

  getStatus() {
    if (isLoading)
      return SizedBox(
          width: 0.15.sh,
          height: 0.15.sh,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 10,
            ),
          ));
    switch (_hospitalPage.check) {
      case 0:
        return Icon(Icons.location_on_rounded, size: 80);
        break;
      case 1:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.check_rounded, size: 80, color: Colors.white),
          Text(_hospitalPage.status, textAlign: TextAlign.center)
        ]);
        break;
      case 2:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.clear_rounded, size: 80, color: Colors.white),
          Text(_hospitalPage.status, textAlign: TextAlign.center)
        ]);
        break;
      case 3:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.error_rounded, size: 80, color: Colors.white),
          Text(
            _hospitalPage.status,
            textAlign: TextAlign.center,
          )
        ]);
        break;
      default:
        return Icon(Icons.location_on_rounded, size: 80);
    }
  }

  getDistanceColor(double distance) {
    if (distance < 1) return Colors.green;
    if (distance < 2) return Colors.yellow[600];
    return Colors.red;
  }

  getTop3() {
    if (_hospitalPage.top3 == null) return Container();
    return Column(
      children: _hospitalPage.top3
          .map((e) => Padding(
                padding: EdgeInsets.all(5),
                child: ListTile(
                  onTap: () => openMap(e.name),
                  tileColor: Colors.white,
                  title: Text(e.name),
                  trailing: Text("${e.distance} mile",
                      style: TextStyle(color: getDistanceColor(e.distance))),
                ),
              ))
          .toList(),
    );
  }

  getHeader() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    ]);
  }

  getPageIntroduction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Padding(
        //     child: Text("Find In-Network Hospital",
        //         style: TextStyle(
        //             fontSize: 30,
        //             fontWeight: FontWeight.w800,
        //             color: Colors.white)),
        //     padding: EdgeInsets.fromLTRB(2, 40, 2, 0)),
        // Padding(
        //     child: Card(
        //       color: Colors.white,
        //       child: Padding(
        //           child: Flexible(
        //             flex: 5,
        //             child: Text(
        //               "View + verify nearby in-network hospitals, based on your insurance provider.",
        //               style: TextStyle(fontSize: 16),
        //             ),

        //             // ExpandablePanel(
        //             //   expanded: Text(
        //             //       "View nearby in-network hospitals, based on your insurance provider setting in Your Profile.\nIf you're at a hospital now, click the square to check if it is in-network.",
        //             //       softWrap: true,
        //             //       style: TextStyle(
        //             //           fontSize: 16,
        //             //           fontWeight: FontWeight.w500,
        //             //           color: Colors.black)),
        //             //   collapsed: Text(
        //             //     "View nearby in-network hospitals, based on your insurance provider setting in Your Profile.\nIf you're at a hospital now, click the square to check if it is in-network.",
        //             //     softWrap: true,
        //             //     maxLines: 1,
        //             //     overflow: TextOverflow.ellipsis,
        //             //     style: TextStyle(
        //             //         fontSize: 16,
        //             //         fontWeight: FontWeight.w500,
        //             //         color: Colors.black),
        //             //   ),
        //             // )
        //           ),
        //           padding: EdgeInsets.fromLTRB(15, 11, 15, 11)),
        //     ),
        //     padding: EdgeInsets.fromLTRB(0, 12, 0, 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _hospitalKey,
        // backgroundColor: Colors.deepPurple[600],
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                flex: 3,
                child: _hospitalPage.name == null || _hospitalPage.name.isEmpty
                    ? getPageIntroduction()
                    : getHeader(),
                fit: FlexFit.tight),
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () => isLoading ? null : submit(),
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: getShadow(),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                        color: getColor(),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 0.25.sh,
                    height: 0.25.sh,
                    child: getStatus()),
              ),
            ),
            Flexible(child: getTop3(), flex: 3)
          ],
        )));
  }

  @override
  bool get wantKeepAlive => true;
}
