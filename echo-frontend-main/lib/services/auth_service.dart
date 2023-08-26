import 'package:echo_frontend/models/auth.dart';
import 'package:echo_frontend/repositories/providers/auth_repo_provider.dart';
import 'package:echo_frontend/repositories/providers/user_repo_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  Auth? getAuth() {
    return ref.read(authRepoProvider).currentAuth;
  }

  Stream<Auth?> authStateChanges() {
    return ref.watch(authRepoProvider).authStateChanges();
  }

  Future<void> logIn({required String email, required String password}) async {
    final authRepo = ref.read(authRepoProvider);
    await authRepo.logIn(email: email, password: password);

    final userRepo = ref.read(userRepoProvider);
    final user = await userRepo.fetchProfile(
      token: authRepo.currentAuth!.token!,
      id: authRepo.currentAuth!.uid!,
    );
    userRepo.setUser(user: user);
  }
}
