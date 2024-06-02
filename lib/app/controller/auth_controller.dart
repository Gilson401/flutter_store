import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_store/app/model/auth_service.dart';
import 'package:flutter_store/app/model/local_storage.dart';
import 'package:flutter_store/app/model/local_storage_keys.dart';
import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/user_manager.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _localDataSource = inject<LocalStorage>();

  final _service = inject<AuthService>();

  Rx<UserManager?> user = Rx<UserManager?>(null);

  RxString error = 'Not Errors'.obs;

  Future<void> setError(String err) async {
    error.value = err;
    update();
  }

  RxBool loading = false.obs;
  Future<void> setLoading(bool bvalue) async {
    loading.value = bvalue;
    update();
  }

  bool isLoading() {
    return loading.value;
  }

  @override
  void onInit() {
    _loadUserFromLocalStorage();
    super.onInit();
  }

  _setUser(UserManager? userParam) {
    user.value = userParam;
    update();
  }

  bool hasValidLocalUser() {
    return user.value != null;
  }

  void _loadUserFromLocalStorage() async {
    dynamic locaUser = await _localDataSource.get(LocalStorageKeys.localUser);

    if (locaUser == null) {
      return;
    }

    dynamic localUserDecded = jsonDecode(jsonDecode(locaUser));
  
    try {
      UserManager userManager = UserManager.fromJson(localUserDecded);

      if (locaUser != null) {
        _setUser(userManager);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }





  Future<bool> login({required String email, required String password}) async {
    setLoading(true);

    try {
      final response = await _service.login(email, password);
      if (!response.isSuccess) {
        setError(response.message ?? 'Erro Ao tentar efetuar o login');
        return false;
      }

      UserManager userManager = response.data;
      String userManagerToJson = userManager.toJson();

      await _localDataSource.set(LocalStorageKeys.localUser, userManagerToJson);

      _setUser(userManager);
      update();
    } on Exception catch (e) {
      setError(e.toString());
      update();
      return false;
    } finally {
      setLoading(false);
    }
    return true;
  }

  Future<void> logOff() async {
    await _localDataSource.remove(LocalStorageKeys.localUser);
    _setUser(null);
  }
}
