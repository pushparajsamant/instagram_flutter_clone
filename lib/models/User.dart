import 'dart:core';

class User {
  final String email;
  final String username;
  final String bio;
  final String imageUrl;

  User(
      {required this.email,
      required this.username,
      required this.bio,
      required this.imageUrl});
}
