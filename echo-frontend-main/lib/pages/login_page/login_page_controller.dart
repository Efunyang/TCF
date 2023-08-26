import 'package:echo_frontend/services/provider/auth_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_page_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<bool> submit({required String email, required String password}) async {
    final authRepository = ref.read(authServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.logIn(email: email, password: password));
    return state.hasError == false;
  }
}
