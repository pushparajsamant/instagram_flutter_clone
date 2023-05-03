//
//  AHI
//
//  Copyright (c) AHI. All rights reserved.
//
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:instagram_flutter_clone/resources/auth_methods.dart";
import "package:instagram_flutter_clone/screens/signup_page.dart";
import "package:instagram_flutter_clone/utils/colors.dart";
import "package:instagram_flutter_clone/utils/global_variable.dart";
import "package:instagram_flutter_clone/utils/utils.dart";
import "package:instagram_flutter_clone/widgets/text_field_input.dart";

import "../responsive/mobile_screen_layout.dart";
import "../responsive/responsive_layout_screen.dart";
import "../responsive/web_screen_layout.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final result = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      isLoading = false;
    });
    if (result != success) {
      showSnackBar(context, result);
    } else {
      print("Login Success");
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              //svg
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
              const SizedBox(
                height: 64,
              ),
              //email
              TextFieldInput(
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: "Enter your email",
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                controller: _passwordController,
                textInputType: TextInputType.text,
                hintText: "Enter your password",
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  loginUser(context);
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Log In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have an account?',
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: const Text(
                      'Signup.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResponsiveLayoutScreen(
                            mobileScreenLayout: MobileScreenLayout(
                              screen: SignupPage(),
                            ),
                            webScreenLayout:
                                WebScreenLayout(screen: SignupPage()),
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
              //password
              //login button
              //signup link
            ],
          ),
        ),
      ),
    );
  }
}
