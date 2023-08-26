import 'package:echo_frontend/constants/test_auth.dart';
import 'package:echo_frontend/exceptions/app_exception.dart';
import 'package:echo_frontend/models/auth.dart';
import 'package:echo_frontend/repositories/interfaces/intf_auth_repo.dart';
import 'package:echo_frontend/utils/delay.dart';
import 'package:echo_frontend/utils/in_memory_store.dart';

class FakeAuthRepo extends IntfAuthRepo {
  FakeAuthRepo({this.addDelay = true});
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
    await delay(addDelay);
    for (final u in kUsers) {
      // matching email and password
      if (u.email == email && u.email == password) {
        _authState.value = kAuths.singleWhere((element) => element.uid == u.uid);
        return;
      }
      // same email, wrong password
      if (u.email == email && u.email != password) {
        throw WrongPasswordException();
      }
    }
    throw UserNotFoundException();
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    await delay(addDelay);
    for (final u in kUsers) {
      if (u.email == email) {
        throw EmailAlreadyInUseException();
      }
    }
    // minimum password length requirement
    if (password.length < 8) {
      throw WeakPasswordException();
    }
  }

  @override
  Future<void> logOut({required String token}) async {
    await delay(addDelay);
    _authState.value = null;
  }

  @override
  Future<void> refreshToken({required String token, required String refreshToken}) async {
    await delay(addDelay);
  }
}
