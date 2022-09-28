abstract class BasicFirebaseService {
  Future<dynamic> signInResponse(String email, String password);
  Future<dynamic> signUpResponse(String email, String password);
}
