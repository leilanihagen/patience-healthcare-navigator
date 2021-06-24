import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  setDoubleValue(String key, double value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setDouble(key, value);
  }

  Future<double> getDoubleValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getDouble(key);
  }

  setBoolValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBoolValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

  // setStringListValue(String key, List value) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   myPrefs.setStringList(key, value);
  // }

  // appendStringListValue(String key, String value) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   List list = myPrefs.getStringList(key);
  //   list.add(value);
  //   myPrefs.setStringList(key, list);
  // }

  // Future<String> getStringListValue(String key) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   return myPrefs.getStringList(key) ?? "";
  // }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }
}
