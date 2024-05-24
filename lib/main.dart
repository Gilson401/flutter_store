import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_store/routes/app_pages.dart';
import './util/theme.dart';

void main() {
  MaterialTheme theme = const MaterialTheme(Typography.englishLike2021);
  runApp(   
     GetMaterialApp(
      title: 'Fake Store',
      debugShowCheckedModeBanner: false,
      theme:  theme.lightMediumContrast(),
      darkTheme: theme.darkMediumContrast(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
  
}
