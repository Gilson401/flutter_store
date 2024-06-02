import 'package:flutter/material.dart';
import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/view/widgets/responsive_wrapper.dart';
import 'package:get/get.dart';
import 'package:flutter_store/routes/app_pages.dart';
import './util/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MaterialTheme theme = const MaterialTheme(Typography.englishLike2021);
  await startModules();
  runApp(
    GetMaterialApp(
      title: 'Flutter Fake Store',
      debugShowCheckedModeBanner: false,
      theme: theme.lightMediumContrast(),
      darkTheme: theme.darkMediumContrast(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknown,
      builder: (context, child) {
        return ResponsiveWrapper(
          child: child,
        );
      },
    ),
  );
}
