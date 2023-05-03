//
//  AHI
//
//  Copyright (c) AHI. All rights reserved.
//
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:image_picker/image_picker.dart";
import "package:instagram_flutter_clone/screens/login_page.dart";
import "package:instagram_flutter_clone/utils/colors.dart";
import "package:instagram_flutter_clone/utils/global_variable.dart";
import "package:instagram_flutter_clone/utils/utils.dart";
import "package:instagram_flutter_clone/widgets/text_field_input.dart";

import "../resources/auth_methods.dart";
import "../responsive/mobile_screen_layout.dart";
import "../responsive/responsive_layout_screen.dart";
import "../responsive/web_screen_layout.dart";

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signupUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final result = await AuthMethods().signupUser(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      username: _usernameController.text,
      file: _image!,
    );
    if (result != success) {
      showSnackBar(context, result);
    }
    setState(() {
      isLoading = false;
    });
  }

  final ImagePicker picker = ImagePicker();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _usernameController = TextEditingController();
  Uint8List? _image;
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
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://static.vecteezy.com/system/resources/previews/002/534/006/original/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector.jpg"),
                        ),
                  Positioned(
                    top: 80,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo, color: Colors.blue),
                      onPressed: () async {
                        final XFile? file =
                            await picker.pickImage(source: ImageSource.gallery);
                        // Doing this since File class is not supported on web
                        final imageData = await file?.readAsBytes();
                        setState(() {
                          _image = imageData;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              //email
              TextFieldInput(
                controller: _usernameController,
                textInputType: TextInputType.text,
                hintText: "Enter your username",
              ),
              const SizedBox(
                height: 24,
              ),
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
              TextFieldInput(
                controller: _bioController,
                textInputType: TextInputType.text,
                hintText: "Enter your bio",
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () async {
                    signupUser(context);
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: const Text(
                      'Login.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResponsiveLayoutScreen(
                            mobileScreenLayout: MobileScreenLayout(
                              screen: LoginPage(),
                            ),
                            webScreenLayout:
                                WebScreenLayout(screen: LoginPage()),
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
