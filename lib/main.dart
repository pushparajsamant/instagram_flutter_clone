import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter_clone/responsive/web_screen_layout.dart';
import 'package:instagram_flutter_clone/screens/home_page.dart';
import 'package:instagram_flutter_clone/screens/login_page.dart';
import 'package:instagram_flutter_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCfkFhTOHEe36PBcmBV7VK6Zd6MsvNJ_cg',
        appId: '1:721262394165:web:227755d2d2a6656934aa7c',
        messagingSenderId: '721262394165',
        projectId: 'instagramclone-22bba',
        storageBucket: 'instagramclone-22bba.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _firebaseAuth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      home: StreamBuilder(
        stream: _firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ResponsiveLayoutScreen(
                  mobileScreenLayout: MobileScreenLayout(screen: HomePage()),
                  webScreenLayout: WebScreenLayout(screen: HomePage()));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: primaryColor);
          }
          return const ResponsiveLayoutScreen(
              mobileScreenLayout: MobileScreenLayout(screen: LoginPage()),
              webScreenLayout: WebScreenLayout(screen: LoginPage()));
        },
      ),
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
    );
  }
}
