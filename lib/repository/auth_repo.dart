import 'package:beta_tasker/data/network/basic_auth_service.dart';
import 'package:beta_tasker/data/network/network_auth_service.dart';

class AuthRepo {
  final BasicAuthService _service = NetworkAuthService();

  Future emailPassLogin(String email, String password) async {
    try {
      await _service.signInResponse(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future emailPassSignup(String email, String password) async {
    try {
      await _service.signUpResponse(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future googleSignup() async {
    try {
      await _service.googleSignup();
    } catch (e) {
      rethrow;
    }
  }

  Future facebookSignup() async {
    try {
      await _service.facebookSignup();
    } catch (e) {
      rethrow;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _service.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
