import 'dart:io';

import 'package:echo_frontend/constants/test_auth.dart';
import 'package:echo_frontend/models/user.dart';
import 'package:echo_frontend/repositories/interfaces/intf_user_repo.dart';
import 'package:echo_frontend/utils/delay.dart';
import 'package:echo_frontend/utils/in_memory_store.dart';

class FakeUserRepo extends IntfUserRepo {
  FakeUserRepo({this.addDelay = true});
  final bool addDelay;
  final _user = InMemoryStore<User?>(null);

  @override
  Stream<User?> userStateChanges() => _user.stream;

  @override
  User? get getUser => _user.value;

  @override
  void dispose() => _user.close();

  @override
  void setUser({required User user}) {
    _user.value = user;
  }

  @override
  Future<User> fetchProfile({required String token, required String id}) async {
    await delay(addDelay);
    return kUsers[0];
  }

  @override
  Future<void> updateAvatar({required String token, required File avatar}) async {
    await delay(addDelay);
  }
}
