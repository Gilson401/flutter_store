import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/util/text_styles.dart';
import 'package:flutter_store/util/url_launcher.dart';

class RichTextLink extends StatelessWidget {
  final String mylLink;
  final String? linkText;

  const RichTextLink({super.key, required this.mylLink, this.linkText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: linkText ?? mylLink,
            style:  AppTextStyles.s12w700cGray,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await AppUrLauncher().launchUrlIfPossible(mylLink);
              },
          ),
        ],
      ),
    );
  }
}
