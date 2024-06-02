import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class LocalStorage {
  Future<String?> get(String key);
  Future<void>  set(String key, dynamic value);
  Future<void>  remove(String key);
}

class SharePreferencesImpl implements LocalStorage {
  late SharedPreferences? _prefs;

  Future<dynamic> _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  @override
  Future<String?> get(String key) async {
    await _getInstance();
    return _prefs?.getString(key);
  }

  @override
  Future<void> set(String key, dynamic value) async {
    await _getInstance();
    await _prefs?.setString(key, jsonEncode(value));
  }

  @override
  Future<void> remove(String key) async {
    await _getInstance();
    await _prefs?.remove(key);
  }
}
