import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/class/class.dart';

class CheckHospitalProvider extends ChangeNotifier {
  bool _isLoading = false, _ur = false, _er = false, _isSearching = false;
  late HospitalPage _hospitalPage;
  late Box box;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get ur => _ur;
  bool get er => _er;
  String get status => _hospitalPage.status!;
  int get checkCode => _hospitalPage.check!;
  CheckHospitalProvider() {
    _hospitalPage = HospitalPage();
  }
}
