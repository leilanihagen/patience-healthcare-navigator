import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';

class UserProvider extends ChangeNotifier {
  String? _insuranceProvider;
  String? _state;
  String? _plan;
  String? _phoneNumber;
  String? get insuranceProvider => _insuranceProvider;
  String? get state => _state;
  String? get plan => _plan;
  late Box box;
  UserProvider() {
    box = Hive.box('profile');
    _insuranceProvider = box.get('user_provider');
    _state = box.get('user_state');
    _plan = box.get('user_plan');
    _phoneNumber = box.get('provider_phone');
  }
  void changeInsuranceProvider(String? value) {
    _insuranceProvider = value;
    notifyListeners();
    box.put('user_provider', value);
    observer.analytics
        .logEvent(name: 'set_provider', parameters: {'provider': value});
    loadProviderInfo(_insuranceProvider);
  }

  void changeState(String? value) {
    _state = value;
    notifyListeners();
    box.put('user_state', value);
    observer.analytics
        .logEvent(name: 'set_state', parameters: {'state': value});
  }

  void loadProviderInfo(String? provider) async {
    final String temp =
        await rootBundle.loadString('assets/data/provider.json');
    final data = await jsonDecode(temp);
    _phoneNumber = data[provider]['phone'];
    box.put('provider_phone', _phoneNumber);
  }
}
