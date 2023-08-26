import 'package:echo_frontend/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref);
}
