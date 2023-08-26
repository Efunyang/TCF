import 'package:echo_frontend/app_config.dart';
import 'package:echo_frontend/models/user.dart';
import 'package:echo_frontend/repositories/fake/fake_user_repo.dart';
import 'package:echo_frontend/repositories/interfaces/intf_user_repo.dart';
import 'package:echo_frontend/repositories/rest_user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repo_provider.g.dart';

@Riverpod(keepAlive: true)
IntfUserRepo userRepo(UserRepoRef ref) {
  final user = kUseFakeRepos ? FakeUserRepo() : RestUserRepo();
  ref.onDispose(() => user.dispose());
  return user;
}

@Riverpod(keepAlive: true)
Stream<User?> userStateChanges(UserStateChangesRef ref) {
  final userRepository = ref.watch(userRepoProvider);
  return userRepository.userStateChanges();
}
