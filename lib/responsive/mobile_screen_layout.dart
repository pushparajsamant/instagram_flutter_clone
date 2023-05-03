import "package:flutter/material.dart";

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key, required this.screen}) : super(key: key);
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
    );
  }
}
