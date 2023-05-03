import "package:flutter/material.dart";
import "package:instagram_flutter_clone/utils/global_variable.dart";

class ResponsiveLayoutScreen extends StatelessWidget {
  const ResponsiveLayoutScreen(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return webScreenLayout;
      }
      return mobileScreenLayout;
    });
  }
}
