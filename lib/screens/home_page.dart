import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text("Home Screen"),
          ElevatedButton(
              onPressed: () {
                _firebaseAuth.signOut();
              },
              child: const Text("Logout"))
        ],
      )),
    );
  }
}
