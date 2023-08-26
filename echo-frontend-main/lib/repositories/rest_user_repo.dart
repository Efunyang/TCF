import 'dart:io';

import 'package:dio/dio.dart';
import 'package:echo_frontend/app_config.dart';
import 'package:echo_frontend/models/user.dart';
import 'package:echo_frontend/repositories/interfaces/intf_user_repo.dart';
import 'package:echo_frontend/utils/in_memory_store.dart';
import 'package:echo_frontend/utils/net_utils.dart';

class RestUserRepo extends IntfUserRepo {
  RestUserRepo({this.addDelay = false});
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
    try {
      final responseData = await NetUtils().reqeust(
        ApiUrl.fetchProfile(id)[1],
        method: ApiUrl.fetchProfile(id)[0],
        token: token,
      );
      final model = User.fromJson(responseData['data']);
      return model;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateAvatar({required String token, required File avatar}) async {
    try {
      final FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split('/').last,
        )
      });
      await NetUtils().reqeust(
        ApiUrl.updateAvatar(_user.value!.uid!)[1],
        method: ApiUrl.updateAvatar(_user.value!.uid!)[0],
        postData: formData,
        token: token,
      );
    } catch (_) {
      rethrow;
    }
  }
}
