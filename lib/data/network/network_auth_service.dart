import 'dart:io';

import 'package:beta_tasker/data/app_exception.dart';
import 'package:beta_tasker/data/network/basic_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NetworkAuthService extends BasicAuthService {
  @override
  signInResponse(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // throw SigninSignupException('successfully Login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UnauthorizedException('user not registered');
      } else if (e.code == 'wrong-password') {
        throw InvalidInputException('wrong password');
      } else if (e.code == 'invalid-email') {
        throw SigninSignupException('invalid email');
      } else {
        throw SigninSignupException(e.message);
      }
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
  }

  @override
  Future signUpResponse(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //signout the user when signup
      await FirebaseAuth.instance.signOut();
      //  throw SigninSignupException('successfully signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw SigninSignupException('weak password');
      } else if (e.code == 'email-already-in-use') {
        throw SigninSignupException('user already registered');
      } else if (e.code == 'invalid-email') {
        throw SigninSignupException('invalid email');
      } else {
        throw SigninSignupException('No Internet Connection');
      }
    } on SocketException {
      throw FetchDataException('no internet connection');
    }
  }

  @override
  Future<void> googleSignup() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await googleSignIn.signIn();
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        throw SigninSignupException('sign in canceled');
      } else if (e.code == 'sign_in_failed') {
        throw SigninSignupException('Sign in failed');
      }
    }

    if (googleUser == null) return;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // await FirebaseAuth.instance.signOut();
      //throw SigninSignupException('Successfuly Signed up');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exist-with-different-credential') {
        throw SigninSignupException(
            'account already exist with different credential');
      } else if (e.code == 'invalid-credential') {
        throw SigninSignupException(
            'Error occurred while accessing credentials. Try again.');
      } else {
        throw SigninSignupException(
            'Error occurred using Google Sign In. Try again.');
      }
    }
  }

  @override
  Future<void> facebookSignup() async {
    LoginResult loginResult;
    OAuthCredential facebookCredential;
    try {
      loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        facebookCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(facebookCredential);

        // await FacebookAuth.instance.logOut();
      }
      //throw SigninSignupException('succesfully login');
    } on FirebaseAuthException catch (e) {
      throw SigninSignupException(e.toString());
    } on PlatformException catch (e) {
      throw SigninSignupException(e.toString());
    }
  }
}
