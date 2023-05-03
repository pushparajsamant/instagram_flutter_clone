import "package:flutter/material.dart";

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key, required this.screen}) : super(key: key);
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
    );
  }
}
