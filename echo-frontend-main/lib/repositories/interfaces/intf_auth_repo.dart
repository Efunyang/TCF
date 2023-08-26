import 'package:echo_frontend/models/auth.dart';

abstract class IntfAuthRepo {
  Stream<Auth?> authStateChanges();
  Auth? get currentAuth;

  void dispose();

  Future<void> logIn({required String email, required String password});
  Future<void> signUp({required String email, required String password});
  Future<void> logOut({required String token});
  Future<void> refreshToken({required String token, required String refreshToken});
}
