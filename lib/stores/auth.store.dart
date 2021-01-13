import '../models/User.dart';
import 'package:mobx/mobx.dart';

import '../data/network/repositories/auth_repository.dart';

part 'auth.store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  AuthRepository _authRepository = AuthRepository();

  @observable
  User user;

  @observable
  bool isLoading = false;

  @action
  void setUser(User value) => user = value;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  Future auth(String email, String password) async {
    setLoading(true);
    return await _authRepository.auth(email, password).then(
      (value) async {
        return value;
      },
    ).whenComplete(
      () => setLoading(false),
    );
  }

  @action
  Future register(String name, String email, String password) async {
    setLoading(true);

    return await _authRepository.register(name, email, password).then(
      (value) async {
        return value;
      },
    ).whenComplete(
      () => setLoading(false),
    );
  }

  @action
  Future<bool> getMe() async {
    await _authRepository.getMe().then((user) => setUser(user));
  }

  @action
  Future logout() async {
    setLoading(true);
    await _authRepository.logout().whenComplete(
          () => setLoading(false),
        );
  }
}
