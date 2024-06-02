import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url_launch;

class AppUrLauncher {
  Future<bool> canLaunchUrl(String url) async {
    if (kIsWeb) return true;
    bool canReturn = await url_launch.canLaunchUrl(Uri.parse(url));
    return canReturn;
  }

  Future<void> launchUrl(String url) async {
    await url_launch.launchUrl(Uri.parse(url));
  }

  Future<void> launchUrlIfPossible(String url) async {
    if (!url.isURL) return;

    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(url)) {
      await url_launch.launchUrl(uri);
    }
  }
}
