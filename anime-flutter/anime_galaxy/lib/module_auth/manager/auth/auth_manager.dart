import 'package:anime_galaxy/module_auth/request/login/login_request.dart';
import 'package:anime_galaxy/module_auth/request/register/registerRequest.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_auth/repository/auth/auth_repository.dart';

@provide
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<bool> register(RegisterRequest request)
  => _authRepository.register(request);

  Future<bool> login(LoginRequest request)async =>
     await _authRepository.login(request);
}
