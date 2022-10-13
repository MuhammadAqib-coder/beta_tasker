import 'package:beta_tasker/repository/auth_repo.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel {
  final AuthRepo _repo = AuthRepo();

  Future emailPassLogin(String email, String password, context) async {
    await _repo.emailPassLogin(email, password).then((value) {
      Utils.displaySnackbar(context, 'Succesfully Login');
    }).onError((error, stackTrace) =>
        Utils.displaySnackbar(context, error.toString()));
  }

  Future emailPassSignup(String email, String password, context) async {
    await _repo.emailPassSignup(email, password).then((value) {
      Utils.displaySnackbar(context, 'Successfully SignUp');
      // Navigator.pushNamed(context, RoutesName.signinView);
    }).onError((error, stackTrace) =>
        Utils.displaySnackbar(context, error.toString()));
  }

  Future googleSignup(context) async {
    await _repo
        .googleSignup()
        .then((value) => Utils.displaySnackbar(context, 'Successfuly Login'))
        .onError((error, stackTrace) =>
            Utils.displaySnackbar(context, error.toString()));
  }

  Future facebookSignup(context) async {
    await _repo
        .facebookSignup()
        .then((value) => Utils.displaySnackbar(context, 'Successfuly Login'))
        .onError((error, stackTrace) =>
            Utils.displaySnackbar(context, error.toString()));
  }

  Future resetPassword(String email, context) async {
    await _repo
        .resetPassword(email)
        .then((value) => Utils.displaySnackbar(context, 'Email send'))
        .onError((error, stackTrace) =>
            Utils.displaySnackbar(context, error.toString()));
  }
}
