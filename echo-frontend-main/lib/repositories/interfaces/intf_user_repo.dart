import 'dart:io';

import 'package:echo_frontend/models/user.dart';

abstract class IntfUserRepo {
  Stream<User?> userStateChanges();
  User? get getUser;

  void dispose();
  void setUser({required User user});

  Future<User> fetchProfile({required String token, required String id});
  Future<void> updateAvatar({required String token, required File avatar});
}
