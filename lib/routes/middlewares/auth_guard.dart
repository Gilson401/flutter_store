import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/auth_controller.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:get/get.dart';

class OnlyLoggedAllowed extends GetMiddleware {

  final authService =  Get.put(AuthController());
  
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
      if (authService.user.value != null) {
        return null;
      }
      return const RouteSettings(name: Routes.login);
  }
}

class SendLoggedToHome extends GetMiddleware {

  final authService =  Get.put(AuthController());
  
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
      if (!authService.hasValidLocalUser()) {
        return null;
      }
      return const RouteSettings(name: Routes.home);
  }
}