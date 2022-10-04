import 'package:beta_tasker/repository/auth_repo.dart';
import 'package:beta_tasker/utils/utils.dart';

class AuthViewModel {
  final AuthRepo _repo = AuthRepo();

  Future emailPassLogin(String email, String password, context) async {
    _repo.emailPassLogin(email, password).then((value) {
      Utils.displaySnackbar(context, 'Succesfully Login');
    }).onError((error, stackTrace) =>
        Utils.displaySnackbar(context, error.toString()));
  }

  Future emailPassSignup(String email, String password, context) async {
    _repo.emailPassSignup(email, password).onError((error, stackTrace) =>
        Utils.displaySnackbar(context, error.toString()));
  }

  Future googleSignup(context) async {
    _repo.googleSignup().onError((error, stackTrace) =>
        Utils.displaySnackbar(context, error.toString()));
  }

  Future facebookSignup(context) async {
    _repo.facebookSignup().onError((error, stackTrace) =>
        Utils.displaySnackbar(context, error.toString()));
  }
}
