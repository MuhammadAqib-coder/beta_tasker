abstract class BasicAuthService {
  Future<void> signInResponse(String email, String password);
  Future<void> signUpResponse(String email, String password);
}
