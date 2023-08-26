import 'package:echo_frontend/app_config.dart';
import 'package:echo_frontend/models/auth.dart';
import 'package:echo_frontend/repositories/interfaces/intf_auth_repo.dart';
import 'package:echo_frontend/utils/in_memory_store.dart';
import 'package:echo_frontend/utils/net_utils.dart';

class RestAuthRepo extends IntfAuthRepo {
  RestAuthRepo({this.addDelay = false});
  final bool addDelay;
  final _authState = InMemoryStore<Auth?>(null);

  @override
  Stream<Auth?> authStateChanges() => _authState.stream;

  @override
  Auth? get currentAuth => _authState.value;

  @override
  void dispose() => _authState.close();

  @override
  Future<void> logIn({required String email, required String password}) async {
    try {
      final res = await NetUtils().reqeust(
        ApiUrl.logIn[1],
        method: ApiUrl.logIn[0],
        postData: {'email': email, 'password': password},
      );
      final auth = Auth.fromJson(res['data']);
      _authState.value = auth;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logOut({required String token}) async {
    try {
      await NetUtils().reqeust(
        ApiUrl.logOut[1],
        method: ApiUrl.logOut[0],
        token: token,
      );
      _authState.value = null;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> refreshToken({required String token, required String refreshToken}) async {
    try {
      final res = await NetUtils().reqeust(
        ApiUrl.refreshToken[1],
        method: ApiUrl.refreshToken[0],
        postData: {'refresh': refreshToken},
        token: token,
      );
      final auth = Auth.fromJson(res['data']);
      _authState.value = auth;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await NetUtils().reqeust(
        ApiUrl.signUp[1],
        method: ApiUrl.signUp[0],
        postData: {'email': email, 'password': password},
      );
    } catch (_) {
      rethrow;
    }
  }
}
