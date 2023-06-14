import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/app.dart';
import 'package:hospital_stay_helper/class/class.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CheckHospitalProvider extends ChangeNotifier {
  bool _isLoading = false, ur = false, er = false, _isSearching = false;
  late HospitalPage _hospitalPage;
  late Box box;
  List<SearchResult> listSearch = [];
  HospitalPage get hospitalPage => _hospitalPage;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String get status => _hospitalPage.status!;
  int get checkCode => _hospitalPage.check!;

  CheckHospitalProvider() {
    _hospitalPage = HospitalPage();
    box = Hive.box('checkHospitalPage');
    String tmp = box.get('checkHospital', defaultValue: "");
    if (tmp.isNotEmpty) {
      _hospitalPage = HospitalPage.fromJson(jsonDecode(tmp));
    }
  }
  void setER(bool value) {
    er = value;
    notifyListeners();
  }

  void setUR(bool value) {
    ur = value;
    notifyListeners();
  }

  void openMap(String name, String street) async {
    Uri uri;
    if (Platform.isIOS) {
      uri = Uri.https("maps.apple.com", "", {'q': '$name $street'});
    } else {
      uri = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '$name $street'});
    }
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
      observer.analytics.logEvent(
          name: 'open_map', parameters: {'name': name, 'street': street});
    } else {
      throw 'Could not launch $uri';
    }
  }

  void searchHospital(String keyword, BuildContext context) async {
    _isSearching = true;
    notifyListeners();
    var tbox = Hive.box('profile');
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
          if (response.statusCode == 200) {
            Iterable tmp = jsonDecode(response.body)['body'];
            listSearch = List<SearchResult>.from(
                tmp.map((e) => SearchResult.fromJson(e)));
            notifyListeners();
          }
        } else {
          showError("No internet connection");
        }
      } else {
        showProviderError(context);
      }
    } catch (e) {
      showError(e);
    }
    _isSearching = false;
    notifyListeners();
    observer.analytics
        .logEvent(name: 'search_hospital', parameters: {'keyword': keyword});
  }

  void checkHospital(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    var tbox = Hive.box('profile');
    String provider = tbox.get('user_provider', defaultValue: "");
    try {
      if (provider.isNotEmpty) {
        _hospitalPage.status = "Getting your position";
        notifyListeners();
        Position position = await _determinePosition();
        _hospitalPage.status = "Checking...";
        notifyListeners();
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
            _hospitalPage = HospitalPage.fromJson(jsonDecode(response.body));
            notifyListeners();
            box.put('checkHospital', response.body);
          }
        } else {
          showError("No internet connection");
        }
      } else {
        showProviderError(context);
      }
    } catch (e) {
      showError(e);
    }
    _isLoading = false;
    notifyListeners();
    observer.analytics.logEvent(name: 'check_hospital');
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
        timeLimit: const Duration(seconds: 20),
        desiredAccuracy: LocationAccuracy.high);
  }

  showError(error) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(error.toString()),
    ));
  }

  showProviderError(BuildContext context) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: const Text("You haven't selected a provider"),
      action: SnackBarAction(
        label: 'SETTINGS',
        onPressed: () => Navigator.pushNamed(context, '/profile'),
      ),
    ));
  }
}
