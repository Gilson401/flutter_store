import 'package:flutter/material.dart';
import 'package:flutter_store/app/view/widgets/rich_text_link.dart';
import 'package:get/get.dart';

class ResponsiveWrapper extends GetResponsiveView {
  final Widget? child;
  ResponsiveWrapper({super.key, required this.child});

  Widget addBlocSpace(String link, String linkText,
          [Color color = Colors.transparent]) =>
      Expanded(
          child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(10),
            offset: const Offset(2, 0),
            blurRadius: 2.0,
          )
        ]),
        child: Center(
          child: RichTextLink(mylLink: link, linkText: linkText),
        ),
      ).paddingAll(8));

  @override
  Widget? builder() {
    const String devSiteUrl = 'http://gilsonpaulo.com.br/';
    const String engLinkedin = 'https://www.linkedin.com/in/gpsc/?locale=en_US';
    const String myLinkedin = 'https://www.linkedin.com/in/gpsc/?locale=en_US';
    const String myGit = 'https://github.com/Gilson401';

    final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
    return Material(child: Builder(builder: (_) {
      if (screen.screenType == ScreenType.Phone) {
        return Column(
          children: [
            Expanded(
                flex: 6,
                child: Scaffold(
                  key: drawerKey,
                  body: child ?? const Placeholder(),
                  drawer: Drawer(
                    child: Column(
                      children: [
                        addBlocSpace(engLinkedin, 'English Linkedin Profile'),
                        addBlocSpace(myLinkedin, 'Linkedin PT-Br'),
                        addBlocSpace(myGit, 'My Github'),
                        addBlocSpace(devSiteUrl, 'Personal Site'),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    isExtended : true,
                    onPressed: () => drawerKey.currentState!
                        .openDrawer(),
                    child: const Icon(Icons.laptop_windows_sharp), // <-- Opens drawer
                  ),
                )),
          ],
        );
      }

      if (screen.screenType == ScreenType.Tablet) {
        return Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    addBlocSpace(engLinkedin, 'English Linkedin Profile'),
                    addBlocSpace(devSiteUrl, 'Personal Site'),
                    addBlocSpace(myGit, 'My Github'),
                    addBlocSpace(myLinkedin, 'Linkedin PT-Br'),
                  ],
                )),
            Expanded(flex: 7, child: child ?? const Placeholder()),
          ],
        );
      }

      if (screen.screenType == ScreenType.Desktop) {
        return Row(
          children: [
            Expanded(
                child: Column(
              children: [
                addBlocSpace(devSiteUrl, 'Personal Site'),
                addBlocSpace(engLinkedin, 'English Linkedin Profile'),
              ],
            )),
            Expanded(flex: 2, child: child ?? const Placeholder()),
            Expanded(
                child: Column(
              children: [
                addBlocSpace(myGit, 'My Github'),
                addBlocSpace(myLinkedin, 'Linkedin PT-Br'),
              ],
            )),
          ],
        );
      }

      return child ?? const Placeholder();
    }));
  }
}
