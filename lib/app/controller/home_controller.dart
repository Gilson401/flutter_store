import 'package:flutter_store/app/controller/click_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final click = Get.put(Click(tap: 10));
}