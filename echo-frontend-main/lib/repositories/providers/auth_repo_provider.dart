import 'package:echo_frontend/app_config.dart';
import 'package:echo_frontend/models/auth.dart';
import 'package:echo_frontend/repositories/fake/fake_auth_repo.dart';
import 'package:echo_frontend/repositories/interfaces/intf_auth_repo.dart';
import 'package:echo_frontend/repositories/rest_auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo_provider.g.dart';

@Riverpod(keepAlive: true)
IntfAuthRepo authRepo(AuthRepoRef ref) {
  final auth = kUseFakeRepos ? FakeAuthRepo() : RestAuthRepo();
  ref.onDispose(() => auth.dispose());
  return auth;
}

@Riverpod(keepAlive: true)
Stream<Auth?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepoProvider);
  return authRepository.authStateChanges();
}
