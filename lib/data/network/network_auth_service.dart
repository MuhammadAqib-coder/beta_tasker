import 'dart:io';

import 'package:beta_tasker/data/app_exception.dart';
import 'package:beta_tasker/data/network/basic_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NetworkAuthService extends BasicAuthService {
  @override
  signInResponse(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      throw SigninSignupException('successfully Login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UnauthorizedException('user not registered');
      } else if (e.code == 'wrong-password') {
        throw InvalidInputException('wrong password');
      } else {
        throw SigninSignupException(e.message);
      }
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
  }

  @override
  Future signUpResponse(String email, String password) async {
    try {} on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw SigninSignupException('weak password');
      } else if (e.code == 'email-already-in-use') {
        throw SigninSignupException('user already registered');
      } else {
        SigninSignupException(e.message);
      }
    } on SocketException {
      throw FetchDataException('no internet connection');
    }
  }
}
