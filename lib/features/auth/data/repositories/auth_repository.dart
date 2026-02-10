import 'package:amritha_ayurveda/features/auth/data/repositories/auth_api.dart';
import 'package:amritha_ayurveda/features/auth/data/models/login_response.dart';

class AuthRepository {
  final AuthApi _api;

  AuthRepository(this._api);

  Future<LoginResponse> login(String username, String password) async {
    return await _api.login(username, password);
  }
}
