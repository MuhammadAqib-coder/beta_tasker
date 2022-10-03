class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error while communicating');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'invalid request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, 'unAthorized request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, 'invalid input request');
}

class SigninSignupException extends AppException {
  SigninSignupException([String? message]) : super(message);
}
